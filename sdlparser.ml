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

open Parsing;;
let _ = parse_error;;
# 2 "sdlparser.mly"
  open Path
# 17 "sdlparser.ml"
let yytransl_const = [|
  259 (* UNION *);
  262 (* JOIN *);
  263 (* PREF *);
  264 (* INTERSECTION *);
  265 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* IDENT *);
  258 (* LANG *);
  260 (* SIZE *);
  261 (* KLEENE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\003\000\003\000\003\000\003\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\008\000\000\000\000\000\000\000\
\000\000\006\000\007\000\000\000\001\000\003\000\005\000\004\000\
\002\000"

let yydgoto = "\002\000\
\005\000\006\000\012\000"

let yysindex = "\001\000\
\255\254\000\000\253\254\003\255\000\000\254\254\007\255\003\255\
\008\255\000\000\000\000\009\255\000\000\000\000\000\000\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\000\000\004\000"

let yytablesize = 12
let yytable = "\007\000\
\003\000\001\000\008\000\010\000\009\000\004\000\013\000\011\000\
\014\000\016\000\017\000\015\000"

let yycheck = "\003\001\
\002\001\001\000\006\001\001\001\008\001\007\001\009\001\005\001\
\002\001\002\001\002\001\008\000"

let yynames_const = "\
  UNION\000\
  JOIN\000\
  PREF\000\
  INTERSECTION\000\
  EOL\000\
  "

let yynames_block = "\
  IDENT\000\
  LANG\000\
  SIZE\000\
  KLEENE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 18 "sdlparser.mly"
               ( _1 )
# 91 "sdlparser.ml"
               : Path.pTerm))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'word) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 21 "sdlparser.mly"
                   ( Pref (_2, _3) )
# 99 "sdlparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 22 "sdlparser.mly"
                    ( Union (_1, _3))
# 107 "sdlparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 23 "sdlparser.mly"
                           ( Intersection (_1, _3))
# 115 "sdlparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'word) in
    Obj.repr(
# 24 "sdlparser.mly"
                   ( Join (_1, _3 ) )
# 123 "sdlparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 27 "sdlparser.mly"
          ( Ident (_1) )
# 130 "sdlparser.ml"
               : 'word))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 28 "sdlparser.mly"
            ( Kleen (_1) )
# 137 "sdlparser.ml"
               : 'word))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Path.pTerm)
