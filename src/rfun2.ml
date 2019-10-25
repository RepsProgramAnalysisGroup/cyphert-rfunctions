module VarMap = Map.Make(String);;

type rexpr =
  | X
  | Y
  | Plus of rexpr * rexpr
  | Times of rexpr * rexpr
  | Pow of rexpr * float
  | Const of float

module type RFun = sig
  val make_comp_graph : Z3.Expr.expr -> string list
  val eval : float VarMap.t -> float
  val grad : unit -> float VarMap.t
end

module Logger = Log

module Make (A : sig val orFun : rexpr val andFun : rexpr val notFun : rexpr val baseFun : rexpr end) : RFun = struct
  
  type op = 
    | Add
    | Mult
    | Exp of float
    | Var of string
    | Const of float

  type node = (op * int list)

  module CGraph = Graph.Imperative.Digraph.ConcreteBidirectionalLabeled(struct type t = node let hash = Hashtbl.hash let compare = compare let equal = (=) end )(struct type t = int let compare = compare let default = 0 end)

  module Top = Graph.Topological.Make(CGraph)
  module RevTop = Graph.Topological.Make(struct type t = CGraph.t module V = CGraph.V let iter_vertex = CGraph.iter_vertex let iter_succ = CGraph.iter_pred end) 
  
  module NodeTbl = Hashtbl.Make(struct type t = CGraph.V.t let equal = (=) let hash = Hashtbl.hash end)
  module EdgeTbl = Hashtbl.Make(struct type t = CGraph.V.t * CGraph.V.t let equal = (=) let hash = Hashtbl.hash end)
  let res_tbl = ref None
  let edge_tbl = ref None

  let comp_graph = CGraph.create ()
  
  let root = ref None

  let id_count = ref 0
  let id_tbl = NodeTbl.create 1000

  let get_id v =
    try
      NodeTbl.find id_tbl v
    with Not_found ->
      id_count := !id_count + 1;
      NodeTbl.add id_tbl v !id_count;
      !id_count

  let add_base var = 
    (*let var_node = (Var var, []) in
    let const_node = (Const (-0.5), []) in
    let add_node = (Add, List.sort compare [get_id var_node; get_id const_node]) in
    let e1 = CGraph.E.create add_node 1 var_node in
    let e2 = CGraph.E.create add_node 2 const_node in
    CGraph.add_edge_e comp_graph e1;
    CGraph.add_edge_e comp_graph e2;
    (get_id add_node, add_node)*)

    let rec aux (expr : rexpr) : int * CGraph.vertex = 
      match expr with
      | X -> 
        let new_node = (Var var, []) in
        (* add to leaf set*)
        CGraph.add_vertex comp_graph new_node;
        (get_id new_node, new_node)
        | Plus (left, right) ->
        let (left_code, left_node) = aux left in
        let (right_code, right_node) = aux right in
        if (left_code < right_code) then (
          let new_node = (Add, [left_code; right_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 left_node in
          let e2 = CGraph.E.create new_node 2 right_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
        else (
          let new_node = (Add, [right_code; left_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 right_node in
          let e2 = CGraph.E.create new_node 2 left_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
      | Times (left, right) ->
        let (left_code, left_node) = aux left in
        let (right_code, right_node) = aux right in
        if (left_code < right_code) then (
          let new_node = (Mult, [left_code; right_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 left_node in
          let e2 = CGraph.E.create new_node 2 right_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
        else (
          let new_node = (Mult, [right_code; left_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 right_node in
          let e2 = CGraph.E.create new_node 2 left_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
      | Pow (base, n) ->
        let (base_code, base_node) = aux base in
        let new_node = (Exp n, [base_code]) in
        CGraph.add_vertex comp_graph new_node;
        CGraph.add_edge comp_graph new_node base_node;
        (get_id new_node, new_node)
      | Const n ->
        let new_node = (Const n, []) in
        CGraph.add_vertex comp_graph new_node;
        (get_id new_node, new_node)
      | Y -> failwith "Y shouldn't be a part of the base expr"
    in
    aux A.baseFun


  let add_fun left_node left_code right_node right_code rfun_rule =
    let rec aux (expr : rexpr) : int * CGraph.vertex=
      match expr with
      | X ->
        (left_code, left_node)
      | Y ->
        (right_code, right_node)
      | Plus (left, right) ->
        let (left_code, left_node) = aux left in
        let (right_code, right_node) = aux right in
        if (left_code < right_code) then (
          let new_node = (Add, [left_code; right_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 left_node in
          let e2 = CGraph.E.create new_node 2 right_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
        else (
          let new_node = (Add, [right_code; left_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 right_node in
          let e2 = CGraph.E.create new_node 2 left_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
      | Times (left, right) ->
        let (left_code, left_node) = aux left in
        let (right_code, right_node) = aux right in
        if (left_code < right_code) then (
          let new_node = (Mult, [left_code; right_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 left_node in
          let e2 = CGraph.E.create new_node 2 right_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
        else (
          let new_node = (Mult, [right_code; left_code]) in
          let id = get_id new_node in
          (*Logger.log ~level:`trace ("Making edge from " ^ (string_of_int id) ^ " to " ^ (string_of_int left_code) ^ " and " ^ (string_of_int right_code) ^ "\n");*)
          CGraph.add_vertex comp_graph new_node;
          let e1 = CGraph.E.create new_node 1 right_node in
          let e2 = CGraph.E.create new_node 2 left_node in
          CGraph.add_edge_e comp_graph e1;
          CGraph.add_edge_e comp_graph e2;
          (id, new_node))
      | Pow (base, n) ->
        let (base_code, base_node) = aux base in
        let new_node = (Exp n, [base_code]) in
        CGraph.add_vertex comp_graph new_node;
        CGraph.add_edge comp_graph new_node base_node;
        (get_id new_node, new_node)
      | Const n ->
        let new_node = (Const n, []) in
        CGraph.add_vertex comp_graph new_node;
        (get_id new_node, new_node)
    in
    aux rfun_rule

  let add_or left_code left_node right_code right_node = 
    (*let add_l_r = (Add, List.sort compare [left_code;right_code]) in
    let add_e1 = CGraph.E.create add_l_r 1 left_node in
    let add_e2 = CGraph.E.create add_l_r 2 right_node in
    CGraph.add_edge_e comp_graph add_e1;
    CGraph.add_edge_e comp_graph add_e2;
    let l_sq = (Exp 2., [left_code]) in
    CGraph.add_edge comp_graph l_sq left_node;
    let r_sq = (Exp 2., [right_code]) in
    CGraph.add_edge comp_graph r_sq right_node;
    let add_ls_rs = (Add, List.sort compare [get_id l_sq; get_id r_sq]) in
    let add_ls_rs_e1 = CGraph.E.create add_ls_rs 1 l_sq in
    let add_ls_rs_e2 = CGraph.E.create add_ls_rs 2 r_sq in
    CGraph.add_edge_e comp_graph add_ls_rs_e1;
    CGraph.add_edge_e comp_graph add_ls_rs_e2;
    let sqr = (Exp 0.5, [get_id add_ls_rs]) in
    CGraph.add_edge comp_graph sqr add_ls_rs;
    let res = (Add, List.sort compare [get_id sqr; get_id add_l_r]) in
    let res_e1 = CGraph.E.create res 1 add_l_r in
    let res_e2 = CGraph.E.create res 2 sqr in
    CGraph.add_edge_e comp_graph res_e1;
    CGraph.add_edge_e comp_graph res_e2;
    (get_id res, res)*)
  
    add_fun left_node left_code right_node right_code A.orFun

  let add_not hashcode new_node = 
    (*let const_node = (Const (-1.), []) in
    let mult_node = (Mult, List.sort compare [get_id const_node; hashcode]) in
    let mult_e1 = CGraph.E.create mult_node 1 const_node in
    let mult_e2 = CGraph.E.create mult_node 2 new_node in
    CGraph.add_edge_e comp_graph mult_e1;
    CGraph.add_edge_e comp_graph mult_e2;
    (get_id mult_node, mult_node)*)

    add_fun new_node hashcode new_node hashcode A.notFun
  
  let add_and left_code left_node right_code right_node = 
    let (nlc, nln) = add_not left_code left_node in
    let (nrc, nrn) = add_not right_code right_node in
    let (onlnrc, onlnrn) = add_or nlc nln nrc nrn in
    add_not onlnrc onlnrn
    (*add_fun left_node left_code right_node right_code A.andFun*)


  let add_eq left_code left_node right_code right_node =
    let (and_lr_c, and_lr_n) = add_and left_code left_node right_code right_node in
    let (nl_code, nl_node) = add_not left_code left_node in
    let (nr_code, nr_node) = add_not right_code right_node in
    let (and_nlnr_c, and_nlnr_n) = add_and nl_code nl_node nr_code nr_node in
    add_or and_lr_c and_lr_n and_nlnr_c and_nlnr_n

  let true_node = ref None
  let false_node = ref None

  let add_true () = 
    match !true_node with
    | None ->
      let true_nde = (Const 1., []) in
      CGraph.add_vertex comp_graph true_nde;
      let id = get_id true_nde in
      true_node := Some (id, true_nde);
      (id, true_nde)
   | Some x -> x

  let add_false () = 
    match !false_node with
    | None ->
      let false_nde = (Const (-1.), []) in
      CGraph.add_vertex comp_graph false_nde;
      let id = get_id false_nde in
      false_node := Some (id, false_nde);
      (id, false_nde)
   | Some x -> x
 
  (*module Vis = Graph.Graphviz.Dot(
    struct 
      include CGraph
      let graph_attributes g = []
      let default_vertex_attributes g = []
      let vertex_name v = 
        match v with
        | (Const x, _) -> (string_of_float x)
        | (Var name, _) -> 
          String.concat "" (String.split_on_char '!' name)
        | (Exp n, lst) -> "Exp" ^ (string_of_int (get_id v))
        | (Mult, lst) -> "Mult" ^ (string_of_int (get_id v))
        | (Add, lst) -> "Add" ^ (string_of_int (get_id v))
      let vertex_attributes v = []
      let get_subgraph v = None
      let default_edge_attributes g = []
      let edge_attributes e = []
    end) *)

  let make_comp_graph ex =
    id_count := 0;
    let vars = ref [] in
    (* It doesn't make sense why it needs to be in this order but Z3 crashes if the const check isn't first now *)
    let rec aux expr =
      if Z3.Boolean.is_true expr then (
        add_true ())
      else if Z3.Boolean.is_false expr then (
        add_false ())
      else if Z3.Expr.is_const expr then (
        let name = (Z3.Expr.to_string expr) in
        if not (List.mem name !vars) then (vars := name :: !vars);
        add_base name)
      else if Z3.Boolean.is_or expr then (
        let args = List.map aux (Z3.Expr.get_args expr) in
        let fold_fun (left_code, left_node) (right_code, right_node) =
          add_or left_code left_node right_code right_node
        in
        let rec collapse l = 
          if (List.length l = 2) then fold_fun (List.nth l 0) (List.nth l 1)
          else if (List.length l = 3) then fold_fun (fold_fun (List.nth l 0) (List.nth l 1)) (List.nth l 2)
          else if (List.length l = 1) then failwith "Don't think this should happen"
          else
            let pivot = (List.length l) / 2 in
            let left_list = ref [] in
            let right_list = ref [] in
            List.iteri (fun i x -> if (i < pivot) then left_list := x :: !left_list  else right_list := x :: !right_list) l;
            fold_fun (collapse !left_list) (collapse !right_list)
        in
        collapse args)
      else if Z3.Boolean.is_and expr then (
        let args = List.map aux (Z3.Expr.get_args expr) in
        let fold_fun (left_code, left_node) (right_code, right_node) =
          add_and left_code left_node right_code right_node
        in
        let rec collapse l = 
          if (List.length l = 2) then fold_fun (List.nth l 0) (List.nth l 1)
          else if (List.length l = 3) then fold_fun (fold_fun (List.nth l 0) (List.nth l 1)) (List.nth l 2)
          else if (List.length l = 1) then failwith "Don't think this should happen"
          else
            let pivot = (List.length l) / 2 in
            let left_list = ref [] in
            let right_list = ref [] in
            List.iteri (fun i x -> if (i < pivot) then left_list := x :: !left_list  else right_list := x :: !right_list) l;
            fold_fun (collapse !left_list) (collapse !right_list)
        in
        collapse args)
      else if Z3.Boolean.is_not expr then (
        let (hashcode, new_node) = aux (List.nth (Z3.Expr.get_args expr) 0) in
        add_not hashcode new_node)
      else if Z3.Boolean.is_eq expr then (
        let args = List.map aux (Z3.Expr.get_args expr) in
        add_eq (fst (List.nth args 0)) (snd (List.nth args 0)) (fst (List.nth args 1)) (snd (List.nth args 1)))
      else (
        failwith ("unknown Expr node: \n" ^ (Z3.Expr.to_string expr))
      )
    in
    let (_, root_node) = aux ex in
    root := Some root_node;
    let num_nodes = CGraph.nb_vertex comp_graph in
    let num_edges = CGraph.nb_edges comp_graph in
    res_tbl := Some (NodeTbl.create num_nodes);
    edge_tbl := Some (EdgeTbl.create num_edges);
    Logger.log ~level:`trace ("Number of nodes: " ^ (string_of_int num_nodes) ^ "\n");
    Logger.log ~level:`trace ("Number of edges: " ^ (string_of_int num_edges) ^ "\n");
    (*let oc = open_out "graph.dot" in
    Vis.output_graph oc comp_graph;
    close_out oc;*)
    !vars

  let been_evaled = ref false

  let get_tbl () = 
    match !res_tbl with
    | Some x -> x
    | None -> failwith "Don't have results table"

  let eval assign =
    let result_tbl = get_tbl () in
    let rec aux curr = 
      let get_value v =
        try
          NodeTbl.find result_tbl v
        with Not_found -> aux v
      in
      match curr with 
      | (Var var, []) ->
        let assignment = VarMap.find var assign in
        (*Logger.log ~level:`trace (var ^ ": " ^ (string_of_float assignment) ^ "\n");*)
        NodeTbl.replace result_tbl curr assignment;
        assignment
      | (Const x, []) ->
        (*Logger.log ~level:`trace ("Const: " ^ (string_of_float x) ^ "\n");*)
        NodeTbl.replace result_tbl curr x;
        x
      | (Add, lst) ->
        let succs = CGraph.succ comp_graph curr in
        let left_v = get_value (List.nth succs 0) in
        let right_v = get_value (List.nth succs 1) in
        let res = left_v +. right_v in 
        (*Logger.log ~level:`trace ("Add" ^ (string_of_int (get_id curr)) ^ ": " ^ (string_of_float res) ^ "=" ^ (string_of_float left_v) ^ " + " ^ (string_of_float right_v) ^ "\n");*)
        NodeTbl.replace result_tbl curr res;
        res
      | (Mult, _) ->
        let succs = CGraph.succ comp_graph curr in
        let left_v = get_value (List.nth succs 0) in
        let right_v = get_value (List.nth succs 1) in
        let res = left_v *. right_v in 
        (*Logger.log ~level:`trace ("Mult" ^ (string_of_int (get_id curr)) ^ ": " ^ (string_of_float res) ^ "=" ^ (string_of_float left_v) ^ " * " ^ (string_of_float right_v) ^ "\n");*)
        NodeTbl.replace result_tbl curr res;
        res
      | (Exp n, _) ->
        let base_v = get_value (List.nth (CGraph.succ comp_graph curr) 0) in
        let res = (base_v) ** n in
        (*Logger.log ~level:`trace ("Exp" ^ (string_of_int (get_id curr)) ^ ": " ^ (string_of_float res) ^ "=" ^ (string_of_float base_v) ^ " ** " ^ (string_of_float n) ^ "\n");*)
        NodeTbl.replace result_tbl curr res;
        res
      | _ -> failwith "This case shouldn't be possible"
    in
    (*let reset_vertex v = (snd v) := None in
    if !been_evaled then CGraph.iter_vertex reset_vertex comp_graph;
    been_evaled := true;*)
    (*let seen_v = ref [] in
    let duplicate v =
      try
        let dup_ref = List.find (fun x -> (snd x) == (snd v)) !seen_v in
        failwith ("Vertex " ^ (string_of_int (CGraph.V.hash v)) ^ " has the same ref as " ^ (string_of_int (CGraph.V.hash dup_ref)) ^ "\n");
      with Not_found ->
        seen_v := v :: !seen_v
    in
    CGraph.iter_vertex duplicate comp_graph;*)
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
          CGraph.fold_pred (fun v acc -> acc +. (EdgeTbl.find edge_tab (v,curr))) comp_graph curr (0.)
        else (1.))
      in
      (match curr with
      | (Add, lst) ->
        (*Logger.log ~level:`trace ("Add" ^ (string_of_int (get_id curr)) ^ " Adjoint: " ^ (string_of_float my_adjoint) ^ "\n");*)
        CGraph.iter_succ (fun v -> EdgeTbl.replace edge_tab (curr,v) my_adjoint) comp_graph curr
      | (Mult, lst) ->
        (*Logger.log ~level:`trace ("Mult" ^ (string_of_int (get_id curr)) ^ " Adjoint: " ^ (string_of_float my_adjoint) ^ "\n");*)
        let succ_v = CGraph.succ comp_graph curr in
        let v1 = List.nth succ_v 0 in 
        let v2 = List.nth succ_v 1 in
        EdgeTbl.replace edge_tab (curr, v1) ((NodeTbl.find result_tbl v2) *. my_adjoint);
        EdgeTbl.replace edge_tab (curr, v2) ((NodeTbl.find result_tbl v1) *. my_adjoint);
      | (Exp n, lst) ->
        let succ_n = List.nth (CGraph.succ comp_graph curr) 0 in
        let succ_v = NodeTbl.find result_tbl succ_n in
        (*Logger.log ~level:`trace ("Exp" ^ (string_of_int (get_id curr)) ^ " Adjoint: " ^ (string_of_float my_adjoint) ^ "\n");*)
        EdgeTbl.replace edge_tab (curr, succ_n) (n*.(succ_v)**(n -. 1.)*. my_adjoint)
      | (Var var, []) ->
        (*Logger.log ~level:`trace (var ^ " Adjoint: " ^ (string_of_float my_adjoint) ^ "\n");*)
        grad_map := VarMap.add var my_adjoint !grad_map
      | (Const _, _) -> ()
      | _ -> failwith "Ill formed computation graph")
    in
    Top.iter aux comp_graph;
    NodeTbl.clear result_tbl;
    !grad_map
end

(*
module Prod (A : RFun) (B : RFun) (C : sig val combine : float -> float -> float val id : float end) : RFun = struct
  let uniq lst =
    let unique_set = Hashtbl.create (List.length lst) in
    List.iter (fun x -> Hashtbl.replace unique_set x ()) lst;
    Hashtbl.fold (fun x () xs -> x :: xs) unique_set []
  
  let memo f =
    let m = ref [] in
      fun x ->
        try
          let matches (varmap, res) =
            if VarMap.equal (=) varmap x then true
            else false
          in
          let (matched, res) = List.find matches !m in
          res
        with Not_found ->
          let y = f x in
            m := (x, y) :: !m;
            y

  let make_r expr = 
    let (ar_fun, avars) = A.make_r expr in
    let (br_fun, bvars) = B.make_r expr in
    let sub = fun vars -> 
      let (a_res, agrad) = ar_fun vars in
      let (b_res, bgrad) = br_fun vars in
      let combine_grad key x y =
        match (x, y) with
        | (Some a, Some b) -> Some (C.combine a b)
        | (Some a, None) -> Some a
        | (None, Some b) -> Some b
        | (None, None) -> Some C.id
      in
      (C.combine a_res b_res, VarMap.merge combine_grad agrad bgrad)
    in
    (memo sub, uniq (List.append avars bvars))
end
*)
