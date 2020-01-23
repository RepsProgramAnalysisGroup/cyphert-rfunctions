module VarMap = Map.Make(String);;

type rexpr =
  | X
  | Y
  | Plus of rexpr * rexpr
  | Times of rexpr * rexpr
  | Pow of rexpr * float
  | Const of float

module type RFun = sig
  val eval_init : Z3.Expr.expr -> float VarMap.t option -> float -> float * string list
  val eval : float VarMap.t -> float
  val grad : unit -> float VarMap.t
  val stopping_rule : float -> bool
  val update : float -> float -> float
end

module Logger = Log

module Make () : RFun = struct
  type op = 
    | Add
    | Mult
    | Sub
    | Div
    | AddC of float
    | Exp of float
    | Var of string
    | Const of float

  type node = {
    mutable value : float;
    oper : op;
    mutable adj : float; 
    left : node option;
    right : node option;
  }

  let wen : node list ref = ref []
 
  let eval_true () = 
    let true_node = {
      value = 0.;
      oper = Const 0.;
      adj = 0.;
      left = None;
      right = None;
    } in
    wen := true_node :: !wen;
    true_node

  let eval_false () = 
    let false_node = {
      value = 1.;
      oper = Const 1.;
      adj = 0.;
      left = None;
      right = None;
    } in
    wen := false_node :: !wen;
    false_node

  let eval_base name init =
    let var_node = {
      value = init;
      oper = Var name;
      adj = 0.;
      left = None;
      right = None;
    } in
    wen := var_node :: !wen;
    let minus_1 = {
      value = var_node.value -. 1.;
      oper = AddC (-.1.);
      adj = 0.;
      left = Some var_node;
      right = None;
    } in
    wen := minus_1 :: !wen;
    let sq_node = {
      value = minus_1.value ** 2.;
      oper = Exp (2.);
      adj = 0.;
      left = Some minus_1;
      right = None;
    } in
    wen := sq_node :: !wen;
    sq_node

  let eval_base_not name init =
    let var_node = {
      value = init;
      oper = Var name;
      adj = 0.;
      left = None;
      right = None;
    } in
    wen := var_node :: !wen;
    let sq_node = {
      value = var_node.value ** 2.;
      oper = Exp (2.);
      adj = 0.;
      left = Some var_node;
      right = None;
    } in
    wen := sq_node :: !wen;
    sq_node

  (* This should work for this particular formulation but probably not in general *)
  let eval_not a = 
    let a_plus_1 = {
      value = a.value +. 1.;
      oper = AddC (1.);
      adj = 0.;
      left = Some a;
      right = None;
    } in
    wen := a_plus_1 :: !wen;
    let a_plus_2 = {
      value = a.value +. 2.;
      oper = AddC (2.);
      adj = 0.;
      left = Some a;
      right = None;
    } in
    wen := a_plus_2 :: !wen;
    let a1_div_a2 = {
      value = a_plus_1.value /. a_plus_2.value;
      oper = Div;
      adj = 0.;
      left = Some a_plus_1;
      right = Some a_plus_2;
    } in
    wen := a1_div_a2 :: !wen;
    let a_minus_div = {
      value = a.value -. a1_div_a2.value;
      oper = Sub;
      adj = 0.;
      left = Some a;
      right = Some a1_div_a2;
    } in
    wen := a_minus_div :: !wen;
    let term_sq = {
      value = a_minus_div.value ** 2.;
      oper = Exp 2.;
      adj = 0.;
      left = Some a_minus_div;
      right = None;
    } in
    wen := term_sq :: !wen;
    let term_sqrt = {
      value = term_sq.value ** 0.5;
      oper = Exp 0.5;
      adj = 0.;
      left = Some term_sq;
      right = None
    } in
    wen := term_sqrt :: !wen;
    let final_node = {
      value = term_sqrt.value -. a_minus_div.value;
      oper = Sub;
      adj = 0.;
      left = Some term_sqrt;
      right = Some a_minus_div;
    } in
    wen := final_node :: !wen;
    final_node

  let eval_or args = 
    let fold_fun left_node right_node =
      let res_value = left_node.value *. right_node.value in
      let res_node = {
        value = res_value;
        oper = Mult;
        adj = 0.;
        left = Some left_node;
        right = Some right_node;
      } in
      wen := res_node :: !wen;
      res_node
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
    collapse args

  let eval_and args = 
    let fold_fun left_node right_node =
      let res_value = left_node.value +. right_node.value in
      let res_node = {
        value = res_value;
        oper = Add;
        adj = 0.;
        left = Some left_node;
        right = Some right_node;
      } in
      wen := res_node :: !wen;
      res_node
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
    collapse args

  let eval_eq left right = 
    let left_and_right = eval_and [left;right] in
    let not_left = eval_not left in
    let not_right = eval_not right in
    let nleft_and_nright = eval_and [not_left;not_right] in
    eval_or [left_and_right; nleft_and_nright]


  module IntTbl = Hashtbl.Make(struct type t = int let equal = (=) let hash = Hashtbl.hash end)

  let eval_init ex assign init =
    let node_tbl = IntTbl.create 1000 in
    let vars = ref [] in
    let rec aux expr =
      let expr_id = Z3.AST.get_id (Z3.Expr.ast_of_expr expr) in
      try
        IntTbl.find node_tbl expr_id
      with Not_found ->
        if (Z3.Boolean.is_true expr || Z3.Expr.to_string expr = "true")then ( (*Shouldn't need to check explicitly true or false*)
          Logger.log_time_cum "eval_true" (fun () -> let res_node = eval_true () in
          IntTbl.add node_tbl expr_id res_node;
          res_node) ())
        else if (Z3.Boolean.is_false expr || Z3.Expr.to_string expr = "false") then (
          Logger.log_time_cum "eval_false" (fun () ->let res_node = eval_false () in
          IntTbl.add node_tbl expr_id res_node;
          res_node) ())
        else if Z3.Expr.is_const expr then (
          Logger.log_time_cum "eval_base" (fun () -> let name = (Z3.Expr.to_string expr) in
          if not (List.mem name !vars) then (vars := name :: !vars);
          let init_val = 
            (match assign with
            | None -> init
            | Some map ->
              try 
                VarMap.find name map
              with Not_found -> init) in
          let res_node = eval_base name init_val in
          IntTbl.add node_tbl expr_id res_node;
          res_node) ())
        else if Z3.Boolean.is_or expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          Logger.log_time_cum "eval_or" (fun () ->
          let res_node = eval_or args in
          IntTbl.add node_tbl expr_id res_node;
          res_node) ())
        else if Z3.Boolean.is_and expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          Logger.log_time_cum "eval_and" (fun () -> let res_node = eval_and args in
          IntTbl.add node_tbl expr_id res_node;
          res_node) ())
        else if Z3.Boolean.is_not expr then (
          let child = List.nth (Z3.Expr.get_args expr) 0 in
          if (Z3.Boolean.is_true child || Z3.Expr.to_string child = "true") then ( (*Shouldn't need to check explicitly true or false*)
            Logger.log_time_cum "eval_false" (fun () -> let res_node = eval_false () in
            IntTbl.add node_tbl expr_id res_node;
            res_node) ())
          else if (Z3.Boolean.is_false child || Z3.Expr.to_string child = "false") then ( (*Shouldn't need to check explicitly true or false*)
            Logger.log_time_cum "eval_true" (fun () -> let res_node = eval_true () in
            IntTbl.add node_tbl expr_id res_node;
            res_node) ())
          else if (Z3.Expr.is_const child) then (
            Logger.log_time_cum "eval_base_not" (fun () -> let name = Z3.Expr.to_string child in
            if not (List.mem name !vars) then (vars := name :: !vars);
            let init_val = 
              (match assign with
              | None -> init
              | Some map ->
                try 
                  VarMap.find name map
                with Not_found -> init) in
            let res_node = eval_base_not name init_val in
            IntTbl.add node_tbl expr_id res_node;
            res_node) ())
          else
            let eval_child = aux child in
            Logger.log_time_cum "eval_not" (fun () -> let res_node = eval_not eval_child in
            IntTbl.add node_tbl expr_id res_node;
            res_node) ())
            (*failwith "Input formula wasn't in NNF")*)
        else if Z3.Boolean.is_eq expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          Logger.log_time_cum "eval_eq" (fun () -> let res_node = eval_eq (List.nth args 0) (List.nth args 1) in
          IntTbl.add node_tbl expr_id res_node;
          res_node)) ()
        else (
          failwith ("unknown Expr node: \n" ^ (Z3.Expr.to_string expr))
        )
    in
    let root_node = aux ex in
    root_node.adj <- 1.;
    (*let oc = open_out "graph.dot" in
    Vis.output_graph oc comp_graph;
    close_out oc;*)
    (root_node.value, !vars)

  let eval assign =
    let get_child x = 
      match x with 
      | Some v -> v;
      | None -> failwith "getting nothing"
    in
    let aux curr = 
      let res = 
        match curr.oper with
        | Const v -> v
        | Add -> 
          (get_child curr.left).value +. (get_child curr.right).value
        | AddC v ->
          (get_child curr.left).value +. v
        | Sub ->
          (get_child curr.left).value -. (get_child curr.right).value
        | Mult -> 
          (get_child curr.left).value *. (get_child curr.right).value
        | Div ->
          (get_child curr.left).value /. (get_child curr.right).value
        | Exp n ->
          (get_child curr.left).value ** n
        | Var var ->
          VarMap.find var assign
      in
      curr.value <- res;
      curr.adj <- 0.
    in
    List.iter aux (List.rev !wen);
    (List.nth !wen 0).adj <- 1.;
    (List.nth !wen 0).value

  let grad () = 
    let get_child x = 
      match x with 
      | Some v -> v;
      | None -> failwith "getting nothing"
    in
    let grad_map = ref VarMap.empty in
    let aux curr =
      let my_adjoint = curr.adj in
      (match curr.oper with
      | Var var ->
        grad_map := VarMap.update var (fun x ->
          match x with
          | None -> Some my_adjoint
          | Some v -> Some (v +. my_adjoint)
        ) !grad_map
      | Add ->
        let left_child = get_child curr.left in
        let prev_left_adj = left_child.adj in
        left_child.adj <- prev_left_adj +. my_adjoint;
        let right_child = get_child curr.right in
        let prev_right_adj = right_child.adj in
        right_child.adj <- prev_right_adj +. my_adjoint
      | AddC _ ->
        let left_child = get_child curr.left in
        let prev_left_adj = left_child.adj in
        left_child.adj <- prev_left_adj +. my_adjoint
      | Sub ->
        let left_child = get_child curr.left in
        let prev_left_adj = left_child.adj in
        left_child.adj <- prev_left_adj +. my_adjoint;
        let right_child = get_child curr.right in
        let prev_right_adj = right_child.adj in
        right_child.adj <- prev_right_adj -. my_adjoint
      | Mult ->
        let left_child = get_child curr.left in
        let right_child = get_child curr.right in
        let prev_left_adj = left_child.adj in
        left_child.adj <- prev_left_adj +. my_adjoint *. right_child.value;
        let prev_right_adj = right_child.adj in
        right_child.adj <- prev_right_adj +. my_adjoint *. left_child.value
      | Exp n ->
        let left_child = get_child curr.left in
        let prev_left_adj = left_child.adj in
        left_child.adj <- prev_left_adj +. my_adjoint *. (left_child.value ** (n -. 1.)) *. n
      | Div ->
        let left_child = get_child curr.left in
        let right_child = get_child curr.right in
        let prev_left_adj = left_child.adj in
        left_child.adj <- prev_left_adj +. my_adjoint /. right_child.value;
        let prev_right_adj = right_child.adj in
        right_child.adj <- prev_right_adj -. my_adjoint *. curr.value /. right_child.value
      | Const _ -> ())
    in
    List.iter aux !wen;
    !grad_map

  let stopping_rule value = 
    if value = 0. then true
    else false

  let update value gradient =
    if gradient > 0. && value > 0. then
      0.
    else if gradient < 0. && value < 1. then
      1.
    else value
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
