%{
  open ast
%}
%token <string> IDENT
%token PRED
%token PLUS
%token EOF
%start parser_main             /* the entry point */
%type <Toy.toyTerm> parser_main
%type <Toy.toyType> type_spec
%%
program :
   expr EOL    { $1 }
;

expr: PRED IDENT                      { Pred $2 }
;
