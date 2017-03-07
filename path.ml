(* Data type of terms *)
type pTerm = Pred of string | Union of int * int ;;

module SS = Set.Make(String);;
let print_set s =
     SS.iter print_endline s;;

let stringToWordList input =
  let bracketsFiltered = String.sub input 1 ((String.length input) - 2) in
    let listFiltered = Str.split (Str.regexp ",") bracketsFiltered in
      SS.of_list listFiltered
;;
let stringToLangaugeList input =
    let stringList = Str.split (Str.regexp "\n") input in
      List.map stringToWordList stringList
;;

let predWord pre word =
  print_string (pre ^ word); print_string "\n"
;;
let predSet pre wordSet =
  SS.iter (predWord pre) wordSet
;;

let rec prettyPrint pTerm input = match pTerm with
  Pred (n) -> predSet n (stringToWordList input)
| Union (a,b) -> print_int a ; print_int b;
;;
