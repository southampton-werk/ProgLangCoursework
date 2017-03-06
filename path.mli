(* Interface file for Path data type *) 

type pTerm = Blocked of int | Up of int | Down of int | Right of int | Left of int | Seq of pTerm * pTerm | IF of pTerm * pTerm * pTerm | Pred of string ;;

val prettyPrint : pTerm -> unit  
