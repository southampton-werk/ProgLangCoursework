%{
  open Path
%}

%token <string> IDENT KLEENE
%token <int> LANG SIZE LOOPTIMES
%token UNION JOIN PREF INTERSECTION
%token OVER LEFTCURLY RIGHTCURLY
%token COMMENT
%token IN NEWEXPR LOOP
%token SEP
%token EOL
%left COMMENT    /* lowest precedence */
%left PREF UNION INTERSECTION JOIN  /* lowest precedence */
%left IN       /* medium precedence */
%left NEWEXPR
%left LOOP
%start main
%type <Path.pTerm> main
%%
main :
   |expr EOL    { $1 }
   |COMMENT EOL main { $3 }
;
expr :
  | set { Set($1) }
  | expr IN expr { In ($1, $3 )}
  | expr NEWEXPR expr { Newexpr($1, $3 ) }
  | LOOP LOOPTIMES expr { Loop ($2, $3) }
;

set :
  | PREF word LANG { Pref ($2, $3) }
  | UNION LANG LANG { Union ($2, $3)}
  | INTERSECTION LANG LANG { Intersection ($2, $3)}
  | JOIN LANG language { Join ($2, $3 )}
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
