module type AD = sig
  type t
  type base
  val const : string -> base
  val to_string : base -> string
  val add : base -> base -> base
  val mult : base -> base -> base
  val base_compare : base -> base -> int
  val make_add : t -> t -> t
  val make_mult : t -> t -> t
  val make_exp : t -> base -> t
  val make_div : t -> t -> t
  val make_var : string -> t
  val make_const : string -> t
  val build_complete : unit -> unit
  val eval : base Map.Make(String).t -> base
  val grad : unit -> base Map.Make(String).t
end


module type BoolEmb = sig
  include AD
  val make_or : t -> t -> t
  val make_and : t -> t -> t
  val make_not : t -> t
  val make_true : unit -> t
  val make_false : unit -> t
  val make_eq : t -> t -> t
  val stopping_rule : base -> bool
end

module type BuildSearch = sig
  type base
  val to_string : base -> string
  val from_string : string -> base
  val embed : Z3.context -> Z3.Expr.expr -> base Map.Make(String).t -> string list
  val eval : base Map.Make(String).t -> base
  val grad : unit -> base Map.Make(String).t
  val stopping_rule : base -> bool
  val update : base -> base -> base
end