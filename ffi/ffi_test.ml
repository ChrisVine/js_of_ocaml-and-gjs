let () = Js_impl.say "Chris"

let () =
  (* ocaml closure *)
  let ret = 5 in
  let cb () = ret in
  Js_impl.invoke cb

let () =
  let pair = Js_impl.make_pair 1 2 in
  pair##print ;
  let doubled = pair##double in
  doubled##print
