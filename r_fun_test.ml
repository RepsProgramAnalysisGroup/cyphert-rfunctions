module VarMap = Map.Make(String);;

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
  ;;

let add_maps mx my = 
  VarMap.union (fun key a b -> Some (a +. b)) mx my;;

let make_plus f g = 
  let sub = fun vars ->
    let (fv, df) = f vars in
    let (gv, dg) = g vars in
    (fv +. gv, add_maps df dg)
  in
  memo sub
  ;;

let make_pow n f =
  let sub = fun vars ->
    let (value, df) = (f vars) in
    let multiplier = n *. (value)**(n -. 1.) in
    (value ** n, VarMap.map (fun x -> multiplier *. x) df)
  in
  memo sub
  ;;

let make_base var = 
  let sub = fun vars ->
    let value = (VarMap.find var vars) -. 0.5 in
    let df = VarMap.empty in
    (value, VarMap.add var (1.) df)
  in
  memo sub
  ;;

let make_or f g = 
  let sub = fun vars ->
    let f_plus_g = make_plus f g  in
    let f_squared = make_pow 2. f in
    let g_squared = make_pow 2. g in
    let fs_plus_gs = make_plus f_squared g_squared in
    let root = make_pow 0.5 fs_plus_gs in
    (make_plus f_plus_g root) vars
  in
  memo sub
  ;;
  

let make_not f =
  let sub = fun vars -> 
    let (value, df) = f vars in
    (-1. *. value, VarMap.map (fun v -> -1. *. v) df)
  in
  memo sub
  ;;

let make_and f g = 
  let sub = fun vars ->
    let not_f = make_not f in
    let not_g = make_not g in
    make_not (make_or not_f not_g) vars
  in
  memo sub
  ;;
  
let make_true vars = 
  (1., VarMap.empty);;

let make_false vars = 
  (-1., VarMap.empty);;


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
  ;;


let uniq lst =
  let unique_set = Hashtbl.create (List.length lst) in
  List.iter (fun x -> Hashtbl.replace unique_set x ()) lst;
  Hashtbl.fold (fun x () xs -> x :: xs) unique_set []
  ;;

let init_map variables = 
  let res = ref VarMap.empty in
  List.iter (fun var -> res := VarMap.add var 0. !res) variables;
  res
  ;;

let rec search formula init iter=
  let (value, grad) = formula !init in
  (*print_endline ("current_value := " ^ (string_of_float value));
  VarMap.iter (fun key x -> print_endline (key ^ " := " ^ (string_of_float x))) !init;
  print_endline "Gradient";  
  VarMap.iter (fun key x -> print_endline (key ^ " := " ^ (string_of_float x))) grad;
  print_endline "";*)
  if (value > 0.) then (
    "SAT";
    (*VarMap.iter (fun key x -> print_endline (key ^ " := " ^ (string_of_float x))) !init*)
  ) else if (iter = 0) then(
    "UNKNOWN"
  ) else (
    let update var x = 
      if x < 0. && (VarMap.find var !init) > 0. then 
        init := VarMap.update var (fun x -> Some 0.) !init
      else if x > 0. && (VarMap.find var !init) < 1. then
        init := VarMap.update var (fun x -> Some 1.) !init
      else () 
    in
    VarMap.iter update grad;
    search formula init (iter - 1))
  ;;


let smtlib = "(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (bvand  (bvlshr  (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) (_ bv11 32) ) (_ bv31 32) ) ) ) (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) ?B1 ) ) ) (=  false (=  (_ bv1 32) ?B1 ) ) ) (=  false (=  (_ bv2 32) ?B1 ) ) ) (=  false (=  (_ bv3 32) ?B1 ) ) ) (=  false (=  (_ bv4 32) ?B1 ) ) ) ) )
";;


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
  let sim = Z3.Tactic.mk_tactic ctx "simplify" in
  let bit = Z3.Tactic.mk_tactic ctx "bit-blast" in
  let sim_then_bit = Z3.Tactic.and_then ctx sim bit [] in
  let expr = Z3.SMT.parse_smtlib2_string ctx (remove_array query) [] [] [] [] in
  let g = Z3.Goal.mk_goal ctx false false false in
  Z3.Goal.add g [expr];
  let app_res = Z3.Tactic.apply sim_then_bit g None in
  let bit_blasted = Z3.Goal.as_expr (Z3.Tactic.ApplyResult.get_subgoal app_res 0) in
  let (r_fun, variables) = make_r bit_blasted in
  search r_fun (init_map (uniq variables)) 50
  ;;
  
let z3_test query = 
  let ctx = Z3.mk_context [] in
  let expr = Z3.SMT.parse_smtlib2_string ctx query [] [] [] [] in
  let solv = Z3.Solver.mk_solver ctx None in
  Z3.Solver.add solv [expr];
  match (Z3.Solver.check solv []) with
  | Z3.Solver.UNSATISFIABLE ->
    "UNSAT"
  | Z3.Solver.SATISFIABLE ->
    "SAT"
  | _ -> "UNKNOWN"
  ;;

let time f =
  let t = Unix.gettimeofday () in
  let res = f () in
  let tim = Unix.gettimeofday () -. t in
  (res, tim)
;;

let () = 
  let file_name = Sys.argv.(1) in
  let ic = open_in file_name in
  let smt = read_file ic "" in
  close_in ic;
  let reported_time_reg = "^; +OK -- Elapsed:.*$" in
  let _ = Str.search_forward (Str.regexp reported_time_reg) smt 0 in
  let time_line = Str.matched_string smt in
  let _ = Str.search_forward (Str.regexp "[0-9][0-9.e-]*") time_line 0 in
  let reported_time = float_of_string (Str.matched_string time_line) in
  let (r_res, r_time) = time (fun () -> r_fun_test smt) in 
  let (z3_res, z3_time) = time (fun () -> z3_test smt) in 
  let out_file_name = file_name ^ ".out" in
  let oc = open_out("output/" ^ out_file_name) in
  Printf.fprintf oc "R_fun result: %s time: %f\n" r_res r_time;
  Printf.fprintf oc "Z3 result: %s time: %f\n" z3_res z3_time;
  Printf.fprintf oc "Reported time: %f\n" reported_time;
  close_out oc
  ;;
