%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token <int> SIZE
%token KLEENE
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
  | PREF IDENT LANG { Pref ($2, $3) }
  | LANG UNION LANG { Union ($1, $3)}
  | LANG INTERSECTION LANG { Intersection ($1, $3)}
  | LANG JOIN word { Join ($1, $3 ) }
;
word :
  | IDENT { Ident($1) }
  | word KLEENE  { Kleen($1) }
;;
