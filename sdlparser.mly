%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token PRED
%token EOL
%start main
%type <Path.pTerm> main
%%
main :
   expr EOL    { $1 }
;
expr :
  | PRED IDENT LANG { Pred ($2, $3) }
  | LANG UNION LANG { Union ($1, $3)}
;
