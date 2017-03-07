{
open Sdlparser
exception Eof

  let lang_of_string s = int_of_string (String.sub s 1 1) ;;


}
rule main = parse
    [' ' '\t' ]  { main lexbuf }
  | ['\n'] { EOL }
  | "Pred"   { PRED }
  | ['a'-'z']+ as lxm { IDENT(lxm) }
  | "Union"  { UNION }
  | 'L'['0'-'9']+ as lxm { LANG(lang_of_string lxm) }
  | eof  { raise Eof }
