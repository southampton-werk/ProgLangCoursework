(* Data type of terms *)
type pTerm = Pred of string  ;;

let rec prettyPrint pTerm = match pTerm with 
  Pred (n) -> print_string "(Pred " ; print_string n ; print_string ")" 
;; 
