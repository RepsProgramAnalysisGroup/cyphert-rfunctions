module VarMap = Map.Make(String);;

module Logger = Log

module Make (A : Sigs.BoolEmb) : Sigs.BuildSearch = struct

  include A

  module IntTbl = Hashtbl.Make(struct type t = int let equal = (=) let hash = Hashtbl.hash end)

  let expr_tbl = IntTbl.create 1000

  let vars = ref []

  let rec translate_fun expr = 
    if Z3.Arithmetic.is_arithmetic_numeral expr then (
      let value = float_of_string (Z3.Expr.to_string expr) in
      A.make_const value
    )
    else if Z3.Expr.is_const expr then (
      let name = (Z3.Expr.to_string expr) in
      if not (List.mem name !vars) then (vars := name :: !vars);
      A.make_var name)
    else if Z3.Arithmetic.is_add expr then (
      let children = List.map translate_fun (Z3.Expr.get_args expr) in
      List.fold_left A.make_add (List.hd children) (List.tl children))
    else if Z3.Arithmetic.is_mul expr then (
      let children = List.map translate_fun (Z3.Expr.get_args expr) in
      List.fold_left A.make_mult (List.hd children) (List.tl children))
    else if Z3.Arithmetic.is_uminus expr then (
      let child = translate_fun (List.nth (Z3.Expr.get_args expr) 0) in
      let minus_1 = A.make_const (-1.) in
      A.make_mult child minus_1)
    else if Z3.Arithmetic.is_sub expr then (
      let children = List.map translate_fun (Z3.Expr.get_args expr) in
      let left = List.nth children 0 in
      let neg_right = A.make_mult (List.nth children 1) (A.make_const (-1.)) in
      A.make_add left neg_right)
    else if Z3.Arithmetic.is_div expr then (
      let children = List.map translate_fun (Z3.Expr.get_args expr) in
      A.make_div (List.nth children 0) (List.nth children 1))
    else failwith ("Unsupported base function: " ^ (Z3.Expr.to_string expr))

  let make_ge left_fun right_fun =
    let minus_1 = A.make_const (-1.) in
    let neg_right = A.make_mult right_fun minus_1 in
    A.make_add left_fun neg_right

  let make_equal left_fun right_fun =
    let l_ge_r = make_ge left_fun right_fun in
    let r_ge_l = make_ge right_fun left_fun in
    A.make_and l_ge_r r_ge_l

  let make_gt left_fun right_fun =
    let ge = make_ge left_fun right_fun in
    let equ = make_equal left_fun right_fun in
    A.make_and ge (A.make_not equ)

  let make_base expr = 
    if Z3.Arithmetic.is_ge expr then (
      let children = Z3.Expr.get_args expr in
      let (left, right) = (translate_fun (List.nth children 0), translate_fun (List.nth children 1)) in
      make_ge left right)
    else if Z3.Arithmetic.is_le expr then (
      let children = Z3.Expr.get_args expr in
      let (left, right) = (translate_fun (List.nth children 0), translate_fun (List.nth children 1)) in
      make_ge right left)
    else if Z3.Arithmetic.is_gt expr then (
      let children = Z3.Expr.get_args expr in
      let (left, right) = (translate_fun (List.nth children 0), translate_fun (List.nth children 1)) in
      make_gt left right)
    else if Z3.Arithmetic.is_lt expr then (
      let children = Z3.Expr.get_args expr in
      let (left, right) = (translate_fun (List.nth children 0), translate_fun (List.nth children 1)) in
      make_gt right left)
    else failwith ("Unknown Predicate: " ^ (Z3.Expr.to_string expr))

  let embed ex set_vals =
    let rec aux expr =
      let expr_id = Z3.AST.get_id (Z3.Expr.ast_of_expr expr) in
      try
        IntTbl.find expr_tbl expr_id
      with Not_found ->
        if Z3.Boolean.is_true expr || Z3.Expr.to_string expr = "true" then (
          A.make_true ())
        else if Z3.Boolean.is_false expr || Z3.Expr.to_string expr = "false" then (
          A.make_false ())
        else if Z3.Expr.is_const expr then (
          failwith "Possible boolean const in NL formula"
          (*let name = (Z3.Expr.to_string expr) in
          try
            let value = VarMap.find name set_vals in
            if value > 0.5 then A.make_true ()
            else A.make_false ()
          with Not_found ->
            if not (List.mem name !vars) then (vars := name :: !vars);
            make_base name*))
        else if Z3.Boolean.is_or expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          let fold_fun left right =
            A.make_or left right
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
          (*let args = List.map aux (Z3.Expr.get_args expr) in
          Logger.log ~level:`trace (string_of_int (List.length args));
          (0, (Const (0.), [])))*)
          let args = List.map aux (Z3.Expr.get_args expr) in
          let fold_fun left right =
            A.make_and left right
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
          if (Z3.Boolean.is_true child || Z3.Expr.to_string child = "true") then ( (*Shouldn't need to check explicitly true or false*)
            A.make_false ())
          else if (Z3.Boolean.is_false child || Z3.Expr.to_string child = "false") then ( (*Shouldn't need to check explicitly true or false*)
            A.make_true ())
          else (
            let base = aux child in
            A.make_not base))
        else if Z3.Boolean.is_eq expr then (
          (*This might need to be modified*)
          let args = List.map aux (Z3.Expr.get_args expr) in
          let res = A.make_eq (List.nth args 0) (List.nth args 1) in
          IntTbl.add expr_tbl expr_id res;
          res)
        else (
          make_base expr
        )
    in
    let _ = aux ex in
    A.build_complete ();
    Logger.log "Build Complete\n" ~level:`trace;
    !vars
end