%{
  open ast
%}
%token <string> IDENT
%token PRED
%token PLUS
%token EOF
%start main
%type <ast.astTerm> main
%%
main :
   expr EOL    { $1 }
;

expr: PRED IDENT                      { Pred $2 }
;
