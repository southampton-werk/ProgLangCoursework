(* Data type of terms *)

type word = Ident of string ;;
type inlanguage = Singleton of word | Multiple of inlanguage * word;;
type language = LanguageOver of int * inlanguage | Kleen of string ;;
type set = Pref of word * int | Union of int * int | Intersection of int * int | Join of int * language;;
type pTerm = Set of set  | Newexpr of set * pTerm | In of set * pTerm  ;;
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

let rec aux_create_input_string e = match e with
    | [] -> ""
    | [x] -> x
    | x::t ->  (x ^ ", ") ^ (aux_create_input_string t)
;;

let create_input_string e =
  let output = "{" in
  let output = output ^ (aux_create_input_string e) in
  output ^ "}"
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


let prefSet pre wordSet =
  let prefList = SS.elements wordSet in
    match pre with
    |Ident (s) -> List.map (prefSimpleWord s) prefList
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

let joinEachElement currentSet a =
  List.map (joinSimpleWord a) currentSet
;;

let joinAllElement originalSet currentSet =
  List.flatten (List.map (joinEachElement originalSet) currentSet)
;;


let rec sizeSet size targetSize originalSet currentSet  =
  if size = targetSize
  then currentSet
  else sizeSet (size + 1) targetSize originalSet (joinAllElement originalSet currentSet)
;;

let languageOver joinList size words  =
  let suffSet = SS.elements (inputLanguage words) in
    let sizedSet = sizeSet 1 size suffSet suffSet in
      joinAllElement joinList sizedSet
;;
let joinSet suff wordSet k =
  let joinList = SS.elements wordSet in
    match suff with
    |Kleen (s) ->  joinKleeneWord s (List.nth joinList 0) 0 k
    |LanguageOver (size,words) -> languageOver joinList size words
;;

let unionLang int1 int2 input =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    SS.elements (SS.union language1 language2)
;;

let intersectionLang int1 int2 input =
  let language1 = List.nth (stringToLangaugeList input) int1
  and language2 = List.nth (stringToLangaugeList input) int2 in
    SS.elements (SS.inter language1 language2)
;;

let rec workOut set input k = match set with
| Pref (pre,lang) -> prefSet pre (List.nth (stringToLangaugeList input) lang)
| Union (lang1,lang2) -> unionLang lang1 lang2 input
| Intersection (lang1,lang2) -> intersectionLang lang1 lang2 input
| Join (lang,word) -> joinSet word (List.nth (stringToLangaugeList input) lang) k
;;
let rec prettyPrint pTerm input k = match pTerm with
| Set (set) -> print_elements (workOut set input k) k
| Newexpr (pterm1,pterm2) -> print_elements (workOut pterm1 input k) k; print_string "\n"; prettyPrint pterm2 input k
| In (pterm1,pterm2) -> prettyPrint pterm2 (create_input_string (workOut pterm1 input k)) k
;;
