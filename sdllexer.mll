{
open Sdlparser
exception Eof

  let second_of_string s = int_of_string (String.sub s 1 ((String.length s) - 1));;
  let lang_of_string s = (second_of_string s) - 1



}
rule main = parse
    [' ' '\t' ]  { main lexbuf }
  | ['\n'] { EOL }
  | "Prefix"   { PREF }
  | "Union"  { UNION }
  | "Intersection" { INTERSECTION }
  | "Join" { JOIN }
  | "Over" { OVER }
  | "In" { IN }
  | "Loop" { LOOP }
  | "Subset" { SUBSET }
  | "If" { IF }
  | "Then" { THEN}
  | "Else" { ELSE }
  | "Cardinality" { CARDINALITY }
  | '<' { LESSTHAN }
  | '>' { MORETHAN }
  | ',' { SEP }
  | '(' { LEFTCOMMA }
  | ')' { RIGHTCOMMA }
  | '{' { LEFTCURLY }
  | '}' { RIGHTCURLY }
  | ';' { NEWEXPR }
  | ['0'-'9']+ as lxm { INT(int_of_string lxm) }
  | ['a'-'z']+|':' as lxm { IDENT(lxm) }
  | ['a'-'z']+'*' as lxm { KLEENE(String.sub lxm 0 ((String.length lxm) - 1)) }
  | 'S'['0'-'9']+ as lxm { SIZE(second_of_string lxm) }
  | 'L'['0'-'9']+ as lxm { LANG(lang_of_string lxm) }
  | "//"_*"//" {COMMENT}
  | eof  { raise Eof }
