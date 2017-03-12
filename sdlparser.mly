%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token <int> SIZE
%token <string> KLEENE
%token JOIN
%token LEFTCURLY
%token RIGHTCURLY
%token PREF
%token OVER
%token NEWEXPR
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
  | expr NEWEXPR expr { Newexpr($1, $3 ) }
  | LANG JOIN language { Join ($1, $3 )}
;
word :
  | IDENT { Ident ($1) }
;
language :
  | KLEENE  { Kleen ($1) }
  | LEFTCURLY IDENT RIGHTCURLY { Language ($2) }
;;
