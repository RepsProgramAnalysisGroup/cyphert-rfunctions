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

module Make () : RFun = struct
  
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
    let var_node = (Var var, []) in
    let minus_1 = (Const (-1.), []) in
    let add_node = (Add, List.sort compare [get_id var_node; get_id minus_1]) in
    CGraph.add_edge comp_graph add_node var_node;
    CGraph.add_edge comp_graph add_node minus_1;
    let sqr_node = (Exp 2., [get_id add_node]) in
    CGraph.add_edge comp_graph sqr_node add_node;
    (get_id sqr_node, sqr_node)

  let add_base_not var = 
    let var_node = (Var var, []) in
    let sqr_node = (Exp 2., [get_id var_node]) in
    CGraph.add_edge comp_graph sqr_node var_node;
    (get_id sqr_node, sqr_node)
    
  let add_or left_code left_node right_code right_node = 
    let times_node = (Mult, List.sort compare [left_code; right_code]) in
    (if (left_code = right_code) then
      (let e1 = CGraph.E.create times_node 1 left_node in
      let e2 = CGraph.E.create times_node 2 right_node in
      CGraph.add_edge_e comp_graph e1;
      CGraph.add_edge_e comp_graph e2)
    else (
      CGraph.add_edge comp_graph times_node left_node;
      CGraph.add_edge comp_graph times_node right_node
    ));
    (get_id times_node, times_node)

  let add_and left_code left_node right_code right_node = 
    let add_node = (Add, List.sort compare [left_code; right_code]) in
    (if (left_code = right_code) then
      (let e1 = CGraph.E.create add_node 1 left_node in
      let e2 = CGraph.E.create add_node 2 right_node in
      CGraph.add_edge_e comp_graph e1;
      CGraph.add_edge_e comp_graph e2)
    else (
      CGraph.add_edge comp_graph add_node left_node;
      CGraph.add_edge comp_graph add_node right_node
    ));
    (get_id add_node, add_node)


  let add_eq left_code left_node right_code right_node =
    let minus_1 = (Const (-1.), []) in
    let minus_1_id = get_id minus_1 in
    let times_node = (Mult, List.sort compare [right_code; minus_1_id]) in
    (if (right_code = minus_1_id) then
      (let e1 = CGraph.E.create times_node 1 right_node in
      let e2 = CGraph.E.create times_node 2 minus_1 in
      CGraph.add_edge_e comp_graph e1;
      CGraph.add_edge_e comp_graph e2)
    else (
      CGraph.add_edge comp_graph times_node right_node;
      CGraph.add_edge comp_graph times_node minus_1
    ));
    let times_id = get_id times_node in
    let add_node = (Add, List.sort compare [times_id; left_code]) in
    (if (left_code = times_id) then
      (let e1 = CGraph.E.create add_node 1 times_node in
      let e2 = CGraph.E.create add_node 2 left_node in
      CGraph.add_edge_e comp_graph e1;
      CGraph.add_edge_e comp_graph e2)
    else (
      CGraph.add_edge comp_graph add_node times_node;
      CGraph.add_edge comp_graph add_node left_node
    ));
    (get_id add_node, add_node)

  let true_node = ref None
  let false_node = ref None

  let add_true () = 
    match !true_node with
    | None ->
      let true_nde = (Const 0., []) in
      CGraph.add_vertex comp_graph true_nde;
      let id = get_id true_nde in
      true_node := Some (id, true_nde);
      (id, true_nde)
   | Some x -> x

  let add_false () = 
    match !false_node with
    | None ->
      let false_nde = (Const (1.), []) in
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

  module IntTbl = Hashtbl.Make(struct type t = int let equal = (=) let hash = Hashtbl.hash end)

  let expr_tbl = IntTbl.create 1000

  let make_comp_graph ex =
    id_count := 0;
    let vars = ref [] in
    let rec aux expr =
      let expr_id = Z3.AST.get_id (Z3.Expr.ast_of_expr expr) in
      try
        Logger.log "Hit\n" ~level:`trace;
        IntTbl.find expr_tbl expr_id
      with Not_found ->
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
          let res = collapse args in
          IntTbl.add expr_tbl expr_id res;
          res)
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
          let res = collapse args in
          IntTbl.add expr_tbl expr_id res;
          res)
        else if Z3.Boolean.is_not expr then (
          let child = List.nth (Z3.Expr.get_args expr) 0 in
          if (Z3.Expr.is_const child) then
            let name = Z3.Expr.to_string child in
            if not (List.mem name !vars) then (vars := name :: !vars);
            add_base_not name
          else
            failwith "Input formula wasn't in NNF")
        else if Z3.Boolean.is_eq expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          let res = add_eq (fst (List.nth args 0)) (snd (List.nth args 0)) (fst (List.nth args 1)) (snd (List.nth args 1)) in
          IntTbl.add expr_tbl expr_id res;
          res)
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
