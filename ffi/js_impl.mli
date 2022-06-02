open Js_of_ocaml

val say : string -> unit
val invoke : (unit -> int) -> unit

val get_bytes : unit -> Typed_array.uint8Array Js.t

class type hello_pair =
  object
    method first : int Js.readonly_prop
    method second : int Js.readonly_prop
end

val make_pair : int -> int -> hello_pair Js.t
val print_pair : hello_pair Js.t -> unit
val double_pair : hello_pair Js.t ->  hello_pair Js.t

class type hello_triple =
  object
    method first : int Js.readonly_prop
    method second : int Js.readonly_prop
    method third : int Js.readonly_prop
end

val make_triple : int -> int -> int -> hello_triple Js.t
val print_triple : hello_triple Js.t -> unit
val double_triple : hello_triple Js.t ->  hello_triple Js.t
