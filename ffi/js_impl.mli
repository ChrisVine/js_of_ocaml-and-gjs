val say : string -> unit
val invoke : (unit -> int) -> unit

class type hello_pair =
  object
    method first : int Js_of_ocaml.Js.prop
    method second : int Js_of_ocaml.Js.prop
    method print : unit Js_of_ocaml.Js.meth
end
val make_pair : int -> int -> hello_pair Js_of_ocaml.Js.t
