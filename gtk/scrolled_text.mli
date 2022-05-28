open Js_of_ocaml

(* The code in this directory does not in general provide public
   wrappers for the raw javascript entities presented by gjs by means
   of public 'class type ...' definitions.  Instead, where viable it
   wraps such entities behind conventional ocaml interfaces.  This
   enables the main program logic to be written in standard ocaml
   (where relevant, executed as callbacks for GUI events) so that only
   the separated out GUI code is written in javascript-ocamlish.

   This includes, as here, using ocaml interfaces to present modified
   or extended versions of raw gjs entities.  This Scrolled_text
   module provides a Gtk.ScrolledWindow object with a built-in
   Gtk.TextView object as child, which is provided with an append
   function for appending text to it in a way consist with its
   scrolling status and usable by conventional ocaml code. *)

type t

val make : unit -> t
val append : t -> string -> unit
