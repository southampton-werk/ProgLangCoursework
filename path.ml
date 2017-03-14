(* Data type of terms *)

type word = Ident of string ;;
type inlanguage = Singleton of word | Multiple of inlanguage * word;;
type language = LanguageOver of int * inlanguage | Kleen of string ;;
type pTerm = Pref of word * int | Union of int * int | Intersection of int * int | Join of int * language  | Newexpr of pTerm * pTerm ;;
module SS = Set.Make(String);;


let rec aux_print_elements e count k =
    if (count < k - 1 )
    then match e with
    | [] -> print_string ""
    | [x] -> print_string x
    | x::t -> print_string (x ^ ", "); aux_print_elements t (count + 1) k
    else match e with
    | [] -> print_string ""
    | [x] -> print_string x
    | x::t -> print_string x
;;

let print_elements e k =
  print_string "{";
  aux_print_elements e 0 k;
  print_string "}"
;;

let print_set s k =
  print_elements (SS.elements s) k;
;;



let stringToWordList input =
  let bracketsFiltered = String.sub input 1 ((String.length input) - 2) in
      let spacesRemoved = Str.global_replace (Str.regexp " ") "" bracketsFiltered in
          let listFiltered = Str.split (Str.regexp ",") spacesRemoved in
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
    |Ident (s) -> print_elements (List.map (prefSimpleWord s) prefList) k
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

let inputLanguageSingleton element =
  match element with
  |Ident (s) -> SS.singleton s
;;
let rec inputLanguage inlanguage =
  match inlanguage with
  |Singleton (s) -> inputLanguageSingleton s
  |Multiple (set,s) -> SS.union (inputLanguage set) (inputLanguageSingleton s)
;;

let languageOver wordSet size words =
  print_set (inputLanguage words) 5
;;
let joinSet suff wordSet k =
  let joinList = SS.elements wordSet in
    match suff with
    |Kleen (s) -> print_elements (joinKleeneWord s (List.nth joinList 0) 0 k) k
    |LanguageOver (size,words) -> languageOver wordSet size words
;;

let unionLang int1 int2 input k =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    print_set (SS.union language1 language2) k
;;

let intersectionLang int1 int2 input k =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    print_set (SS.inter language1 language2) k
;;

let rec prettyPrint pTerm input k = match pTerm with
| Pref (pre,lang) -> prefSet pre (List.nth (stringToLangaugeList input) lang) k
| Union (lang1,lang2) -> unionLang lang1 lang2 input k
| Intersection (lang1,lang2) -> intersectionLang lang1 lang2 input k
| Join (lang,word) ->  joinSet word (List.nth (stringToLangaugeList input) lang) k
| Newexpr (pterm1,pterm2) -> prettyPrint pterm1 input k; print_string "\n"; prettyPrint pterm2 input k
;;
