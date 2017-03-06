{
open parser
exception Eof
}
rule main = parse
    [' ' '\t' ]  { main lexbuf }
  | ['\n'] { EOL }
  | "prefix" { PREFIX }
  | eof  { raise Eof }
