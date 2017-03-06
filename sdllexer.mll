{
open Sdlparser
exception Eof


}
rule main = parse
    [' ' '\t' ]  { main lexbuf }
  | ['\n'] { EOL }
  | "Pred"   { PRED }
  | ['a'-'z']+ as lxm { IDENT(lxm) }
  | eof  { raise Eof }
