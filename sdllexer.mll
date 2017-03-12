{
open Sdlparser
exception Eof

  let second_of_string s = int_of_string (String.sub s 1 ((String.length s) - 1));;


}
rule main = parse
    [' ' '\t' ]  { main lexbuf }
  | ['\n'] { EOL }
  | "Pref"   { PREF }
  | ['a'-'z']+ as lxm { IDENT(lxm) }
  | "Union"  { UNION }
  | "Intersection" { INTERSECTION }
  | "Join" { JOIN }
  | "Over" { OVER }
  | ',' { SEP }
  | '{' { LEFTCURLY }
  | '{' { RIGHTCURLY }
  | ';' { NEWEXPR }
  | ['a'-'z']+'*' as lxm { KLEENE(String.sub lxm 0 ((String.length lxm) - 1)) }
  | 'S'['0'-'9']+ as lxm { SIZE(second_of_string lxm) }
  | 'L'['0'-'9']+ as lxm { LANG(second_of_string lxm) }
  | eof  { raise Eof }
