module VarMap = Map.Make(String);;

module Logger = Log

module Make () : Sigs.AD = struct
  type op = 
    | Add
    | Mult
    | Div
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

  (*Could implement more hash consing*)

  type t = node

  let wen : node list ref = ref []
 
  let make_add left right =
    let new_node = {
      value = 0.;
      oper = Add;
      adj = 0.;
      left = Some left;
      right = Some right
    } in
    wen := new_node :: !wen;
    new_node

  let make_mult left right =
    let new_node = {
      value = 0.;
      oper = Mult;
      adj = 0.;
      left = Some left;
      right = Some right
    } in
    wen := new_node :: !wen;
    new_node

  let make_exp base exponent=
    let new_node = {
      value = 0.;
      oper = Exp exponent;
      adj = 0.;
      left = Some base;
      right = None
    } in
    wen := new_node :: !wen;
    new_node

  let make_div left right = 
    let new_node = {
      value = 0.;
      oper = Div;
      adj = 0.;
      left = Some left;
      right = Some right
    } in
    wen := new_node :: !wen;
    new_node

  let make_var var = 
    let new_node = {
      value = 0.;
      oper = Var var;
      adj = 0.;
      left = None;
      right = None;
    } in
    wen := new_node :: !wen;
    new_node

  let make_const value = 
    let new_node = {
      value = value;
      oper = Const value;
      adj = 0.;
      left = None;
      right = None;
    } in
    wen := new_node :: !wen;
    new_node

  let build_complete () = ()

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
    (List.nth !wen 0).value

  let grad () = 
    (List.nth !wen 0).adj <- 1.;
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
