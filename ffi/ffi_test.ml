let () = Js_impl.say "Chris"

let () =
  (* ocaml closure *)
  let ret = 5 in
  let cb () = ret in
  Js_impl.invoke cb

let () =
  let pair = Js_impl.make_pair 1 2 in
  Js_impl.print_pair pair ;
  let doubled = Js_impl.double_pair pair in
  Js_impl.print_pair doubled
