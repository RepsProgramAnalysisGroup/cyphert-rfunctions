module VarMap = Map.Make(String);;

type rexpr =
  | X
  | Y
  | Plus of rexpr * rexpr
  | Times of rexpr * rexpr
  | Pow of rexpr * float
  | Const of float

module type RFun = sig
  val make_r : Z3.Expr.expr -> (float VarMap.t -> float * float VarMap.t) * string list
end

module Make (A : sig val orFun : rexpr val notFun : rexpr val baseFun : rexpr end) : RFun = struct

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

  let add_maps mx my = 
    VarMap.union (fun key a b -> Some (a +. b)) mx my

  let make_plus f g =
    let sub = fun vars ->
      let (fv, df) = f vars in
      let (gv, dg) = g vars in
      (fv +. gv, add_maps df dg)
    in
    memo sub

  let make_times f g =
    let sub = fun vars ->
      let (fv, df) = f vars in
      let (gv, dg) = g vars in
      (fv *. gv, add_maps (VarMap.map (fun x -> gv *. x) df) (VarMap.map (fun x -> fv *. x) dg))
    in
    memo sub

  let make_pow n f =
    let sub = fun vars ->
      let (value, df) = (f vars) in
      let multiplier = n *. (value)**(n -. 1.) in
      (value ** n, VarMap.map (fun x -> multiplier *. x) df)
    in
    memo sub
   
  let make_fun_from_expr expr f g = 
    let rec aux sub = 
      match sub with
      | X -> f
      | Y -> g
      | Plus (left, right) -> make_plus (aux left) (aux right)
      | Times (left, right) -> make_times (aux left) (aux right)
      | Pow (base, exp) -> make_pow exp (aux base)
      | Const value -> (fun vars -> (value, VarMap.empty))
    in
    aux expr
  
  let make_or f g = 
    memo (make_fun_from_expr A.orFun f g)

  let make_not f = 
    memo (make_fun_from_expr A.notFun f f)

  let make_and f g = 
    let not_f = make_not f in
    let not_g = make_not g in
    let res = make_not (make_or not_f not_g) in
    memo res
  
  let make_base var = 
    memo (make_fun_from_expr A.baseFun (fun variables -> (VarMap.find var variables, VarMap.add var 1. VarMap.empty)) (fun x -> (0., VarMap.empty)))
    

  let make_true vars = 
    (1., VarMap.empty)

  let make_false vars = 
    (-1., VarMap.empty)

  let rec make_r expr =
    if Z3.Boolean.is_true expr then (
      (make_true, []))
    else if Z3.Boolean.is_false expr then (
      (make_false, []))
    else if Z3.Boolean.is_or expr then (
      let (formulas, vars) = List.split (List.map make_r (Z3.Expr.get_args expr)) in
      (List.fold_left make_or make_false formulas, List.concat vars ))
    else if Z3.Boolean.is_and expr then (
      let (formulas, vars) = List.split (List.map make_r (Z3.Expr.get_args expr)) in
      (List.fold_left make_and make_true formulas, List.concat vars) )
    else if Z3.Boolean.is_not expr then (
      let (sub_form, vars) = make_r (List.nth (Z3.Expr.get_args expr) 0) in
      (make_not sub_form, vars) )
    else if Z3.Expr.is_const expr then (
      let name = (Z3.Expr.to_string expr) in
      (make_base name, [name]) )
    else (
      failwith "unknown Expr node"
    )
end

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

