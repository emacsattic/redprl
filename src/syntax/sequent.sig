signature SEQUENT =
sig
  type prop
  type expr
  type sort
  type var

  type metactx (* metavariable context *)
  type hypctx (* hypothesis contexts *)

  type context

  val emptyContext : context
  val getHyps : context -> hypctx
  val getMetas : context -> metactx

  val updateHyps : (hypctx -> hypctx) -> context -> context
  val updateMetas : (metactx -> metactx) -> context -> context

  datatype concl =
      TRUE of prop * sort
    | TYPE of prop * sort
    | EQ_MEM of expr * expr * prop
    | MEM of expr * prop
    | EQ_SYN of expr * expr
    | SYN of expr

  datatype sequent =
      >> of context * concl

  datatype generic =
      |> of (var * sort) list * sequent

  val toString : generic -> string
end
