type environment = (string * int) list ref

let (env : environment) = ref []
let value_to_string = function
   | n -> string_of_int n

let rec eval env = function
  | Ast.Int n -> n
  | Add (a, b) -> eval env a + eval env b
  | Variable x -> (try List.assoc x !env with Not_found -> failwith "Unbound variable")
  | Definition (x, e) -> let v = eval env e in 
                        env := (x, v)::!env; v

let eval_lb lb =
  try
    let expr = Parser.main Lexer.token lb in
    let v = eval env expr in
    Printf.printf "%s\n" (value_to_string v)
  with Parser.Error ->
    Printf.printf "parse error near character %d" lb.lex_curr_pos

let repl () =
  while true do
    Printf.printf "<decalcable>> %!";
    let lb = Lexing.from_channel Stdlib.stdin in
    eval_lb lb
  done