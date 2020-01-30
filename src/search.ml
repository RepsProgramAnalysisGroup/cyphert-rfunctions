module VarMap = Map.Make(String);;

module Logger = Log;;

module Make (A : sig 
                  val grad : unit -> float VarMap.t 
                  val eval : float VarMap.t -> float 
                  val stopping_rule : float -> bool
                  val update : float -> float -> float
                end) = struct 

  let initialize vars init_val = 
    let init_map = ref VarMap.empty in
    List.iter (
      fun var -> init_map := VarMap.add var init_val !init_map
    ) vars;
    init_map
  
  let search vars init_val ?(iter=50) () = 
    let init_map = initialize vars init_val in
    let rec aux init iter =
      let value = Logger.log_time "Eval" A.eval !init in
      Logger.log ~level:`debug ("current_value := " ^ (string_of_float value) ^ "\n");
      Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init "") ^ "\n\n");
      if (A.stopping_rule value) then (
        Some !init
      ) else if (iter = 0) then(
        None
      ) else (
        let grad = Logger.log_time "Grad" A.grad () in
        Logger.log ~level:`trace "Gradient";
        Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) grad "") ^ "\n\n");
        let update_func var var_value = A.update var_value (VarMap.find var grad) in
        init := VarMap.mapi update_func !init;
        aux init (iter - 1))
    in
    aux init_map iter
end

(*
module Sum(A: sig val search : Z3.Expr.expr -> float VarMap.t option -> int -> unit -> float VarMap.t option end)(B: sig val search : Z3.Expr.expr -> float VarMap.t option -> int -> unit -> float VarMap.t option end) = struct
  let use_left = ref true

  let search expr assign ?(iter = 50) () = 
    if !use_left then A.search expr assign iter ()
    else B.search expr assign iter ()
end*)