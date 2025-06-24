let space = [' ' '\r' '\t']+

let digit = ['0'-'9']

let variable = ['a'-'z' 'A'-'Z']

rule token = 
    parse
    | space { token lexbuf }
    | '\n' { Parser.EOF }
    | '+' { Parser.PLUS }
    | ':' { Parser.DEF }
    | variable+ { Parser.VAR (Lexing.lexeme lexbuf) }
    | digit+ { Parser.INT (int_of_string (Lexing.lexeme lexbuf)) }
    | eof { Parser.EOF }