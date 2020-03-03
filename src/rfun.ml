module VarMap = Map.Make(String);;

module Logger = Log

module Make (A : Sigs.AD) : Sigs.BoolEmb = struct
  
  include A

  let make_or left right =
    let left_plus_right = A.make_add left right in
    let left_sq = A.make_exp left (A.const "2") in
    let right_sq = A.make_exp right (A.const "2") in
    let left_sq_plus_right_sq = A.make_add left_sq right_sq in
    let square_root = A.make_exp left_sq_plus_right_sq (A.const "0.5") in
    let left_term = A.make_add left_plus_right square_root in
    A.make_mult left_term left_sq_plus_right_sq
    
  let make_and left right =
    let left_plus_right = A.make_add left right in
    let left_sq = A.make_exp left (A.const "2") in
    let right_sq = A.make_exp right (A.const "2") in
    let left_sq_plus_right_sq = A.make_add left_sq right_sq in
    let square_root = A.make_exp left_sq_plus_right_sq (A.const "0.5") in
    let minus_1 = A.make_const "-1" in
    let neg_sqrt = A.make_mult square_root minus_1 in
    let left_term = A.make_add left_plus_right neg_sqrt in
    A.make_mult left_term left_sq_plus_right_sq

  let make_not base =
    let minus_1 = A.make_const "-1" in
    A.make_mult minus_1 base
  
  let make_true () =
    A.make_const "1"

  let make_false () =
    A.make_const "-1"

  let make_eq left right =
    let both_true = make_and left right in
    let not_left = make_not left in
    let not_right = make_not right in
    let both_false = make_and not_left not_right in
    make_or both_true both_false

  let stopping_rule value = 
    if (A.base_compare value (A.const "0")) >= 0 then true
    else false

end
