{
open Sdlparser
exception Eof

let blint_of_string s = int_of_string (String.sub s 1 1) ;;

}
rule main = parse
    [' ' '\t' ]  { main lexbuf }
  | ['\n'] { EOL }
  | "Pred"   { PRED }
  | ['a'-'z']+ as lxm { IDENT(lxm) }
  | ['0'-'9']+ as lxm { INT(int_of_string lxm) }
  | '-'['1' '2' '3'] as lxm { BLINT( blint_of_string lxm ) }
  | "bl" { BLOCKED }
  | 'r' { RIGHT }
  | 'l' { LEFT }
  | 'u' { UP }
  | 'd' { DOWN }
  | ':' { SEQ }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | eof  { raise Eof }
