%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token <int> SIZE
%token <string> KLEENE
%token SEP
%token JOIN
%token LEFTCURLY
%token IN
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
  | set { Set($1) }
  | set IN expr { In ($1, $3 )}
  | set NEWEXPR expr { Newexpr($1, $3 ) }
;

set :
  | PREF word LANG { Pref ($2, $3) }
  | LANG UNION LANG { Union ($1, $3)}
  | LANG INTERSECTION LANG { Intersection ($1, $3)}
  | LANG JOIN language { Join ($1, $3 )}
;

word :
  | IDENT { Ident ($1) }
;
language :
  | KLEENE  { Kleen ($1) }
  | SIZE OVER LEFTCURLY inLanguage RIGHTCURLY { LanguageOver ($1, $4) }
;
inLanguage :
  | word { Singleton($1) }
  | inLanguage SEP word { Multiple ($1,$3) }
;
;;
