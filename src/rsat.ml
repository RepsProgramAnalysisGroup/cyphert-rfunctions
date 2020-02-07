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

let parse query = 
  let ctx = Z3.mk_context [] in
  let ast_vec = Logger.log_time "Parsing" (Z3.SMT.parse_smtlib2_string ctx query [] [] []) [] in
  (ctx, Z3.Boolean.mk_and ctx (Z3.AST.ASTVector.to_expr_list ast_vec))
  ;;  

module Rfunction = Translate.Make(Rfun.Make(GraphAD.Make ()))
module Loss = Translateloss.Make(Loss.Make(GraphAD.Make ()))
module MakeSearch (A: Sigs.BuildSearch) = struct include Search.Make(A) include A end
module RSearch = MakeSearch(Rfunction)

type status = 
  | UNKNOWN
  | SAT of float VarMap.t
  | UNSAT

let iterations = ref 6


let r_fun expr ctx =
  let res = 
    if (Z3.Expr.to_string expr = "false") then (Logger.log ("unsat\n"); UNSAT) (*Z3 bug. Z3 says false is a variable sometimes*)
    else (
      let (new_form, assign) = Optimize.remove_triv expr ctx in
      Logger.log ("Optimized formula: " ^ (Z3.Expr.to_string new_form) ^ "\n") ~level:`trace;
      let vars = RSearch.embed new_form assign in
      let search_res = Logger.log_time "Search" (RSearch.search vars 0. ~iter:!iterations) () in
      (match search_res with
        | None -> Logger.log ("unknown\n"); UNKNOWN
        | Some x -> Logger.log ("sat\n"); SAT x
      )
    ) in
  res
  ;;


let log_out_file = ref false;;
let test_translate = ref false;;
let no_array_theory = ref false;;

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
  close_in ic;
  if (!log_out_file) then close_out !Logger.chan
  else ()
  ;;

let register () = 
  let speclist = [("-o", Arg.String setOut, "Set an output file"); 
                  ("-v", Arg.String Logger.set_level, "Set versbosity [trace | debug | always]");
                  ("-time", Arg.Set Logger.log_times, "Log execution times");
                  ("-i", Arg.Set_int iterations, "The number of search iterations. Default is 6");
                  ("-no_array", Arg.Set no_array_theory, "The input file does not contain array terms")] in
  let usage = "rsat.native <smt2-file>" in
  Arg.parse speclist sat_file usage

let () =
  register ()
  ;;
