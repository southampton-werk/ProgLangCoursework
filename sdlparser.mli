type token =
  | IDENT of (string)
  | LANG of (int)
  | UNION
  | SIZE of (int)
  | KLEENE of (string)
  | SEP
  | JOIN
  | LEFTCURLY
  | IN
  | RIGHTCURLY
  | PREF
  | OVER
  | NEWEXPR
  | INTERSECTION
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Path.pTerm
