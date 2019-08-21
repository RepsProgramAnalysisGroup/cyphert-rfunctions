open Rfun

module Acta = Make (struct
  let orFun = Plus (Plus (X, Y), Pow (Plus (Pow (X, 2.), Pow (Y, 2.)), 0.5))
  let notFun = Times (Const (-1.), X)
  let baseFun = Plus (X, Const (-0.5))
end)


let remove_array s =
  let arrayReg = Str.regexp "^( *declare-fun +\\(\\([a-zA-Z0-9]\\|_\\)+\\) +() +( *Array.*$" in
  let rec aux str =
    try
      let _ = Str.search_forward arrayReg str 0 in
      let arrayline = Str.matched_string str in
      let arrayname = Str.replace_first arrayReg "\\1" arrayline in
      let ar0 = "( *select +" ^ arrayname ^ " +(_ bv0 32) *)" in
      let ar1 = "( *select +" ^ arrayname ^ " +(_ bv1 32) *)" in
      let ar2 = "( *select +" ^ arrayname ^ " +(_ bv2 32) *)" in
      let ar3 = "( *select +" ^ arrayname ^ " +(_ bv3 32) *)" in
      let arraydec = "( *declare-fun +" ^ arrayname ^ " +() +( *Array +(_ BitVec 32) (_ BitVec 8) *) *)" in
      let new_dec = "(declare-const " ^ arrayname ^ "0 (_ BitVec 8))\n(declare-const " ^ arrayname ^ "1 (_ BitVec 8))\n(declare-const " ^ arrayname ^ "2 (_ BitVec 8))\n(declare-const " ^ arrayname ^ "3 (_ BitVec 8))" in
      let ret = Str.global_replace (Str.regexp ar0) (arrayname ^ "0") str in
      let ret = Str.global_replace (Str.regexp ar1) (arrayname ^ "1") ret in
      let ret = Str.global_replace (Str.regexp ar2) (arrayname ^ "2") ret in
      let ret = Str.global_replace (Str.regexp ar3) (arrayname ^ "3") ret in
      aux (Str.global_replace (Str.regexp arraydec) new_dec ret)
    with Not_found ->
      str
  in
  let res = aux s in
  let get_val = "^( *get-value.*)$" in
  Str.global_replace (Str.regexp get_val) "" res
  ;;

let rec read_file in_channel res =
  try
    let line = input_line in_channel in
    if (Str.string_match (Str.regexp "(get-value") line 0) then
      read_file in_channel res
    else
      read_file in_channel (res ^ "\n" ^ line)
  with End_of_file ->
    res
  ;;


let rec make_sentence assign expr ctx =
  if Z3.Boolean.is_true expr then (
    Z3.Boolean.mk_true ctx)
  else if Z3.Boolean.is_false expr then (
    Z3.Boolean.mk_false ctx)
  else if Z3.Boolean.is_and expr then (
    let subforms = List.map (fun ex -> make_sentence assign ex ctx) (Z3.Expr.get_args expr) in
    Z3.Boolean.mk_and ctx subforms) 
  else if Z3.Boolean.is_or expr then (
    let subforms = List.map (fun ex -> make_sentence assign ex ctx) (Z3.Expr.get_args expr) in
    Z3.Boolean.mk_or ctx subforms)
  else if Z3.Boolean.is_not expr then (
    let subform = make_sentence assign (List.nth (Z3.Expr.get_args expr) 0) ctx in
    Z3.Boolean.mk_not ctx subform)
  else if Z3.Expr.is_const expr then (
    let name = Z3.Expr.to_string expr in
    let v = VarMap.find name assign in
    if v > 0.5 then
      Z3.Boolean.mk_true ctx
    else 
      Z3.Boolean.mk_false ctx
  ) else ( failwith (Z3.Expr.to_string expr));;


let rec grad_search_assign formula init iter =
  let (value, grad) = formula !init in
  if (value > 0.) then (
    Some !init
  ) else if (iter = 0) then(
    None
  ) else ( 
    let update var x =
      if x < 0. && (VarMap.find var !init) > 0. then 
        init := VarMap.update var (fun x -> Some 0.) !init
      else if x > 0. && (VarMap.find var !init) < 1. then
        init := VarMap.update var (fun x -> Some 1.) !init
      else ()
    in
    VarMap.iter update grad;
    grad_search_assign formula init (iter - 1))
  ;;

  
let search_assign form init_opt vars ?(iter=50) () =
  match init_opt with
  | None -> grad_search_assign form (Search.init_map vars) iter
  | Some x -> grad_search_assign form x iter
  ;;


let r_fun_test query =
    let ctx = Z3.mk_context [] in
    let sim = Z3.Tactic.mk_tactic ctx "simplify" in
    let bit = Z3.Tactic.mk_tactic ctx "bit-blast" in
    let sim_then_bit = Z3.Tactic.and_then ctx sim bit [] in
    let expr = Z3.SMT.parse_smtlib2_string ctx (remove_array query) [] [] [] [] in
    let g = Z3.Goal.mk_goal ctx false false false in
    Z3.Goal.add g [expr];
    let app_res = Z3.Tactic.apply sim_then_bit g None in
    let bit_blasted = Z3.Goal.as_expr (Z3.Tactic.ApplyResult.get_subgoal app_res 0) in
    let (r_fun, variables) = Acta.make_r bit_blasted in
    (search_assign r_fun None variables ~iter:6 (), bit_blasted, ctx);;

let test query =
    let (assign, expr, ctx) = r_fun_test query in
    match assign with
    | None -> "PASS"
    | Some assig -> 
      if Z3.Expr.to_string (Z3.Expr.simplify (make_sentence assig expr ctx) None) = "true" then "PASS"
      else "FAIL"
  ;;

let () = 
  let ic = open_in Sys.argv.(1) in
  let smt = read_file ic "" in
  close_in ic;
  print_endline (test smt)
