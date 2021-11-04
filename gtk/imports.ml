open Js_of_ocaml

let print_prim = Js.Unsafe.global##.print
let print_line (s:string) : unit =
  Js.Unsafe.(fun_call print_prim [| inject (Js.string s) |])
let print_js obj : unit =
  let open Js_of_ocaml in
  let s = obj##toString obj in
  Js.Unsafe.(fun_call print_prim [| inject s |])

let imports = Js.Unsafe.global##.imports
let _ = imports##.package##require (object%js val _Gtk = Js.string "4.0" end)
(* alternatively instead of the above package operation we could do:
let _ = imports##.gi##.versions##.Gtk := Js.string "4.0"
*)

(* A utility function for constructing gjs javascript objects, which
   forces 'constr' to evaluate so that the ##. accessor ppx can be
   used to pass in the constructor function.  gjs constructors always
   take a single argument (a javascript object) containing properties
   of the type to be constructed.  That object can be constructed with
   the object%js ppx. *)
let new_gjs constr props =
  new%js constr props

let glib = imports##.gi##.GLib
let gio = imports##.gi##.Gio
let gdk = imports##.gi##.Gdk
let gtk = imports##.gi##.Gtk
