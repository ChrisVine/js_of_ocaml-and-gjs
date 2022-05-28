open Js_of_ocaml
open Imports

let startup_cb app =
  (* construct menubar and menu objects *)
  let menubar = new_gjs gio##.Menu (object%js end) in
  let menu = new_gjs gio##.Menu (object%js end) in
  ignore (menubar##append_submenu_ (Js.string "Menu1") menu) ;
  ignore (menu##append (Js.string "Beep" ) (Js.string "app.beep")) ;
  ignore (menu##append (Js.string "Quit" ) (Js.string "app.quit")) ;

  (* add the menubar to the GtkApplicationWindow object *)
  ignore (app##set_menubar_ menubar) ;

  (* add corresponding actions to the GtkApplicationWindow's
     GActionMap *)
  (* this will comprise the app.beep action *)
  let beep_act = new_gjs gio##.SimpleAction (object%js
                                               val name = Js.string "beep"
                                             end) in
  ignore (beep_act##connect (Js.string "activate")
                            (Js.wrap_callback (fun _ _ ->
                                 (gdk##.Display##get_default_)##beep))) ;
  ignore (app##add_action_ beep_act) ;
  (* this is the app.quit action *)
  let quit_act = new_gjs gio##.SimpleAction (object%js
                                               val name = Js.string "quit"
                                             end) in
  ignore (quit_act##connect (Js.string "activate")
                            (Js.wrap_callback (fun _ _ -> app##quit))) ;
  ignore (app##add_action_ quit_act)

let construct_gui app : unit =
  let win = new_gjs gtk##.ApplicationWindow (object%js
                                               val application = app
                                               val title = Js.string "gtk4"
                                               val show_menubar_ = Js._true
                                               val default_width_ = 600
                                               val default_height_ = 400
                                             end) in
  let box =
    new_gjs gtk##.Box (object%js
                         val orientation = gtk##.Orientation##.VERTICAL
                         val homogeneous = Js._false
                         val spacing = 2
                         val margin_bottom_ = 10
                         val margin_top_ = 10
                         val margin_start_ = 10
                         val margin_end_ = 10
                         val vexpand = Js._true
                         val valign = gtk##.Align##.FILL
                       end) in
  let button_box =
    new_gjs gtk##.Box (object%js
                         val orientation = gtk##.Orientation##.HORIZONTAL
                         val homogeneous = Js._true
                         val spacing = 5
                         val vexpand = Js._false
                         val valign = gtk##.Align##.CENTER
                         val hexpand = Js._false
                         val halign = gtk##.Align##.CENTER
                         val margin_top_ = 10
                       end) in
  let button =
    new_gjs gtk##.Button (object%js
                            val label = Js.string "Click me"
                          end) in
  let scrolled_text = Scrolled_text.make () in
  ignore (win##set_child_ box) ;
  ignore (box##append scrolled_text) ;
  ignore (box##append button_box) ;
  ignore (button_box##append button) ;
  ignore (button##connect (Js.string "clicked")
                          (Js.wrap_callback
                             (fun _ -> Callbacks.on_clicked scrolled_text))) ;
  ignore (win##set_default_widget_ button) ;

  Scrolled_text.append scrolled_text "hello" ;
  Scrolled_text.append scrolled_text " world" ;

  ignore (win##show)

let activate_cb app : unit =
  match Js.Opt.to_option (app##get_active_window_) with
    Some win -> ignore (win##present)
  | None -> construct_gui app

let start () =
  ignore (glib##set_prgname_ (Js.string "gtk4")) ;
  let app =
    new_gjs gtk##.Application (object%js
                                 val application_id_ = Js.string "org.cvine.demo"
                               end) in
  ignore (app##connect (Js.string "startup") (Js.wrap_callback startup_cb)) ;
  ignore (app##connect (Js.string "activate") (Js.wrap_callback activate_cb)) ;

  ignore (app##run Js.null)
 
