(* Interface file for Path data type *)

type word = Ident of string | Kleen of string  ;;

type pTerm = Pref of word * int | Union of int * int | Intersection of int * int | Join of int * word | Newexpr of pTerm * pTerm;;

val prettyPrint : pTerm -> string -> unit
