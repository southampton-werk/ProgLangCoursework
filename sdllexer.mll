{
open Sdlparser
exception Eof
}
rule main = parse
      [' ' '\t' '\n']     { main lexbuf }     (* skip blanks *)
    | "Pred"   { PRED }
    | ['\n'] { EOL }
    | ['a'-'z']+ as lxm { IDENT(lxm) }
    | eof      { raise Eof }
