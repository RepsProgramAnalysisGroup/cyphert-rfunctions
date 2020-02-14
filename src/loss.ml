module VarMap = Map.Make(String);;

module Logger = Log

module Make (A : Sigs.AD) : Sigs.BoolEmb = struct
  
  include A

  let make_or left right =
    A.make_mult left right
    
  let make_and left right =
    A.make_add left right

  let make_not base =
    let base_plus_1 = A.make_add base (A.make_const 1.) in
    let base_plus_2 = A.make_add base (A.make_const 2.) in
    let b1_div_b2 = A.make_div base_plus_1 base_plus_2 in
    let neg_div = A.make_mult (A.make_const (-1.)) b1_div_b2 in
    let base_minus_div = A.make_add base neg_div in
    let term_sq = A.make_exp base_minus_div (2.) in
    let term_sqrt = A.make_exp term_sq (0.5) in
    let neg_base_minus_div = A.make_mult base_minus_div (A.make_const (-1.)) in
    A.make_add term_sqrt neg_base_minus_div
  
  let make_true () =
    A.make_const (0.)

  let make_false () =
    A.make_const (1.)

  let make_eq left right =
    let both_true = make_and left right in
    let not_left = make_not left in
    let not_right = make_not right in
    let both_false = make_and not_left not_right in
    make_or both_true both_false

  let stopping_rule value = 
    if value = 0. then true
    else false
  
end
