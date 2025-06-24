type exp =
  | Int of int
  | Variable of string
  | Definition of string * exp
  | Add of exp * exp