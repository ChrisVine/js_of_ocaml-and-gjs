open Js_of_ocaml

let imports = Js.Unsafe.global##.imports

(* set the GI repository for typelib files to include the local
   directory, so Hello-0.1.typelib can be found *)
let repository = imports##.gi##.GIRepository##.Repository
let _ = repository##prepend_search_path_ (Js.string ".")

let hello = imports##.gi##.Hello

let say name = ignore (hello##say (Js.string name))
let invoke cb = ignore (hello##invoke (Js.wrap_callback cb))

(* Objects constructed by make_pair are of GBoxed type and are best
   treated as immutable, as a way of passing structured information
   from Javascript to C or vice versa: for more see
   http://webreflection.github.io/gjs-documentation/GObject-2.0/GObject.TYPE_BOXED.html
   Accordingly, the properties below are made read only.  If something
   different and more complex is required, consider constructing a
   full-on GObject in the relevant C code instead of a GBoxed type.
   *)
class type hello_pair =
  object
    method first : int Js.readonly_prop
    method second : int Js.readonly_prop
end

let make_pair first second : hello_pair Js.t =
  let constr = hello##.Pair in
  new%js constr (object%js
                   val first = first
                   val second = second
                 end)

let print_pair pair =
  hello##print_pair_ pair

let double_pair pair =
  hello##double_pair_ pair
