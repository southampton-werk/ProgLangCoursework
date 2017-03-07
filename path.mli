(* Interface file for Path data type *)

type pTerm = Pred of string * int | Union of int * int;;

val prettyPrint : pTerm -> string -> unit
