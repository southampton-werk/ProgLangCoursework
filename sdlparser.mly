%{
  open Path
%}
%token <string> IDENT
%token PRED
%token PLUS
%token EOL
%start main
%type <Path.pTerm> main
%%
main :
   expr EOL    { $1 }
;

expr: PRED IDENT { Pred ($2) }
;
