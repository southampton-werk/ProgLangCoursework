type token =
  | IDENT of (string)
  | LANG of (int)
  | UNION
  | SIZE of (int)
  | KLEENE of (string)
  | JOIN
  | PREF
  | INTERSECTION
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Path.pTerm
