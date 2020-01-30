module VarMap = Map.Make(String)

let remove_triv expr ctx = 
  if Z3.Boolean.is_and expr then (
    let args = Z3.Expr.get_args expr in
    let triv_assig = ref VarMap.empty in
    let new_form = List.fold_left (fun new_args ex ->
      if (Z3.Boolean.is_true ex || Z3.Expr.to_string ex = "true") then ex :: new_args
      else if (Z3.Boolean.is_false ex || Z3.Expr.to_string ex = "false") then ex :: new_args
      else if Z3.Expr.is_const ex then (
        let name = Z3.Expr.to_string ex in
        triv_assig := VarMap.update name (function | None -> Some 1. | Some 1. -> Some 1. | _ -> failwith "contradicting assignment") !triv_assig;
        new_args)
      else if Z3.Boolean.is_not ex then (
        let child = List.nth (Z3.Expr.get_args ex) 0 in
        if (Z3.Boolean.is_true child || Z3.Expr.to_string child = "true") then ex :: new_args
        else if (Z3.Boolean.is_false child || Z3.Expr.to_string child = "false") then ex :: new_args
        else if Z3.Expr.is_const child then (
          let name = Z3.Expr.to_string child in
          triv_assig := VarMap.update name (function | None -> Some 0. | Some 0. -> Some 0. | _ -> failwith "contradicting assignment") !triv_assig;
          new_args
        ) else (
          ex :: new_args
        ))
      else ex :: new_args
      ) [] args in
    if List.length new_form = 0 then (Z3.Boolean.mk_true ctx, !triv_assig)
    else if List.length new_form = 1 then (List.nth new_form 0, !triv_assig)
    else (Z3.Boolean.mk_and ctx new_form, !triv_assig)
  )
  else (expr, VarMap.empty)