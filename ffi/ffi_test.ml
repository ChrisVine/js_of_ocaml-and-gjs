let () = Js_impl.say "Chris"

let () =
  (* ocaml closure *)
  let ret = 5 in
  let cb () = ret in
  Js_impl.invoke cb

let () =
  let open Js_of_ocaml in
  Js_impl.say @@ Typed_array.String.of_uint8Array @@ Js_impl.get_bytes ()

let () =
  let pair = Js_impl.make_pair 1 2 in
  Js_impl.print_pair pair ;
  let doubled = Js_impl.double_pair pair in
  Js_impl.print_pair doubled

let () =
  let triple = Js_impl.make_triple 1 2 3 in
  Js_impl.print_triple triple ;
  let doubled = Js_impl.double_triple triple in
  Js_impl.print_triple doubled
