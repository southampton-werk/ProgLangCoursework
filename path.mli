(* Interface file for Path data type *)

type pTerm = Pred of string ;;

val prettyPrint : pTerm -> unit