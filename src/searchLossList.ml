module VarMap = Map.Make(String);;

module Logger = Log;;

module Make (A : sig val grad : unit -> float VarMap.t val eval_init : Z3.Expr.expr ->float VarMap.t option -> float -> float * string list val eval : float VarMap.t -> float end) = struct 
  
  let grad_search initial iterations =
    let rec aux init iter =
      let grad = Logger.log_time "Grad" A.grad () in
        Logger.log ~level:`debug "Gradient";
        Logger.log ~level:`debug ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) grad "") ^ "\n\n");
        let update var x =
          if x > 0. && (VarMap.find var !init) > 0. then
            init := VarMap.update var (fun x -> Some 0.) !init
          else if x < 0. && (VarMap.find var !init) < 1. then
            init := VarMap.update var (fun x -> Some 1.) !init
          else ()
        in
        VarMap.iter update grad;
      let value = Logger.log_time "Eval" A.eval !init in
      Logger.log ~level:`debug ("current_value := " ^ (string_of_float value) ^ "\n");
      Logger.log ~level:`debug ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init "") ^ "\n\n");
      if (value = 0.) then (
        Some !init
      ) else if (iter = 0) then(
        None
      ) else (
        aux init (iter - 1))
      in
      aux initial iterations
    ;;
  
  let search expr assign ?(iter=50) () = 
    let init_val = 0. in
    let (value, vars) = Logger.log_time "Init eval" (A.eval_init expr assign) init_val in
    let init_map = ref VarMap.empty in
    List.iter (
      fun var -> init_map := VarMap.add var init_val !init_map
    ) vars;
    Logger.log ~level:`debug ("current_value := " ^ (string_of_float value) ^ "\n");
    Logger.log ~level:`debug ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init_map "") ^ "\n\n");
    if value = 0. then (
      Some !init_map
    ) else (
      grad_search init_map (iter-1)
    )
    ;;
  
end
