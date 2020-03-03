module VarMap = Map.Make(String);;

module Logger = Log


module FloatDT = struct 
  type t = float
  let add = (+.)
  let mult = ( *. )
  let div = (/.)
  let exp = ( ** )
  let const = float_of_string
  let to_string = string_of_float
  let compare = compare 
end

module MakeSearch (A: Sigs.BuildSearch) = struct include Search.Make(A) let embed = A.embed let from_string = A.from_string let to_string = A.to_string end
module RSearch = MakeSearch(Translate.MakeRfunBool(GraphAD.Make(FloatDT)))
module RNonLin = MakeSearch(Translate.MakeRfunArith(GraphAD.Make(FloatDT)))


type status = 
  | UNKNOWN
  | SAT of string VarMap.t
  | UNSAT

let iterations = ref 6

let log_out_file = ref false

let check_assign = ref false

type theory = 
  | Arith
  | AUFBV
  | BV

let theory = ref BV;;

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


let r_fun_arith expr ctx =
  let res = 
    if (Z3.Expr.to_string expr = "false") then (Logger.log ("unsat\n"); UNSAT) (*Z3 bug. Z3 says false is a variable sometimes*)
    else (
      let vars = RNonLin.embed ctx expr VarMap.empty in
      let search_res = Logger.log_time "Search" (RNonLin.search vars (RNonLin.from_string "1") ~iter:!iterations) () in
      (match search_res with
        | None -> Logger.log ("unknown\n"); UNKNOWN
        | Some x -> Logger.log ("sat\n"); 
        (*if !check_assign then (if (BoolEval.ArithEval.eval x expr) then Logger.log ~level:`always "Assignment was truly a model!\n"
                                 else Logger.log ~level:`always "Solver gave an incorrect model\n");*)
        SAT (VarMap.map RNonLin.to_string x)
      )
    ) in
  res

let r_fun_bool expr ctx =
  let res = 
    if (Z3.Expr.to_string expr = "false") then (Logger.log ("unsat\n"); UNSAT) (*Z3 bug. Z3 says false is a variable sometimes*)
    else (
      (*let (new_form, assign) = Optimize.remove_triv expr ctx in
      Logger.log ("Optimized formula: " ^ (Z3.Expr.to_string new_form) ^ "\n") ~level:`trace;*)
      let vars = RSearch.embed ctx expr VarMap.empty in
      let search_res = Logger.log_time "Search" (RSearch.search vars (RSearch.from_string "0") ~iter:!iterations) () in
      (match search_res with
        | None -> Logger.log ("unknown\n"); UNKNOWN
        | Some x -> Logger.log ("sat\n"); 
          (*if !check_assign then (if (BoolEval.RfunBoolEval.eval (VarMap.union (fun key a b -> failwith "Overloaded assignment") x assign) expr) then Logger.log ~level:`always "Assignment was truly a model!\n"
                                 else Logger.log ~level:`always "Solver gave an incorrect model\n");*)
          
          SAT (VarMap.map RSearch.to_string x)
      )
    ) in
  res
  
let r_fun_bv expr ctx =
  let bit_blast = fun () -> Bv2sat.bv2bool ctx expr in
  let (new_ctx, sat) = Logger.log_time "BV2SAT" bit_blast () in
  r_fun_bool sat new_ctx
    
let r_fun_aufbv expr ctx =
  let bit_blast = fun () -> Bv2sat.aufbv2bool ctx expr in
  let (new_ctx, sat) = Logger.log_time "AUFBV2SAT" bit_blast () in
  r_fun_bool sat new_ctx


let setOut fileName = 
  log_out_file := true;
  Logger.set_chan (open_out fileName);;

let setTheory arg = 
  match arg with
  | "arith" -> theory := Arith
  | "aufbv" -> theory := AUFBV
  | "bv" -> theory := BV
  | _ -> failwith "Unrecognized Theory"
  

let sat_file in_file_name = 
  let ic = open_in in_file_name in
  let smt = read_file ic "" in
  let (ctx, input_expr) = parse smt in
  let res = (match !theory with
    | Arith -> r_fun_arith input_expr ctx
    | AUFBV -> r_fun_aufbv input_expr ctx
    | BV -> r_fun_bv input_expr ctx
  ) in
  close_in ic;

  if (!log_out_file) then close_out !Logger.chan
  else ()

let register () = 
  let speclist = [("-o", Arg.String setOut, "Set an output file"); 
                  ("-v", Arg.String Logger.set_level, "Set versbosity [trace | debug | always]");
                  ("-time", Arg.Set Logger.log_times, "Log execution times");
                  ("-i", Arg.Set_int iterations, "The number of search iterations. Default is 6");
                  ("-check_model", Arg.Set check_assign, "Check whether the model produced is a true model");
                  ("-theory", Arg.String setTheory, "The theory solver to use [arith | aufbv | bv]")] in
  let usage = "rsat.native <smt2-file>" in
  Arg.parse speclist sat_file usage

let () =
  register ()
  ;;
