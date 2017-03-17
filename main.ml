open Path
let rec read_stdin acc  =
  try
    let line = "\n" ^ (input_line stdin) in
      read_stdin (acc ^ line)
  with
    |End_of_file -> acc
;;


let _ =
  try
    let lexbuf = Lexing.from_channel (open_in Sys.argv.(1))
    in
       let result = Sdlparser.main Sdllexer.main lexbuf
       and read = read_stdin "" in
        let lastLine = (Str.search_backward (Str.regexp "\n") read ((String.length read)-1))  in
          let k = Str.string_after read (lastLine + 1 )
          and input = Str.string_before read lastLine in
          prettyPrint result input (int_of_string k); print_newline() ; flush stdout
  with Parsing.Parse_error -> print_string "There was a problem parsing the SDL program. Please check your syntax. \n" ; flush stdout
