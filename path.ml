(* Data type of terms *)
type word = Ident of string | Kleen of word  ;;
type pTerm = Pref of string * int | Union of int * int | Intersection of int * int | Join of int * word  ;;
module SS = Set.Make(String);;


let rec aux_print_elements e =
    match e with
    | [] -> print_string ""
    | [x] -> print_string x
    | x::t -> print_string (x ^ ","); aux_print_elements t
;;

let print_elements e =
  print_string "{";
  aux_print_elements e;
  print_string "}"
;;

let print_set s =
  print_elements (SS.elements s);
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

let prefWord pre word =
  (pre ^ word)
;;
let prefSet pre wordSet =
  let prefList = SS.elements wordSet in
    print_elements (List.map (prefWord pre) prefList)
;;

let unionLang int1 int2 input =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    print_set (SS.union language1 language2)
;;

let intersectionLang int1 int2 input =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    print_set (SS.inter language1 language2)
;;

let rec prettyPrint pTerm input = match pTerm with
| Pref (pre,lang) -> prefSet pre (List.nth (stringToLangaugeList input) lang )
| Union (lang1,lang2) -> unionLang lang1 lang2 input
| Intersection (lang1,lang2) -> intersectionLang lang1 lang2 input
| Join (lang,word) -> print_string "join"
;;
