module VarMap = Map.Make(String);;

module Logger = Log;;

module Make (A : sig 
                  val grad : unit -> float VarMap.t 
                  val eval_init : Z3.Expr.expr ->float VarMap.t option -> float -> float * string list 
                  val eval : float VarMap.t -> float 
                  val stopping_rule : float -> bool
                  val update : float -> float -> float
                end) = struct 
  
  let grad_search initial iterations =
    let rec aux init iter =
      let grad = Logger.log_time "Grad" A.grad () in
      Logger.log ~level:`trace "Gradient";
      Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) grad "") ^ "\n\n");
      let update_func var var_value = A.update var_value (VarMap.find var grad) in
      init := VarMap.mapi update_func !init;
      let value = Logger.log_time "Eval" A.eval !init in
      Logger.log ~level:`debug ("current_value := " ^ (string_of_float value) ^ "\n");
      Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init "") ^ "\n\n");
      if (A.stopping_rule value) then (
        Some !init
      ) else if (iter = 0) then(
        None
      ) else (
        aux init (iter - 1))
      in
      aux initial iterations
    ;;
  
  let search expr assign iter () = 
    let init_val = 0. in
    let (value, vars) = Logger.log_time "Init eval" (A.eval_init expr assign) init_val in
    let init_map = ref VarMap.empty in
    List.iter (
      fun var -> init_map := VarMap.add var init_val !init_map
    ) vars;
    Logger.log ~level:`debug ("current_value := " ^ (string_of_float value) ^ "\n");
    Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init_map "") ^ "\n\n");
    if value = 0. then (
      Some !init_map
    ) else (
      grad_search init_map (iter-1)
    )
    ;;
  
end


module Sum(A: sig val search : Z3.Expr.expr -> float VarMap.t option -> int -> unit -> float VarMap.t option end)(B: sig val search : Z3.Expr.expr -> float VarMap.t option -> int -> unit -> float VarMap.t option end) = struct
  let use_left = ref true

  let search expr assign ?(iter = 50) () = 
    if !use_left then A.search expr assign iter ()
    else B.search expr assign iter ()
end