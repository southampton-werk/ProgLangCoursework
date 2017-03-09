(* Data type of terms *)
type word = Ident of string | Kleen of string  ;;
type pTerm = Pref of word * int | Union of int * int | Intersection of int * int | Join of int * word  | Newexpr of pTerm * pTerm;;
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



let prefSimpleWord pre word =
  (pre ^ word)
;;
let stringRepeat s n =
  Array.fold_left (^) "" (Array.make n s)
;;
let prefKleeneWord pre word i k =
  let rec aux acc i =
    if i <= k then
      aux (((stringRepeat pre i) ^ word) ::acc) (i+1)
    else (List.rev acc)
  in
  aux [] i
;;


let prefSet pre wordSet k =
  let prefList = SS.elements wordSet in
    match pre with
    |Ident (s) -> print_elements (List.map (prefSimpleWord s) prefList)
    |Kleen (s) -> print_elements (prefKleeneWord s (List.nth prefList 0) 0 k)
;;

let joinSimpleWord suff word =
  (word ^ suff)
;;

let joinKleeneWord suff word i k =
  let rec aux acc i =
    if i <= k then
      aux ((word ^ (stringRepeat suff i)) ::acc) (i+1)
    else (List.rev acc)
  in
  aux [] i
;;

let joinSet pre wordSet k =
  let joinList = SS.elements wordSet in
    match pre with
    |Ident (s) -> print_elements (List.map (joinSimpleWord s) joinList)
    |Kleen (s) -> print_elements (joinKleeneWord s (List.nth joinList 0) 0 k)
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
| Pref (pre,lang) -> prefSet pre (List.nth (stringToLangaugeList input) lang) 5
| Union (lang1,lang2) -> unionLang lang1 lang2 input
| Intersection (lang1,lang2) -> intersectionLang lang1 lang2 input
| Join (lang,word) ->  joinSet word (List.nth (stringToLangaugeList input) lang) 5
| Newexpr (pterm1,pterm2) -> prettyPrint pterm1 input; print_string "\n"; prettyPrint pterm2 input
;;
