%{
  open Path
%}

%token <string> IDENT
%token PRED
%token EOL
%start main
%type <Path.pTerm> main
%%
main :
   expr EOL    { $1 }
;
expr :
  | PRED IDENT { Pred ($2) }
;
