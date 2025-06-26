type exp =
  | Int of int
  | Variable of string
  | Add of exp * exp
  | Definition of string * exp

  (*
type command =
  | Expression of exp
  | Definition of string * exp
  *)