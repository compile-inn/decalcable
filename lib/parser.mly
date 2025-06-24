%token EOF
%token <int> INT
%token PLUS
%token <string> VAR
%token DEF

%start<Ast.exp> main

%left PLUS

%{ open Ast %}

%%

(* Grammar *)

main: 
| expr EOF { $1 }
| x=VAR DEF e=expr EOF { Definition (x, e) }

expr:
| n=INT { Int n }
| x=VAR { Variable x }
| e1=expr PLUS e2=expr { Add (e1, e2) }

%%