module Logger = Log

module ExprPair = Map.Make(struct 
  type t = Z3.Expr.expr * Z3.Expr.expr 
  let compare = compare
end )

let remove_select expr =
  let ctx = Z3.mk_context [] in
  let new_sort sort =
    match Z3.Sort.get_sort_kind sort with 
    | Z3enums.BV_SORT ->
      let size = Z3.BitVector.get_size sort in
      Z3.BitVector.mk_sort ctx size
    | Z3enums.BOOL_SORT ->
      Z3.Boolean.mk_sort ctx
    | _ ->
      failwith ("Unimplemented: " ^ (Z3.Sort.to_string sort))
  in
  let bv_to_int bv = 
    let bv_str = Z3.Expr.to_string bv in
    let new_str = "0" ^ (String.sub bv_str 1 ((String.length bv_str) - 1)) in
    int_of_string new_str
  in
  let arrayInd = ref ExprPair.empty in
  let arrayNonConstInd = ref [] in
  let counter = ref 0 in
  let rec aux ex = 
    (*if Z3.Expr.is_const ex || Z3.Expr.is_numeral ex || Z3.Z3Array.is_array ex || Z3.BitVector.is_bv_numeral ex then
      Z3.Expr.translate ex ctx*)
    if Z3.Z3Array.is_array ex then ( (**)
      (*Logger.log "Array\n" ~level:`trace;*)
      let domain = Z3.Z3Array.get_domain (Z3.Expr.get_sort ex) in
      let range = Z3.Z3Array.get_range (Z3.Expr.get_sort ex) in
      Z3.Z3Array.mk_const_s ctx (Z3.Expr.to_string ex) (new_sort domain) (new_sort range))
    else if Z3.Expr.is_const ex then ( (* this might have to go first*)
      let sort = Z3.Expr.get_sort ex in
      (*Logger.log "Const\n" ~level:`trace;*)
      Z3.Expr.mk_const_s ctx (Z3.Expr.to_string ex) (new_sort sort)) (**)
    else if Z3.Z3Array.is_select ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "Select\n" ~level:`trace;*)
      let arr = List.nth args 0 in
      let index = List.nth args 1 in
      if ExprPair.mem (arr, index) !arrayInd then
          ExprPair.find (arr, index) !arrayInd
      else ( 
        let range = new_sort (Z3.Z3Array.get_range (Z3.Expr.get_sort arr)) in
        let size = Z3.BitVector.get_size range in
        if (Z3.BitVector.is_bv_numeral index) || (Z3.Expr.is_numeral index && Z3.BitVector.is_bv index) then (
          let index_int = bv_to_int index in
          let new_const = Z3.BitVector.mk_const_s ctx ((Z3.Expr.to_string arr)^ "con" ^ string_of_int index_int) size in
          arrayInd := ExprPair.add (arr, index) new_const !arrayInd;
          new_const
          )
        else(
          let new_const = Z3.BitVector.mk_const_s ctx ((Z3.Expr.to_string arr) ^ string_of_int !counter) size in
          counter := !counter + 1;
          arrayInd := ExprPair.add (arr, index) new_const !arrayInd;
          arrayNonConstInd := (arr, index) :: !arrayNonConstInd;
          new_const )))
    else if Z3.Boolean.is_and ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "And\n" ~level:`trace;*)
      Z3.Boolean.mk_and ctx args)
    else if Z3.Boolean.is_or ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "Or\n" ~level:`trace;*)
      Z3.Boolean.mk_or ctx args)
    else if Z3.Boolean.is_not ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "Not\n" ~level:`trace;*)
      Z3.Boolean.mk_not ctx (List.nth args 0))
    else if Z3.Boolean.is_true ex then (
      (*Logger.log "true\n" ~level:`trace;*)
      Z3.Boolean.mk_true ctx)
    else if Z3.Boolean.is_false ex then (
      (*Logger.log "false\n" ~level:`trace;*)
      Z3.Boolean.mk_false ctx)
    else if Z3.Boolean.is_ite ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "ite\n" ~level:`trace;*)
      Z3.Boolean.mk_ite ctx (List.nth args 0) (List.nth args 1) (List.nth args 2))
    else if Z3.Boolean.is_iff ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "iff\n" ~level:`trace;*)
      Z3.Boolean.mk_iff ctx (List.nth args 0) (List.nth args 1))
    else if Z3.Boolean.is_implies ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "Implies\n" ~level:`trace;*)
      Z3.Boolean.mk_implies ctx (List.nth args 0) (List.nth args 1))
    else if Z3.Boolean.is_xor ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "xor\n" ~level:`trace;*)
      Z3.Boolean.mk_xor ctx (List.nth args 0) (List.nth args 1))
    else if Z3.Boolean.is_eq ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "eq\n" ~level:`trace;*)
      Z3.Boolean.mk_eq ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_not ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "bv_not\n" ~level:`trace;*)
      Z3.BitVector.mk_not ctx (List.nth args 0))
    else if Z3.BitVector.is_bv_and ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "bv_and\n" ~level:`trace;*)
      let first_ex = Z3.BitVector.mk_and ctx (List.nth args 0) (List.nth args 1) in
      List.fold_left (fun a b -> Z3.BitVector.mk_and ctx a b) first_ex (List.tl (List.tl args)))
    else if Z3.BitVector.is_bv_or ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "bv_or\n" ~level:`trace;*)
      let first_ex = Z3.BitVector.mk_or ctx (List.nth args 0) (List.nth args 1) in
      List.fold_left (fun a b -> Z3.BitVector.mk_or ctx a b) first_ex (List.tl (List.tl args)))
    else if Z3.BitVector.is_bv_xor ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "bv_xor\n" ~level:`trace;*)
      let first_ex = Z3.BitVector.mk_xor ctx (List.nth args 0) (List.nth args 1) in
      List.fold_left (fun a b -> Z3.BitVector.mk_xor ctx a b) first_ex (List.tl (List.tl args)))
    else if Z3.BitVector.is_bv_mul ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "bv_mul\n" ~level:`trace;*)
      let first_ex = Z3.BitVector.mk_mul ctx (List.nth args 0) (List.nth args 1) in
      List.fold_left (fun a b -> Z3.BitVector.mk_mul ctx a b) first_ex (List.tl (List.tl args)))
    else if Z3.BitVector.is_bv_add ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "bv_add\n" ~level:`trace;*)
      let first_ex = Z3.BitVector.mk_add ctx (List.nth args 0) (List.nth args 1) in
      List.fold_left (fun a b -> Z3.BitVector.mk_add ctx a b) first_ex (List.tl (List.tl args)))
    else if Z3.BitVector.is_bv_concat ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "concat\n" ~level:`trace;*)
      let first_concat = Z3.BitVector.mk_concat ctx (List.nth args 0) (List.nth args 1) in
      List.fold_left (fun a b -> Z3.BitVector.mk_concat ctx a b) first_concat (List.tl (List.tl args)))
    else if Z3.BitVector.is_bv_extract ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "extract\n" ~level:`trace;*)
      let params = Z3.FuncDecl.get_parameters (Z3.Expr.get_func_decl ex) in
      Z3.BitVector.mk_extract ctx (Z3.FuncDecl.Parameter.get_int (List.nth params 0)) (Z3.FuncDecl.Parameter.get_int (List.nth params 1)) (List.nth args 0))
    else if Z3.BitVector.is_bv_numeral ex then ( 
      (*Logger.log "bv numeral\n" ~level:`trace;*)
      let size = Z3.BitVector.get_size (Z3.Expr.get_sort ex) in
      Z3.BitVector.mk_numeral ctx (Z3.Expr.to_string ex) size)
    else if Z3.Expr.is_numeral ex && Z3.BitVector.is_bv ex then (
      (*Logger.log "numeral\n" ~level:`trace;*)
      let size = Z3.BitVector.get_size (Z3.Expr.get_sort ex) in
      let str = Z3.Expr.to_string ex in
      let int_val = int_of_string ("0" ^ (String.sub str 1 ((String.length str)-1))) in
      Z3.BitVector.mk_numeral ctx (string_of_int int_val) size)
    else if Z3.Z3Array.is_store ex then (
      failwith "This function doesn't remove stores")
    else if Z3.BitVector.is_bv_zeroextension ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "Zero extend\n" ~level:`trace;*)
      let params = Z3.FuncDecl.get_parameters (Z3.Expr.get_func_decl ex) in
      Z3.BitVector.mk_zero_ext ctx (Z3.FuncDecl.Parameter.get_int (List.nth params 0)) (List.nth args 0))
    else if Z3.BitVector.is_bv_shiftrightlogical ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "LSHR\n" ~level:`trace;*)
      Z3.BitVector.mk_lshr ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_shiftleft ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "SHL\n" ~level:`trace;*)
      Z3.BitVector.mk_shl ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_shiftrightarithmetic ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      (*Logger.log "ASHR\n" ~level:`trace;*)
      Z3.BitVector.mk_ashr ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_ule ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_ule ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_sle ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_sle ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_uge ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_uge ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_sge ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_sge ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_ult ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_ult ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_slt ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_slt ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_ugt ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_ugt ctx (List.nth args 0) (List.nth args 1))
    else if Z3.BitVector.is_bv_sgt ex then (
      let args = List.map aux (Z3.Expr.get_args ex) in
      Z3.BitVector.mk_sgt ctx (List.nth args 0) (List.nth args 1))
    else (
      if Z3.BitVector.is_bv_comp ex then (Logger.log "Comp\n")
      else if Z3.BitVector.is_bv_rotateleft ex then (Logger.log "rotateLeft\n")
      else if Z3.BitVector.is_bv_rotateright ex then (Logger.log "rotateRight\n")
      else if Z3.BitVector.is_bv_sub ex then (Logger.log "Sub\n")
      else if Z3.BitVector.is_bv_nand ex then (Logger.log "Nand\n")
      else if Z3.BitVector.is_bv_nor ex then (Logger.log "Nor\n")
      else if Z3.BitVector.is_bv_xnor ex then (Logger.log "Xnor\n")
      else if Z3.BitVector.is_bv_signextension ex then (Logger.log "Signextension\n")
      else if Z3.BitVector.is_bv_repeat ex then (Logger.log "Reapeat\n");
      failwith ((Z3.Sort.to_string ((Z3.Expr.get_sort ex)))))
  in
  let no_array = aux expr in
  let generate_constraint (arr, index) =
    let const = ExprPair.find (arr,index) !arrayInd in
    let make_constraint (arr1, ind1) const1 exprlst = 
      if (Z3.Expr.equal ind1 index) || not (Z3.Expr.equal arr arr1) then
        exprlst
      else (
        let head = Z3.Boolean.mk_eq ctx ind1 index in
        let tail = Z3.Boolean.mk_eq ctx const const1 in
        let implies = Z3.Boolean.mk_implies ctx head tail in
        implies :: exprlst
      )
    in
    ExprPair.fold make_constraint !arrayInd []
  in
  let constr = List.concat (List.map generate_constraint !arrayNonConstInd) in
  (*let constr = [] in*)
  (Z3.Boolean.mk_and ctx (no_array :: constr), ctx)
  (*(Z3.Boolean.mk_and ctx (constr), ctx)*)
;;

 
let bv2bool ctx expr = 
  let sim = Z3.Tactic.mk_tactic ctx "simplify" in
  let bit = Z3.Tactic.mk_tactic ctx "bit-blast" in
  let prop = Z3.Tactic.mk_tactic ctx "propagate-values" in
  let sim_then_bit = Z3.Tactic.and_then ctx sim bit [] in
  let sim_then_bit_then_prop = Z3.Tactic.and_then ctx sim_then_bit prop [] in
  (*let sim_then_bit_then_nnf_then_prop = Z3.Tactic.and_then ctx sim_then_bit_then_nnf prop [] in*)
  (*let sim_then_bit_then_nnf_then_prop = Z3.Tactic.and_then new_ctx sim_then_bit prop [] in*)
  let new_g = Z3.Goal.mk_goal ctx false false false in
  Z3.Goal.add new_g [expr];
  let bit_blasted = Z3.Goal.as_expr (Z3.Tactic.ApplyResult.get_subgoal (Z3.Tactic.apply sim_then_bit_then_prop new_g None) 0) in
  Logger.log ("Bit blasted: " ^ (Z3.Expr.to_string bit_blasted) ^ "\n") ~level:`trace;
  (ctx, bit_blasted)

let aufbv2bool ctx expr = 
  (*Logger.log ("Original query: " ^ (Z3.Expr.to_string expr) ^ "\n") ~level:`trace;*)
  let g = Z3.Goal.mk_goal ctx false false false in
  Z3.Goal.add g [expr];
  let params = Z3.Params.mk_params ctx in
  Z3.Params.add_bool params (Z3.Symbol.mk_string ctx "expand-select-store") true;
  let no_store_tac= Z3.Tactic.using_params ctx (Z3.Tactic.mk_tactic ctx "simplify") params in
  let app_res = Z3.Tactic.apply no_store_tac g None in
  let no_store = Z3.Goal.as_expr (Z3.Tactic.ApplyResult.get_subgoal app_res 0) in
  (*Logger.log ("No store: " ^ (Z3.Expr.to_string no_store) ^ "\n") ~level:`trace;*)
  let (no_array, new_ctx) = remove_select no_store in
  (*Logger.log ("No array: " ^ (Z3.Expr.to_string no_array) ^ "\n") ~level:`trace;*)
  let (_, blasted) = bv2bool new_ctx no_array in
  (new_ctx, blasted)
  ;;

