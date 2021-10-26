open Js_of_ocaml

let imports = Js.Unsafe.global##.imports

(* set the GI repository for typelib files to include the local
   directory, so Hello-0.1.typelib can be found *)
let repository = imports##.gi##.GIRepository##.Repository
let _ = repository##prepend_search_path_ (Js.string ".")

let hello = imports##.gi##.Hello

let say name = ignore (hello##say (Js.string name))
let invoke cb = ignore (hello##invoke (Js.wrap_callback cb))

class type hello_pair =
  object
    method first : int Js.prop
    method second : int Js.prop
    method print : unit Js.meth
end

let make_pair first second : hello_pair Js.t =
  let constr = hello##.Pair in
  new%js constr (object%js
                   val first = first
                   val second = second
                 end)
