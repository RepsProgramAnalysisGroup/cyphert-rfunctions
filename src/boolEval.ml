module Logger = Log

module VarMap = Map.Make(String)

module Make (A : sig val eval_base : float VarMap.t -> Z3.Expr.expr -> bool end) = struct

  let rec eval assignment expr =
    if Z3.Boolean.is_true expr || Z3.Expr.to_string expr = "true" then (
      true)
    else if Z3.Boolean.is_false expr || Z3.Expr.to_string expr = "false" then (
      false)
    else if Z3.Boolean.is_or expr then (
      List.fold_left (||) false (List.map (eval assignment) (Z3.Expr.get_args expr)))
    else if Z3.Boolean.is_and expr then (
      List.fold_left (&&) true (List.map (eval assignment) (Z3.Expr.get_args expr)))
    else if Z3.Boolean.is_not expr then (
      not (eval assignment (List.nth (Z3.Expr.get_args expr) 0)))
    else if Z3.Boolean.is_eq expr then (
      let (left, right) = (eval assignment (List.nth (Z3.Expr.get_args expr) 0), eval assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      left = right)
    else if Z3.Boolean.is_iff expr then (
      let (left, right) = (eval assignment (List.nth (Z3.Expr.get_args expr) 0), eval assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      left = right)
    else if Z3.Boolean.is_implies expr then (
      let (left, right) = (eval assignment (List.nth (Z3.Expr.get_args expr) 0), eval assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      not left || right)
    else if Z3.Boolean.is_xor expr then (
      let (left, right) = (eval assignment (List.nth (Z3.Expr.get_args expr) 0), eval assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      (left || right) && not (left && right))
    else A.eval_base assignment expr

end

module RfunBoolean = struct
  let eval_base assignment expr = 
    if Z3.Expr.is_const expr then (
      let name = (Z3.Expr.to_string expr) in
      (VarMap.find name assignment) > 0.)
    else failwith ("Unsupported function in boolean: " ^ (Z3.Expr.to_string expr))
end

module Arithmetic = struct

  let rec eval_function assignment expr = 
    if Z3.Arithmetic.is_arithmetic_numeral expr then (
      float_of_string (Z3.Expr.to_string expr))
    else if Z3.Expr.is_const expr then (
      let name = (Z3.Expr.to_string expr) in
      VarMap.find name assignment)
    else if Z3.Arithmetic.is_add expr then (
      let children = List.map (eval_function assignment) (Z3.Expr.get_args expr) in
      List.fold_left (+.) (List.hd children) (List.tl children))
    else if Z3.Arithmetic.is_mul expr then (
      let children = List.map (eval_function assignment) (Z3.Expr.get_args expr) in
      List.fold_left ( *. ) (List.hd children) (List.tl children))
    else if Z3.Arithmetic.is_uminus expr then (
      let child = (eval_function assignment) (List.nth (Z3.Expr.get_args expr) 0) in
      (-1.) *. child)
    else if Z3.Arithmetic.is_sub expr then (
      let children = List.map (eval_function assignment) (Z3.Expr.get_args expr) in
      (List.nth children 0) -. (List.nth children 1))
    else if Z3.Arithmetic.is_div expr then (
      let children = List.map (eval_function assignment) (Z3.Expr.get_args expr) in
      (List.nth children 0) /. (List.nth children 1))
    else failwith ("Unsupported base function: " ^ (Z3.Expr.to_string expr))    

  let eval_base assignment expr = 
    if Z3.Arithmetic.is_ge expr then (
      let (left, right) = (eval_function assignment (List.nth (Z3.Expr.get_args expr) 0), eval_function assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      left >= right)
    else if Z3.Arithmetic.is_gt expr then (
      let (left, right) = (eval_function assignment (List.nth (Z3.Expr.get_args expr) 0), eval_function assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      left > right)
    else if Z3.Arithmetic.is_le expr then (
      let (left, right) = (eval_function assignment (List.nth (Z3.Expr.get_args expr) 0), eval_function assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      left <= right)
    else if Z3.Arithmetic.is_lt expr then (
      let (left, right) = (eval_function assignment (List.nth (Z3.Expr.get_args expr) 0), eval_function assignment (List.nth (Z3.Expr.get_args expr) 1)) in
      left < right)
    else failwith ("Unrecognized arithmetic predicate: " ^ (Z3.Expr.to_string expr))
end

module RfunBoolEval = Make(RfunBoolean)

module ArithEval = Make(Arithmetic)