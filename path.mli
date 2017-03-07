(* Interface file for Path data type *)

type word = Ident of string | Kleen of word  ;;

type pTerm = Pref of string * int | Union of int * int | Intersection of int * int | Join of int * word ;;

val prettyPrint : pTerm -> string -> unit
