%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token PREF
%token INTERSECTION
%token EOL
%start main
%type <Path.pTerm> main
%%
main :
   expr EOL    { $1 }
;
expr :
  | PREF IDENT LANG { Pref ($2, $3) }
  | LANG UNION LANG { Union ($1, $3)}
  | LANG INTERSECTION LANG { Intersection ($1, $3)}

;
