Js_of_ocaml and gjs
===================

This repository is an exploration of the use of ocaml, via
js_of_ocaml, with gjs's javascript bindings for gobject-introspection.
There are two explorations: the one in the ffi directory uses the C
interface of gobject-introspection in order to supplement gjs's
bindings with locally-produced ones: in effect, they use
gobject-introspection as a C FFI for javascript.  The one in the gtk
directory uses js_of_ocaml and gobject-introspection with GTK4.

This is as much as anything a test of whether it actually works.  By
and large it does, although there are a few quirks.

As regards the use of C, if C function arguments and return values are
scalars, GBytes, strings or functions this is straightforward but
structs of these generally require the use of a GBoxedType wrapping
(see the hello.h and hello.c files in the ffi directory).  More
complex arrangements may require full-on GObjects, which is a pain.

Other points to note are:

1.  gjs does not print console.log to stdout so js_of_ocaml's printing
    functions do not work correctly (for example, Printf.sprintf is
    OK, but print_string and Printf.printf aren't).  However, for
    printing to console, spidermonkey and so gjs does provide 'print'
    and 'printerr' functions in the global object which can be used
    instead.  Furthermore spidermonkey sandboxing means that you will
    get a Sys_error exception "No such file or directory" if you try
    to use ocaml channels to access the local file system in code
    running in gjs, which in turn means that you cannot call up any
    part of a linked-in ocaml library which uses channels (code using
    channels will compile, but if run will raise the Sys_error
    exception if it tries to open a file).  To carry out file, socket
    or other i/o you can use the wrapped functions from glib's Gio
    module (and some of glib's logging functions are also available).

2.  gjs has a non-standard module system for its bindings.  All its C
    and other bindings are available via the 'imports' object provided
    by gjs in the global object.  Those available via
    gobject-introspection are in Js.Unsafe.global\##.imports\##.gi, so
    GTK is found in the Js.Unsafe.global\##.imports\##.gi\##.Gtk
    object, and some modules (for example byteArray, mainLoop, cairo
    and gettext) are made available by gjs directly in
    Js.Unsafe.global\##.imports.  (Those made available directly in
    imports are those in the modules/script directory in the gjs
    source tarball.)  Although this is non-standard, it is easy to
    use.

3.  js_of_ocaml's '##' and '##.' ppx's are challenged by
    gobject-introspection's use of underscores in function names.
    Where a property indentifier appearing to the right of '##' or
    '##.' uses snake case, you have to add an underscore at the end of
    the identifier name in applying the ppx.  The same applies to the
    property names of objects constructed with 'object%js', or the
    method names of javascript objects bound with 'class type' - if
    they use snake case you have to append an additional underscore.
    (You also have to append an underscore when using ppx'es if any of
    the property identifier names clash with an ocaml keyword, like
    'type', 'new' or 'method'; and you have to prepend an underscore
    for any property name beginning with a capital letter when using
    the 'class type' or 'object%js' ppx'es.

4.  You cannot include the \##. ppx when in the same expression as
    uses the new%js ppx - so you can't do, say, 'new%js
    Gtk\##.Window'.  You have to force evaluation of Gtk\##.Window
    with a let binding or function argument, and apply new%js to the
    binding or argument.

5.  Where the wrapped C function concerned has an out parameter, gjs
    returns a Javascript array.  The first item in the array
    represents the return value provided by C (assuming it does not
    return void), and the subsequent items in the array are the out
    parameters.

6.  gjs provides a zoo of array-like types, in addition to ocaml
    arrays and Javascript arrays.  gjs's ByteArray objects are now the
    same as Javascript Uint8Array objects: the two are in effect
    aliases.  You can convert a glib GBytes object to and from a
    Uint8Array/ByteArray object using imports\##.byteArray.fromGBytes
    and imports\##.byteArray.toGBytes respectively.  Uint8Array has an
    ocaml wrapping in js_of_ocaml's Typed_array.uint8Array type, and
    can be converted to an ocaml string (and thence to the ocaml
    Bytes.t type) via the Typed_array.String.of_uint8Array function.
