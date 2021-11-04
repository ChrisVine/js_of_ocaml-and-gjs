open Js_of_ocaml
open Imports

(* A scrolled_text object is a ScrolledWindow which has a TextView as
   its child.  We only use its get_vadjustment and get_child methods.
   The buffer of the TextView child has an end mark named "end-mark"
   set for it.  *)
class type scrolled_text =
  object
    method get_vadjustment_ : 'a Js.t Js.meth
    method get_child_ : 'a Js.t Js.meth
  end

let make () : scrolled_text Js.t =
  let scrolled_window =
    new_gjs gtk##.ScrolledWindow (object%js
                                    val has_frame_ = Js._true
                                    val vexpand = Js._true
                                    val hscrollbar_policy_ = gtk##.PolicyType##.AUTOMATIC
                                    val vscrollbar_policy_ = gtk##.PolicyType##.ALWAYS
                                  end) in

  let text_view =
    new_gjs gtk##.TextView (object%js
                              val editable = Js._false
                            end) in
  let buffer = text_view##get_buffer_ in
  let iter = buffer##get_end_iter_ in
  ignore (buffer##create_mark_ (Js.string "end-mark") iter Js._false) ;
  ignore (scrolled_window##set_child_ text_view) ;
  scrolled_window

let append (scrolled_text : scrolled_text Js.t) text =
  let text_view = scrolled_text##get_child_ in
  let buffer = text_view##get_buffer_ in
  let iter = buffer##get_end_iter_ in
  ignore (buffer##insert iter (Js.string text) (-1)) ;

  let adj = scrolled_text##get_vadjustment_ in
  let scrolling =
    if adj##get_value_ >= adj##get_upper_ -. adj##get_page_size_ -. 1e-12 then true
    else false in
  if scrolling then
    let mark = buffer##get_mark_ (Js.string "end-mark") in
    ignore (text_view##scroll_to_mark_ mark 0.0 Js._false 0.0 0.0)
