(* Data type of terms *)
type pTerm = Blocked of int | Up of int | Down of int | Right of int | Left of int | Seq of pTerm * pTerm | IF of pTerm * pTerm * pTerm | Pred of string  ;;

let rec prettyPrint pTerm = match pTerm with 
    Blocked (n) ->  print_string "(Blocked " ; print_int n ; print_string ")" 
  | Pred (n) -> print_string "(Pred " ; print_string n ; print_string ")" 
  | Up (n) -> print_string "(Up " ; print_int n ; print_string ")"
  | Down (n) -> print_string "(Down " ; print_int n ; print_string ")"
  | Left (n) -> print_string "(Left " ; print_int n ; print_string ")"
  | Right (n) -> print_string "(Right " ; print_int n ; print_string ")"
  | Seq (p,q) -> prettyPrint p ; print_string " ; " ; prettyPrint q 
  | IF (b,p,q) -> print_string "\n[\n if \n  " ; 
                  prettyPrint b ; print_string "\nthen \n  " ; 
                  prettyPrint p ; print_string "\nelse \n  " ; 
                  prettyPrint q ; print_string "\n]\n" 
;; 
