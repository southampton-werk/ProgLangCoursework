%{
  open Path
%}

%token <string> IDENT
%token <int> LANG
%token UNION
%token <int> SIZE
%token <string> KLEENE
%token COMMENT
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
%left COMMENT    /* lowest precedence */
%left PREF UNION INTERSECTION JOIN  /* lowest precedence */
%left IN       /* medium precedence */
%left NEWEXPR
%start main
%type <Path.pTerm> main
%%
main :
   |expr EOL    { $1 }
   |COMMENT EOL main { $3 }
;
expr :
  | set { Set($1) }
  | set IN expr { In ($1, $3 )}
  | set NEWEXPR expr { Newexpr($1, $3 ) }
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
