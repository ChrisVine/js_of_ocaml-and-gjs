let on_clicked =
  let counter = ref 0 in
  fun st -> incr counter ;
            let text = Printf.sprintf "\nClicked: %d" !counter in
            Scrolled_text.append st text
