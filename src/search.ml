module VarMap = Map.Make(String);;

module Logger = Log;;

let init_map variables =
  let res = ref VarMap.empty in
  List.iter (fun var -> res := VarMap.add var 0. !res) variables;
  res
  ;;


let map_contents key x y = 
  y ^ "\n" ^ key ^ " := " ^ (string_of_float x)

let rec grad_search formula init iter =
  let (value, grad) = formula !init in
  Logger.log ~level:`trace ("current_value := " ^ (string_of_float value));
  Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) !init "") ^ "\n\n");
  Logger.log ~level:`trace "Gradient";
  Logger.log ~level:`trace ((VarMap.fold (fun key x y -> y ^ "\n" ^ key ^ " := " ^ (string_of_float x)) grad "") ^ "\n\n");
  if (value > 0.) then (
    "sat"
  ) else if (iter = 0) then(
    "unknown"
  ) else (
    let update var x =
      if x < 0. && (VarMap.find var !init) > 0. then
        init := VarMap.update var (fun x -> Some 0.) !init
      else if x > 0. && (VarMap.find var !init) < 1. then
        init := VarMap.update var (fun x -> Some 1.) !init
      else ()
    in
    VarMap.iter update grad;
    grad_search formula init (iter - 1))
  ;;

let search form init_opt vars ?(iter=50) () = 
  match init_opt with
  | None -> grad_search form (init_map vars) iter
  | Some x -> grad_search form x iter
  ;;
