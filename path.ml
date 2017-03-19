(* Data type of terms *)

type word = Ident of string ;;
type inlanguage = Singleton of word | Multiple of inlanguage * word;;
type language = LanguageOver of int * inlanguage | Kleen of string ;;
type set = Pref of word * int | Union of int * int | Intersection of int * int | Join of int * language;;
type bool = Subset of inlanguage * int;;
type pTerm = Set of set  | Newexpr of pTerm * pTerm | In of pTerm * pTerm | Loop of int * pTerm | If of bool * pTerm * pTerm  ;;

module SS = Set.Make(String);;

let rec of_list = function
  | [] -> SS.empty
  | hd::tl -> SS.add hd (of_list tl)
;;

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

let print_elements k e =
  print_string "{";
  aux_print_elements e 0 k;
  print_string "}\n"
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
    let sizedSet = SS.elements (of_list (sizeSet 1 size suffSet suffSet)) in
      joinAllElement joinList sizedSet
;;
let joinSet suff wordSet k =
  let joinList = SS.elements wordSet in
    match suff with
    |Kleen (s) ->  joinKleeneWord s (List.nth joinList 0) 0 k
    |LanguageOver (size,words) -> languageOver joinList size words
;;

let unionLang language1 language2 =
    SS.elements (SS.union language1 language2)
;;

let intersectionLang language1 language2 =
    SS.elements (SS.inter language1 language2)
;;
let stringToWordList input =
  let bracketsFiltered = String.sub input 1 ((String.length input) - 2) in
      let spacesRemoved = Str.global_replace (Str.regexp " ") "" bracketsFiltered in
        let findEmptyWord = Str.global_replace (Str.regexp ":") "" spacesRemoved in
          let listFiltered = Str.split (Str.regexp ",") findEmptyWord in
              of_list listFiltered
;;
let stringToLangaugeList input =
    let stringList = Str.split (Str.regexp "\n") input in
      List.map stringToWordList stringList
;;
let rec workOut set input k = match set with
| Pref (pre,lang) -> prefSet pre (List.nth input lang)
| Union (lang1,lang2) -> unionLang (List.nth input lang1) (List.nth input lang2)
| Intersection (lang1,lang2) -> intersectionLang (List.nth input lang1) (List.nth input lang2)
| Join (lang,word) -> joinSet word (List.nth input lang) k
;;

let resolveBooleanExpression booleanExpression input = match booleanExpression with
 | Subset (subset,lang) -> SS.subset (inputLanguage subset) (List.nth input lang)
;;


let rec resolveLoop counter loopTimes pTerm input k =
  if (counter < loopTimes)
  then resolveLoop (counter + 1) loopTimes pTerm (List.map of_list (inputNowSets pTerm input k)) k
  else List.map SS.elements input
and inputNowSets pTerm input k = match pTerm with
  | Set (set) -> (workOut set input k) :: []
  | Newexpr (pterm1,pterm2) -> List.append (inputNowSets pterm1 input k) (inputNowSets pterm2 input k)
  | In (pterm1,pterm2) -> inputNowSets pterm2 (List.map of_list (inputNowSets pterm1 input k)) k
  | Loop (loopTimes,pterm) -> resolveLoop 0 loopTimes pterm input k
  | If (booleanexpression,pterm1,pterm2) -> if (resolveBooleanExpression booleanexpression input) then (inputNowSets pterm1 input k) else (inputNowSets pterm2 input k)
;;

let rec prettyPrint pTerm input k =
  List.iter (print_elements k) (inputNowSets pTerm (stringToLangaugeList input) k)
;;
