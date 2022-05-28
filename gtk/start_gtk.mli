(* The code in this directory does not in general provide public
   wrappers for the raw javascript entities presented by gjs by means
   of public 'class type ...' definitions.  Instead, where viable it
   wraps such entities behind conventional ocaml interfaces.  This
   enables the main program logic to be written in standard ocaml
   (where relevant, executed as callbacks for GUI events) so that only
   the separated out GUI code is written in javascript-ocamlish. *)

val start : unit -> unit
