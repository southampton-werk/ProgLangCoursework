(* Interface file for Path data type *)

type word = Ident of string ;;
type inlanguage = Singleton of word | Multiple of inlanguage * word;;
type language = LanguageOver of int * inlanguage | Kleen of string ;;
type set = Pref of word * int | Union of int * int | Intersection of int * int | Join of int * language;;
type bool = Subset of inlanguage * int | CardLessThan of int * int | CardMoreThan of int * int;;
type pTerm = Set of set  | Newexpr of pTerm * pTerm | In of pTerm * pTerm | Loop of int * pTerm | If of bool * pTerm * pTerm  ;;

val prettyPrint : pTerm -> string -> int -> unit
