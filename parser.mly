%{
  open ast
%}

%token PREFIX
%token <string> STRING
%start program
%type <string> program
%%
program :
   expr EOL    { $1 }
;
expr :
  | PREFIX STRING { prefix ($2) }
;
