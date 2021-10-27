open Js_of_ocaml

val say : string -> unit
val invoke : (unit -> int) -> unit

class type hello_pair =
  object
    method first : int Js.readonly_prop
    method second : int Js.readonly_prop
end

val make_pair : int -> int -> hello_pair Js.t
val print_pair : hello_pair Js.t -> unit
val double_pair : hello_pair Js.t ->  hello_pair Js.t
