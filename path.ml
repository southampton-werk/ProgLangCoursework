(* Data type of terms *)
type pTerm = Pred of string  ;;

let rec prettyPrint pTerm input = match pTerm with 
  Pred (n) -> print_string n ; print_string input
;; 
