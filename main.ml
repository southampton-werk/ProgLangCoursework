open Path

let _ =
  try
    let lexbuf = Lexing.from_channel (open_in Sys.argv.(1))
    in
       let result = Sdlparser.main Sdllexer.main lexbuf 
       and read = read_line()
       in
         prettyPrint result read ; print_newline() ; flush stdout 
  with Parsing.Parse_error -> print_string "There was a problem parsing the SDL program. Please check your syntax. \n" ; flush stdout
