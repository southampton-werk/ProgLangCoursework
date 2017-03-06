open Path 

let _ = 
  try
    let lexbuf = Lexing.from_channel stdin 
    in  
       let result = Sdlparser.main Sdllexer.main lexbuf 
       in
         prettyPrint result "a" ; print_newline() ; flush stdout 
  with Parsing.Parse_error -> print_string "There was a problem parsing the SDL program. Please check your syntax. \n" ; flush stdout
