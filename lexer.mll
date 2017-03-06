{
open parser
exception Eof
}
rule lexer_main = parse
      [' ' '\t' '\n']     { lexer_main lexbuf }     (* skip blanks *)
    | "Pred"   { PRED }
    | ['a'-'z']+ as lxm { IDENT(lxm) }
    | eof      { EOF }
