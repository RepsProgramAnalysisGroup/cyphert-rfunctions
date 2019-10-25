module VarMap = Map.Make(String);;

module Logger = Log;;

module Make (A : sig val grad : unit -> float VarMap.t val eval : float VarMap.t -> float end) = struct 
  let init_map variables =
    let res = ref VarMap.empty in
    List.iter (fun var -> res := VarMap.add var 0. !res) variables;
    res
    ;;
  
  
  let grad_search initial iterations =
    let rec aux init iter =
      let value = Logger.log_time "Eval" A.eval !init in
      Logger.log ~level:`debug ("current_value := " ^ (string_of_float value) ^ "\n");
      (*Logger.log ~level:`debug ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init "") ^ "\n\n");*)
      if (value > 0.) then (
        Some !init
      ) else if (iter = 0) then(
        None
      ) else (
        let grad = Logger.log_time "Grad" A.grad () in
        (*Logger.log ~level:`debug "Gradient";
        Logger.log ~level:`debug ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) grad "") ^ "\n\n");*)
        let update var x =
          if x < 0. && (VarMap.find var !init) > 0. then
            init := VarMap.update var (fun x -> Some 0.) !init
          else if x > 0. && (VarMap.find var !init) < 1. then
            init := VarMap.update var (fun x -> Some 1.) !init
          else ()
        in
        VarMap.iter update grad;
        aux init (iter - 1))
      in
      aux initial iterations
    ;;
  
  let search init_opt vars ?(iter=50) () = 
    match init_opt with
    | None -> grad_search (init_map vars) iter
    | Some x -> grad_search x iter
    ;;
  
end
