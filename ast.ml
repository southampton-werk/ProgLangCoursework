(* Data type of terms *)
type astTerm = Pred of string ;;

let rec prettyPrint astTerm = match astTerm with
    Blocked (n) ->  print_string "(Pred " ; print_string n ; print_string ")"
;;
