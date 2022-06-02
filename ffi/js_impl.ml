open Js_of_ocaml

let imports = Js.Unsafe.global##.imports

(* set the GI repository for typelib files to include the local
   directory, so Hello-0.1.typelib can be found *)
let repository = imports##.gi##.GIRepository##.Repository
let _ = repository##prepend_search_path_ (Js.string ".")

let hello = imports##.gi##.Hello

let say name = ignore (hello##say (Js.string name))
let invoke cb = ignore (hello##invoke (Js.wrap_callback cb))

(* hello##get_bytes returns a boxed GBytes value, which can be
   converted to a Typed_array.uint8Array value by gjs's
   imports##.byteArray##fromGBytes function *)
let get_bytes () = imports##.byteArray##fromGBytes hello##get_bytes_

(* The boxed object constructed by gjs on applying make_pair is best
   treated as immutable, as a way of passing structured information
   from Javascript to C or vice versa.  The gjs implementation may
   make copies of GBoxed objects at various times, so they do not
   necessarily behave as if passed by reference as in C.  For more see
   http://webreflection.github.io/gjs-documentation/GObject-2.0/GObject.TYPE_BOXED.html
   Accordingly, the properties below are made read only.  If something
   different and more complex is required, consider constructing a
   full-on GObject in the relevant C code instead of a GBoxed type,
   which will be passed by reference in gjs. *)
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
  make_pair (pair##.first * 2) (pair##.second * 2)

(* Objects constructed by make_triple are of GBoxed type and are best
   treated as immutable, as a way of passing structured information
   from Javascript to C or vice versa.  The gjs implementation may
   make copies of GBoxed objects at various times, so they do not
   necessarily behave as if passed by reference as in C.  For more see
   http://webreflection.github.io/gjs-documentation/GObject-2.0/GObject.TYPE_BOXED.html
   Accordingly, the properties below are made read only.  If something
   different and more complex is required, consider constructing a
   full-on GObject in the relevant C code instead of a GBoxed type,
   which will be passed by reference in gjs. *)
class type hello_triple =
  object
    method first : int Js.readonly_prop
    method second : int Js.readonly_prop
    method third : int Js.readonly_prop
end

let make_triple first second third : hello_triple Js.t =
  hello##.Triple##new_ first second third

let print_triple triple =
  hello##print_triple_ triple

let double_triple triple =
  hello##double_triple_ triple
