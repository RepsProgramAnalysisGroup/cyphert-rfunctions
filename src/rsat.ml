open Rfun

module Acta = Make (struct
  let orFun = Plus (Plus (X, Y), Pow (Plus (Pow (X, 2.), Pow (Y, 2.)), 0.5))
  let notFun = Times (Const (-1.), X)
  let baseFun = Plus (X, Const (-0.5))
end)

module Logger = Log

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

let r_fun_test query =
  let ctx = Z3.mk_context [] in
  let sim= Z3.Tactic.mk_tactic ctx "simplify" in
  let bit = Z3.Tactic.mk_tactic ctx "bit-blast" in
  let sim_then_bit = Z3.Tactic.and_then ctx sim bit [] in
  let expr = Logger.log_time "Parsing" (Z3.SMT.parse_smtlib2_string ctx (remove_array query) [] [] []) [] in
  let g = Z3.Goal.mk_goal ctx false false false in
  Z3.Goal.add g [expr];
  let app_res = Logger.log_time "Bit-blast" (Z3.Tactic.apply sim_then_bit g) None in
  let bit_blasted = Z3.Goal.as_expr (Z3.Tactic.ApplyResult.get_subgoal app_res 0) in
  let (r_fun, variables) = Logger.log_time "R-Construction" Acta.make_r bit_blasted in
  let res = Logger.log_time "Search" (Search.search r_fun None variables ~iter:6) () in
  Logger.log (res ^ "\n")
  ;;


let log_out_file = ref false;;

let setOut fileName = 
  log_out_file := true;
  Logger.set_chan (open_out fileName);;
  
let sat_file in_file_name = 
  let ic = open_in in_file_name in
  let smt = read_file ic "" in
  r_fun_test smt;
  close_in ic;
  if (!log_out_file) then close_out !Logger.chan
  else ()
  ;;

let register () = 
  let speclist = [("-o", Arg.String setOut, "Set an output file"); 
                  ("-v", Arg.String Logger.set_level, "Set versbosity [trace | debug | always]");
                  ("-time", Arg.Set Logger.log_times, "Log execution times")] in
  let usage = "rsat smt2" in
  Arg.parse speclist sat_file usage

let () =
  register ()
  ;;
