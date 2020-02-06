module VarMap = Map.Make(String);;

module Logger = Log

module Make (A : Sigs.BoolEmb) : Sigs.BuildSearch = struct

  include A

  module IntTbl = Hashtbl.Make(struct type t = int let equal = (=) let hash = Hashtbl.hash end)

  let expr_tbl = IntTbl.create 1000

  let make_base var = 
    let variable = A.make_var var in
    let minus_one = A.make_const (- 1.) in
    let var_minus_one = A.make_add variable minus_one in
    A.make_exp var_minus_one 2.

  let make_base_not var = 
    let variable = A.make_var var in
    A.make_exp variable 2.

  let embed ex set_vals =
    let vars = ref [] in
    let rec aux expr =
      let expr_id = Z3.AST.get_id (Z3.Expr.ast_of_expr expr) in
      try
        IntTbl.find expr_tbl expr_id
      with Not_found ->
        if Z3.Boolean.is_true expr || Z3.Expr.to_string expr = "true" then (
          A.make_true ())
        else if Z3.Boolean.is_false expr || Z3.Expr.to_string expr = "false" then (
          A.make_false ())
        else if Z3.Expr.is_const expr then (
          let name = (Z3.Expr.to_string expr) in
          try
            let value = VarMap.find name set_vals in
            if value > 0.5 then A.make_true ()
            else A.make_false ()
          with Not_found ->
            if not (List.mem name !vars) then (vars := name :: !vars);
            make_base name)
        else if Z3.Boolean.is_or expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          let fold_fun left right =
            A.make_or left right
          in
          let rec collapse l = 
            if (List.length l = 2) then fold_fun (List.nth l 0) (List.nth l 1)
            else if (List.length l = 3) then fold_fun (fold_fun (List.nth l 0) (List.nth l 1)) (List.nth l 2)
            else if (List.length l = 1) then failwith "Don't think this should happen"
            else
              let pivot = (List.length l) / 2 in
              let left_list = ref [] in
              let right_list = ref [] in
              List.iteri (fun i x -> if (i < pivot) then left_list := x :: !left_list  else right_list := x :: !right_list) l;
              fold_fun (collapse !left_list) (collapse !right_list)
          in
          let res = collapse args in
          IntTbl.add expr_tbl expr_id res;
          res)
        else if Z3.Boolean.is_and expr then (
          (*let args = List.map aux (Z3.Expr.get_args expr) in
          Logger.log ~level:`trace (string_of_int (List.length args));
          (0, (Const (0.), [])))*)
          let args = List.map aux (Z3.Expr.get_args expr) in
          let fold_fun left right =
            A.make_and left right
          in
          let rec collapse l = 
            if (List.length l = 2) then fold_fun (List.nth l 0) (List.nth l 1)
            else if (List.length l = 3) then fold_fun (fold_fun (List.nth l 0) (List.nth l 1)) (List.nth l 2)
            else if (List.length l = 1) then failwith "Don't think this should happen"
            else
              let pivot = (List.length l) / 2 in
              let left_list = ref [] in
              let right_list = ref [] in
              List.iteri (fun i x -> if (i < pivot) then left_list := x :: !left_list  else right_list := x :: !right_list) l;
              fold_fun (collapse !left_list) (collapse !right_list)
          in
          let res = collapse args in
          IntTbl.add expr_tbl expr_id res;
          res)
        else if Z3.Boolean.is_not expr then (
          let child = List.nth (Z3.Expr.get_args expr) 0 in
          if (Z3.Boolean.is_true child || Z3.Expr.to_string child = "true") then ( (*Shouldn't need to check explicitly true or false*)
            A.make_false ())
          else if (Z3.Boolean.is_false child || Z3.Expr.to_string child = "false") then ( (*Shouldn't need to check explicitly true or false*)
            A.make_true ())
          else if (Z3.Expr.is_const child) then (
            let name = Z3.Expr.to_string child in
            if not (List.mem name !vars) then (vars := name :: !vars);
            make_base_not name)
          else (
            A.make_not (aux child)))
        else if Z3.Boolean.is_eq expr then (
          let args = List.map aux (Z3.Expr.get_args expr) in
          let res = A.make_eq (List.nth args 0) (List.nth args 1) in
          IntTbl.add expr_tbl expr_id res;
          res)
        else (
          failwith ("unknown Expr node: \n" ^ (Z3.Expr.to_string expr))
        )
    in
    let _ = aux ex in
    A.build_complete ();
    Logger.log "Build Complete\n" ~level:`trace;
    !vars
end