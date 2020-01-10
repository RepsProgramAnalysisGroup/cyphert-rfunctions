type level = [`trace | `debug | `always]

let level_leq x y = 
  let to_int = function
    | `trace -> 0
    | `debug -> 1
    | `always -> 2
  in
  (to_int x) <= (to_int y)

let my_level = ref `always
let log_times = ref false
let chan = ref (stdout)

module StrMap = Map.Make(String)
let label_map = ref StrMap.empty

let set_chan ch = 
  chan := ch

let set_level lev = 
  match lev with
  | "trace" -> my_level := `trace
  | "debug" -> my_level := `debug
  | "always" -> my_level := `always
  | _ -> failwith "Unrecognized Level"

let log ?(level=`always) str = 
  if level_leq !my_level level then
    Printf.fprintf !chan "%s" str
  else
    Printf.ifprintf !chan "%s" str;
  Printf.fprintf !chan "%!"
      
let log_time label f arg = 
  let start_time = Unix.gettimeofday () in
  let res = f arg in
  let tim = Unix.gettimeofday () -. start_time in
  let _ = 
    if !log_times then Printf.fprintf !chan "%s: %f s\n" label tim
    else Printf.ifprintf !chan "%s: %f s\n" label tim
  in
  res

let log_time_cum label f arg = 
  let start_time = Unix.gettimeofday () in
  let res = f arg in
  let tim = Unix.gettimeofday () -. start_time in
  label_map := StrMap.update label (function | None -> Some tim | Some y -> Some (tim +. y)) !label_map;
  let _ = 
    if !log_times then Printf.fprintf !chan "%s: %f s\n" label (StrMap.find label !label_map) 
    else Printf.ifprintf !chan "%s: %f s\n" label tim
  in
  res
