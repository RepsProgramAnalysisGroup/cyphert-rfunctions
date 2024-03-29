module VarMap = Map.Make(String);;

module Logger = Log

module Make (A : sig 
              type t
              val add : t -> t -> t
              val mult : t -> t -> t
              val div : t -> t -> t
              val exp : t -> t -> t
              val const : string -> t
              val to_string : t -> string
              val compare : t -> t -> int
            end) : (Sigs.AD with type base = A.t) = struct
  
  type base = A.t

  let const = A.const

  let add = A.add

  let mult = A.mult

  let to_string = A.to_string

  type op = 
    | OAdd
    | OMult
    | ODiv 
    | OExp of base
    | OVar of string
    | OConst of base

  type node = (op * int list)

  type t = node

  let node_hash = Hashtbl.hash

  module CGraph = Graph.Imperative.Digraph.ConcreteBidirectionalLabeled(struct type t = node let hash = node_hash let compare = compare let equal = (=) end )(struct type t = int let compare = compare let default = 0 end)

  let base_compare = A.compare

  module Top = Graph.Topological.Make(CGraph)

  module NodeTbl = Hashtbl.Make(struct type t = CGraph.V.t let equal = (=) let hash = node_hash end)
  module EdgeTbl = Hashtbl.Make(struct type t = CGraph.V.t * CGraph.V.t let equal = (=) let hash = Hashtbl.hash end)
  
  let res_tbl = ref None
  let edge_tbl = ref None

  let root = ref None

  let comp_graph = CGraph.create ()

  let add_node n args =
    CGraph.add_vertex comp_graph n;
    root := Some n;
    List.iteri (fun i x -> 
      let e = CGraph.E.create n i x in
      CGraph.add_edge_e comp_graph e
    ) args

  let make_add left right =
    let left_id = node_hash left in
    let right_id = node_hash right in
    let (args, arg_ids) = List.split (List.sort (fun a b -> compare (snd a) (snd b)) [(left, left_id); (right, right_id)]) in
    let new_node = (OAdd, arg_ids) in
    add_node new_node args;
    new_node

  let make_mult left right =
    let left_id = node_hash left in
    let right_id = node_hash right in
    let (args, arg_ids) = List.split (List.sort (fun a b -> compare (snd a) (snd b)) [(left, left_id); (right, right_id)]) in
    let new_node = (OMult, arg_ids) in
    add_node new_node args;
    new_node

  let make_exp base exp =
    let base_id = node_hash base in
    let new_node = (OExp exp, [base_id]) in
    add_node new_node [base];
    new_node

  let make_div left right =
    let left_id = node_hash left in
    let right_id = node_hash right in
    let (args, arg_ids) = List.split (List.sort (fun a b -> compare (snd a) (snd b)) [(left, left_id); (right, right_id)]) in
    let new_node = (ODiv, arg_ids) in
    add_node new_node args;
    new_node
  
  let make_var var = 
    let new_node = (OVar var, []) in
    add_node new_node [];
    new_node

  let make_const x =
    let new_node = (OConst (A.const x), []) in
    add_node new_node [];
    new_node

  let get_tbl () = 
    match !res_tbl with
    | Some x -> x
    | None -> failwith "Don't have results table"

  let build_complete () =
    res_tbl := Some (NodeTbl.create (CGraph.nb_vertex comp_graph));
    edge_tbl := Some (EdgeTbl.create (CGraph.nb_edges comp_graph))

  let eval assign =
    let result_tbl = get_tbl () in
    let rec aux curr = 
      let get_value v =
        try
          NodeTbl.find result_tbl v
        with Not_found -> aux v
      in
      match curr with 
      | (OVar var, []) ->
        let assignment = VarMap.find var assign in
        Logger.log ~level:`trace (var ^ ": " ^ (A.to_string assignment) ^ "\n");
        NodeTbl.add result_tbl curr assignment;
        assignment
      | (OConst x, []) ->
        Logger.log ~level:`trace ("Const: " ^ (A.to_string x) ^ "\n");
        NodeTbl.add result_tbl curr x;
        x
      | (OAdd, lst) ->
        let succs = CGraph.succ comp_graph curr in
        let left_v = get_value (List.nth succs 0) in
        let right_v = get_value (List.nth succs 1) in
        let res = A.add left_v right_v in 
        Logger.log ~level:`trace ("Add" ^ (String.concat "" (List.map string_of_int lst)) ^ ": " ^ (A.to_string res) ^ "=" ^ (A.to_string left_v) ^ " + " ^ (A.to_string right_v) ^ "\n");
        NodeTbl.add result_tbl curr res;
        res
      | (ODiv, lst) -> 
        let succs = CGraph.succ comp_graph curr in
        let left_v = get_value (List.nth succs 0) in
        let right_v = get_value (List.nth succs 1) in
        let res = A.div left_v right_v in 
        Logger.log ~level:`trace ("Div" ^ (String.concat "" (List.map string_of_int lst)) ^ ": " ^ (A.to_string res) ^ "=" ^ (A.to_string left_v) ^ " / " ^ (A.to_string right_v) ^ "\n");
        NodeTbl.add result_tbl curr res;
        res
      | (OMult, lst) ->
        let succs = CGraph.succ comp_graph curr in
        let left_v = get_value (List.nth succs 0) in
        let right_v = get_value (List.nth succs 1) in
        let res = A.mult left_v right_v in 
        Logger.log ~level:`trace ("Mult" ^ (String.concat "" (List.map string_of_int lst)) ^ ": " ^ (A.to_string res) ^ "=" ^ (A.to_string left_v) ^ " * " ^ (A.to_string right_v) ^ "\n");
        NodeTbl.add result_tbl curr res;
        res
      | (OExp n, lst) ->
        let base_v = get_value (List.nth (CGraph.succ comp_graph curr) 0) in
        let res = A.exp base_v n in
        Logger.log ~level:`trace ("Exp" ^ (String.concat "" (List.map string_of_int lst)) ^ ": " ^ (A.to_string res) ^ "=" ^ (A.to_string base_v) ^ " ** " ^ (A.to_string n) ^ "\n");
        NodeTbl.add result_tbl curr res;
        res
      | _ -> failwith "This case shouldn't be possible"
    in
    match !root with
    | Some r -> aux r
    | None -> failwith "Don't have root for evaluation"

  let grad () = 
    let result_tbl = get_tbl () in
    let edge_tab = match !edge_tbl with | Some x -> x | None -> failwith "Don't have edge table" in
    let grad_map = ref VarMap.empty in
    let r = match !root with | Some x -> x | None -> failwith "Missing root" in
    let aux curr =
      let my_adjoint = 
        (if not (CGraph.V.equal curr r) then 
          CGraph.fold_pred (fun v acc -> A.add acc (EdgeTbl.find edge_tab (v,curr))) comp_graph curr (A.const "0")
        else (A.const "1"))
      in
      (match curr with
      | (OAdd, lst) ->
        Logger.log ~level:`trace ("Add" ^ (String.concat "" (List.map string_of_int lst)) ^ " Adjoint: " ^ (A.to_string my_adjoint) ^ "\n");
        CGraph.iter_succ (fun v -> EdgeTbl.replace edge_tab (curr,v) my_adjoint) comp_graph curr
      | (OMult, lst) ->
        Logger.log ~level:`trace ("Mult" ^ (String.concat "" (List.map string_of_int lst)) ^ " Adjoint: " ^ (A.to_string my_adjoint) ^ "\n");
        let succ_v = CGraph.succ comp_graph curr in
        let v1 = List.nth succ_v 0 in 
        let v2 = List.nth succ_v 1 in
        EdgeTbl.replace edge_tab (curr, v1) (A.mult (NodeTbl.find result_tbl v2) my_adjoint);
        EdgeTbl.replace edge_tab (curr, v2) (A.mult (NodeTbl.find result_tbl v1) my_adjoint);
      | (ODiv, lst) ->
        Logger.log ~level:`trace ("Div" ^ (String.concat "" (List.map string_of_int lst)) ^ " Adjoint: " ^ (A.to_string my_adjoint) ^ "\n");
        let succ_v = CGraph.succ comp_graph curr in
        let v1 = List.nth succ_v 0 in 
        let v2 = List.nth succ_v 1 in
        EdgeTbl.replace edge_tab (curr, v1) (A.div my_adjoint (NodeTbl.find result_tbl v2));
        EdgeTbl.replace edge_tab (curr, v2) (A.mult (A.div (A.mult my_adjoint (NodeTbl.find result_tbl curr)) (NodeTbl.find result_tbl v2))  (A.const "-1"));
      | (OExp n, lst) ->
        let succ_n = List.nth (CGraph.succ comp_graph curr) 0 in
        let succ_v = NodeTbl.find result_tbl succ_n in
        Logger.log ~level:`trace ("Exp" ^ (String.concat "" (List.map string_of_int lst)) ^ " Adjoint: " ^ (A.to_string my_adjoint) ^ "\n");
        EdgeTbl.replace edge_tab (curr, succ_n) (A.mult (A.mult n (A.exp succ_v (A.add n (A.const "-1")))) my_adjoint)
      | (OVar var, []) ->
        Logger.log ~level:`trace (var ^ " Adjoint: " ^ (A.to_string my_adjoint) ^ "\n");
        grad_map := VarMap.add var my_adjoint !grad_map
      | (OConst _, _) -> ()
      | _ -> failwith "Ill formed computation graph")
    in
    Top.iter aux comp_graph;
    NodeTbl.clear result_tbl;
    !grad_map

end
