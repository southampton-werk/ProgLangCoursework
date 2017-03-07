(* Interface file for Path data type *)

type pTerm = Pref of string * int | Union of int * int | Intersection of int * int;;

val prettyPrint : pTerm -> string -> unit
