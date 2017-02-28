%{
  open Path
%}

%token <int> INT
%token <int> BLINT
%token RIGHT LEFT UP DOWN
%token LPAREN RPAREN
%token EOL
%token SEQ
%token BLOCKED
%token IF THEN ELSE
%left SEQ
%nonassoc IF THEN ELSE
%start main
%type <Path.pTerm> main
%%
main :
   expr EOL    { $1 }
;
expr :
  | LPAREN expr RPAREN { $2 }
  | expr SEQ expr { Seq ( $1 , $3 ) }
  | BLOCKED BLINT { Blocked ( $2 ) }
  | UP INT { Up ($2) }
  | DOWN INT { Down ($2) }
  | LEFT INT { Left ($2) }
  | RIGHT INT { Right ($2) }
  | IF expr THEN expr ELSE expr { IF ($2, $4, $6 ) }
;
