module type AD = sig
  type t
  val make_add : t -> t -> t
  val make_mult : t -> t -> t
  val make_exp : t -> float -> t
  val make_div : t -> t -> t
  val make_var : string -> t
  val make_const : float -> t
  val build_complete : unit -> unit
  val eval : float Map.Make(String).t -> float
  val grad : unit -> float Map.Make(String).t
end


module type BoolEmb = sig
  include AD
  val make_or : t -> t -> t
  val make_and : t -> t -> t
  val make_not : t -> t
  val make_true : unit -> t
  val make_false : unit -> t
  val make_eq : t -> t -> t
  val stopping_rule : float -> bool
end

module type BuildSearch = sig
  val embed : Z3.context -> Z3.Expr.expr -> float Map.Make(String).t -> string list
  val eval : float Map.Make(String).t -> float
  val grad : unit -> float Map.Make(String).t
  val stopping_rule : float -> bool
  val update : float -> float -> float
end