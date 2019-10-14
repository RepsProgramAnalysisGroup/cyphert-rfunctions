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

module Logger = Log

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
      let res = fv +. gv in
      Logger.log ~level:`trace ("Add:" ^ (string_of_float res) ^ "=" ^ (string_of_float fv) ^ " + " ^ (string_of_float gv) ^ "\n");
      (fv +. gv, add_maps df dg)
    in
    memo sub

  let make_times f g =
    let sub = fun vars ->
      let (fv, df) = f vars in
      let (gv, dg) = g vars in
      let res = fv *. gv in
      Logger.log ~level:`trace ("Mult:" ^ (string_of_float res) ^ "=" ^ (string_of_float fv) ^ " * " ^ (string_of_float gv) ^ "\n");
      (fv *. gv, add_maps (VarMap.map (fun x -> gv *. x) df) (VarMap.map (fun x -> fv *. x) dg))
    in
    memo sub

  let make_pow n f =
    let sub = fun vars ->
      let (value, df) = (f vars) in
      let multiplier = n *. (value)**(n -. 1.) in
      let res = value ** n in
      Logger.log ~level:`trace ("Exp:" ^ (string_of_float res) ^ "=" ^ (string_of_float value) ^ " ** " ^ (string_of_float n) ^ "\n");
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
  
  let uniq lst =
    let unique_set = Hashtbl.create (List.length lst) in
    List.iter (fun x -> Hashtbl.replace unique_set x ()) lst;
    Hashtbl.fold (fun x () xs -> x :: xs) unique_set []

  type boolExpr = 
    | Or of boolExpr * boolExpr
    | And of boolExpr * boolExpr
    | True
    | False
    | Not of boolExpr
    | Const of string
    | Eq of boolExpr * boolExpr
    
  module Ht = Hashtbl.Make(struct type t = boolExpr let equal = (=) let hash = Hashtbl.hash end)

  let tbl = Ht.create 1000

  let make_r ex =
    let sort_fun (_, (_,x)) (_, (_, y)) = 
      compare x y
    in
    (* It doesn't make sense why it needs to be in this order but Z3 crashes if the const check isn't first now *)
    let rec aux expr =
      if Z3.Expr.is_const expr then (
        let name = (Z3.Expr.to_string expr) in
        match Ht.find_opt tbl (Const name) with
        | Some f -> 
          (f, ([name], Const name))
        | None ->
          let func = make_base name in
          Ht.add tbl (Const name) func;
          (func, ([name], Const name)) )
      else if Z3.Boolean.is_true expr then (
        (make_true, ([], True)))
      else if Z3.Boolean.is_false expr then (
        (make_false, ([], False)))
      else if Z3.Boolean.is_or expr then (
        let args = List.sort sort_fun (List.map aux (Z3.Expr.get_args expr)) in
        let fold_fun (leftf, (leftv, leftid)) (rightf, (rightv, rightid)) = 
          match Ht.find_opt tbl (Or (leftid, rightid)) with
          | Some f -> 
            (f, (uniq (leftv @ rightv), Or (leftid, rightid)))
          | None ->
            let func = make_or leftf rightf in
            Ht.add tbl (Or (leftid, rightid)) func;
            (func, (uniq (leftv @ rightv), Or(leftid, rightid)))
        in
        List.fold_left fold_fun (List.hd args) (List.tl args))
      else if Z3.Boolean.is_and expr then (
        let args = List.sort sort_fun (List.map aux (Z3.Expr.get_args expr)) in
        let fold_fun (leftf, (leftv, leftid)) (rightf, (rightv, rightid)) =
          match Ht.find_opt tbl (And (leftid, rightid)) with
          | Some f -> 
            (f, (uniq (leftv @ rightv), And (leftid, rightid)))
          | None ->
            let func = make_and leftf rightf in
            Ht.add tbl (And (leftid, rightid)) func;
            (func, (uniq (leftv @ rightv), And(leftid, rightid)))
        in
        List.fold_left fold_fun (List.hd args) (List.tl args))
      else if Z3.Boolean.is_not expr then (
        let (sub_form, (vars, id)) = aux (List.nth (Z3.Expr.get_args expr) 0) in
        match Ht.find_opt tbl (Not (id)) with
        | Some f -> 
          (f, (vars, Not id))
        | None ->
          let func = make_not sub_form in
          Ht.add tbl (Not id) func;
          (func, (vars, Not id)))
      else if Z3.Boolean.is_eq expr then (
        let args = List.sort sort_fun (List.map aux (Z3.Expr.get_args expr)) in
        let (leftf, (leftv, leftid)) = List.nth args 0 in
        let (rightf, (rightv, rightid)) = List.nth args 1 in
        match Ht.find_opt tbl (Eq (leftid, rightid)) with
        | Some f -> 
          (f, (uniq (leftv @ rightv), Eq(leftid, rightid)))
        | None ->
          let func = make_or (make_and leftf rightf) (make_and (make_not leftf) (make_not rightf)) in
          Ht.add tbl (Eq (leftid, rightid)) func;
          (func, (uniq (leftv @ rightv), Eq (leftid, rightid))))
      else (
        failwith ("unknown Expr node: \n" ^ (Z3.Expr.to_string expr))
      )
    in
    let (r, (vars, id)) = aux ex in
    (r, vars)
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

