type environment = (string * int) list

let env = []
let value_to_string = function
   | n -> string_of_int n

let eval env =
  let rec eval = function
   | Ast.Int n -> n
   | Add (a, b) -> eval a + eval b
   | Variable x -> (try List.assoc x env with Not_found -> failwith "Unbound variable")
   | Definition (x, e) ->  let n = eval e in let result = ((x, n)::env) in List.assoc x result
in eval


let info = Cmdliner.Cmd.info "decalcable"

let eval_lb lb =
  try
    let expr = Parser.main Lexer.token lb in
    let v = eval env expr in
    Printf.printf "%s\n" (value_to_string v)
  with Parser.Error ->
    Printf.printf "parse error near character %d" lb.lex_curr_pos

let repl () =
  while true do
    Printf.printf "<decalque>> %!";
    let lb = Lexing.from_channel Stdlib.stdin in
    eval_lb lb
  done

let term =
  let open Cmdliner.Term.Syntax in
  let+ expr_opt =
    let open Cmdliner.Arg in
    value & opt (some string) None & info [ "e" ]
  in
  match expr_opt with
  | Some s -> eval_lb (Lexing.from_string s)
  | None -> repl ()

let cmd = Cmdliner.Cmd.v info term
let main () = Cmdliner.Cmd.eval cmd |> Stdlib.exit