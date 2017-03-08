%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token <int> SIZE
%token <string> KLEENE
%token JOIN
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
  | PREF word LANG { Pref ($2, $3) }
  | LANG UNION LANG { Union ($1, $3)}
  | LANG INTERSECTION LANG { Intersection ($1, $3)}
  | LANG JOIN IDENT { Join ($1, $3 ) }
;
word :
  | IDENT { Ident ($1) }
  | KLEENE  { Kleen ($1) }
;;
