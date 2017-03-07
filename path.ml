(* Data type of terms *)
type pTerm = Pred of string * int | Union of int * int ;;

module SS = Set.Make(String);;


let rec print_elements e = match e with
    | [] -> print_string ""
    | [x] -> print_string x
    | x::t -> print_string (x ^ ","); print_elements t;;

let print_set s =
  print_string "{";
  print_elements (SS.elements s);
  print_string "}"

;;


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

let unionLang int1 int2 input =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    print_set (SS.union language1 language2)
;;

let rec prettyPrint pTerm input = match pTerm with
| Pred (pre,lang) -> predSet pre (List.nth (stringToLangaugeList input) lang )
| Union (lang1,lang2) -> unionLang lang1 lang2 input
;;
