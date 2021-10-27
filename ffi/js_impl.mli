open Js_of_ocaml

val say : string -> unit
val invoke : (unit -> int) -> unit

class type hello_pair =
  object
    method first : int Js.readonly_prop
    method second : int Js.readonly_prop
    method print : unit Js.meth
    method double : hello_pair Js.t Js.meth
end

val make_pair : int -> int -> hello_pair Js.t
