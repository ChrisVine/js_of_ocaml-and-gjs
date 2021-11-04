open Js_of_ocaml

class type scrolled_text =
  object
    method get_vadjustment_ : 'a Js.t Js.meth
    method get_child_ : 'a Js.t Js.meth
  end

val make : unit -> scrolled_text Js.t
val append : scrolled_text Js.t -> string -> unit

