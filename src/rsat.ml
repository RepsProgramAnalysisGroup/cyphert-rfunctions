module VarMap = Map.Make(String);;

module Logger = Log

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

let rec print_sorts expr = 
  Logger.log ((Z3.Sort.to_string (Z3.Expr.get_sort expr)) ^ "\n");
  if (Z3.Expr.get_num_args expr) = 0 then ()
  else 
    List.iter print_sorts (Z3.Expr.get_args expr)
  ;;

let parse query = 
  let ctx = Z3.mk_context [] in
  let ast_vec = Logger.log_time "Parsing" (Z3.SMT.parse_smtlib2_string ctx query [] [] []) [] in
  (ctx, Z3.Boolean.mk_and ctx (Z3.AST.ASTVector.to_expr_list ast_vec))
  ;;

module DL2 = Loss.Make ()
module DL2List = LossList.Make ()
module SL = Search.Make(DL2)
module SLL = Search.Make(DL2List)
module LPLL = Search.Sum(SL)(SLL)

type status = 
  | UNKNOWN
  | SAT of float VarMap.t
  | UNSAT

let iterations = ref 6

(*let r_fun expr ctx =
  let res = 
    if (Z3.Expr.to_string expr = "false") then (Logger.log ("unsat\n"); UNSAT) (*Z3 bug. Z3 says false is a variable sometimes*)
    else (
      let (new_form, assign) = Optimize.remove_triv expr ctx in
      Logger.log ("Optimized formula: " ^ (Z3.Expr.to_string new_form) ^ "\n") ~level:`trace;
      let search_res = Logger.log_time "Search" (Search.search new_form assign ~iter:!iterations) () in
      (match search_res with
        | None -> Logger.log ("unknown\n"); UNKNOWN
        | Some x -> Logger.log ("sat\n"); SAT x
      )
    ) in
  res
  ;;*)

let r_fun expr ctx =
  let res = 
    if (Z3.Expr.to_string expr = "false") then (Logger.log ("unsat\n"); UNSAT) (*Z3 bug. Z3 says false is a variable sometimes*)
    else (
      let (new_form, assign) = Optimize.remove_triv expr ctx in
      Logger.log ("Optimized formula: " ^ (Z3.Expr.to_string new_form) ^ "\n") ~level:`trace;
      let search_res = Logger.log_time "Search" (LPLL.search new_form assign ~iter:!iterations) () in
      (match search_res with
        | None -> Logger.log ("unknown\n"); UNKNOWN
        | Some x -> Logger.log ("sat\n"); SAT x
      )
    ) in
  res
  ;;


let rec make_sentence ctx assign expr =
  if Z3.Boolean.is_true expr then (
    Z3.Boolean.mk_true ctx)
  else if Z3.Boolean.is_false expr then (
    Z3.Boolean.mk_false ctx)
  else if Z3.Boolean.is_and expr then (
    let subforms = List.map (fun ex -> make_sentence ctx assign ex) (Z3.Expr.get_args expr) in
    Z3.Boolean.mk_and ctx subforms) 
  else if Z3.Boolean.is_or expr then (
    let subforms = List.map (fun ex -> make_sentence ctx assign ex) (Z3.Expr.get_args expr) in
    Z3.Boolean.mk_or ctx subforms)
  else if Z3.Boolean.is_not expr then (
    let subform = make_sentence ctx assign (List.nth (Z3.Expr.get_args expr) 0) in
    Z3.Boolean.mk_not ctx subform)
  else if Z3.Expr.is_const expr then (
    let name = Z3.Expr.to_string expr in
    let v = VarMap.find name assign in
    if v > 0.5 then
      Z3.Boolean.mk_true ctx
    else 
      Z3.Boolean.mk_false ctx)
  else if Z3.Boolean.is_eq expr then (
    let subforms = List.map (fun ex -> make_sentence ctx assign ex) (Z3.Expr.get_args expr) in
    Z3.Boolean.mk_eq ctx (List.nth subforms 0) (List.nth subforms 1))
  else ( failwith (Z3.Expr.to_string expr));;

let r_test ctx assign expr =
  match assign with
  | UNSAT -> "UNSAT"
  | UNKNOWN -> "OKAY"
  | SAT assig ->
    if Z3.Expr.to_string (Z3.Expr.simplify (make_sentence ctx assig expr) None) = "true" then "PASS"
    else "FAIL"

let test_rewrite old_ctx aufbv new_ctx sat =
  let old_solver = Z3.Solver.mk_solver old_ctx None in
  let new_solver = Z3.Solver.mk_solver new_ctx None in
  if (Z3.Solver.check old_solver [aufbv]) = (Z3.Solver.check new_solver [sat]) then "PASS"
  else "FAIL"

let log_out_file = ref false;;
let test_assign = ref false;;
let test_translate = ref false;;
let no_array_theory = ref false;;

let test arg = 
  match arg with
  | "rewrite" -> test_translate := true
  | "assign" -> test_assign := true
  | _ -> failwith "Unknown testing argument"

let setOut fileName = 
  log_out_file := true;
  Logger.set_chan (open_out fileName);;
  
let sat_file in_file_name = 
  let ic = open_in in_file_name in
  let smt = read_file ic "" in
  let (ctx, input_expr) = parse smt in
  let bit_blast = fun () ->
    if !no_array_theory then Bv2sat.bv2bool ctx input_expr
    else Bv2sat.aufbv2bool ctx input_expr
  in
  let (new_ctx, sat) = Logger.log_time "SMT2SAT" bit_blast () in
  let res = r_fun sat new_ctx in
  if !test_assign then Logger.log ((r_test new_ctx res sat) ^ "\n");
  close_in ic;
  if (!log_out_file) then close_out !Logger.chan
  else ()
  ;;

let register () = 
  let speclist = [("-o", Arg.String setOut, "Set an output file"); 
                  ("-v", Arg.String Logger.set_level, "Set versbosity [trace | debug | always]");
                  ("-test", Arg.String test, "Test functionality [rewrite | assign]");
                  ("-time", Arg.Set Logger.log_times, "Log execution times");
                  ("-i", Arg.Set_int iterations, "The number of search iterations. Default is 6");
                  ("-no_array", Arg.Set no_array_theory, "The input file does not contain array terms");
                  ("-wen_list", Arg.Clear LPLL.use_left, "Use a Wengert list")] in
  let usage = "rsat.native <smt2-file>" in
  Arg.parse speclist sat_file usage

let () =
  register ()
  ;;
