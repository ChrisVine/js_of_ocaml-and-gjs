#ifndef HELLO_H
#define HELLO_H

/* Example of function taking a string */

void hello_say(const char* name);

/* Below: example of function taking a callback (which will be an
   ocaml callback) */

typedef int (*HelloCb)(void);

/* It is mandatory to annotate the callback argument */
/**
 * hello_invoke:
 * @func: (scope call)
 */
void hello_invoke(HelloCb func);

#include <glib.h>
#include <glib-object.h>

/* Example of returning an array of bytes from C in the form of a
   GBytes object as boxed by GObject's GBoxed.  The GBytes return
   value requires including GLib-2.0 when calling up g-ir-scanner. */

GBytes* hello_get_bytes(void);

/* Below: example of function taking or returning a struct (record) of
   immediate types.  gjs will provide a constructor taking a
   javascript object with the field values, which can be invoked using
   new%js syntax, and which will generate an introspectable GBoxed
   object automatically. */

typedef struct _HelloPair {
  int first;
  int second;
} HelloPair;

/* hello_print_pair() and not hello_pair_print() - the latter would
   cause the the scanner to treat the function as the 'print' method
   of a pair object, not as a free-standing function.  That would work
   fine, but since the pair is a bare struct, it does not seem right
   presentionally. */
void hello_print_pair(HelloPair* pair);

/* Below: example of a function taking or returning a struct (record)
   of arbitrary types.  In order to customize its construction,
   copying and freeing it is made a GBoxed type by hand.  For more
   complex structs, consider a reference counting implementation in
   the style of GBytes.

   GBoxed objects of this kind should be constructed by invoking
   hello_triple_new() (aka hello##.Triple##new_), not by applying
   new%js - see the make_triple ocaml function.  One way of enforcing
   this (not done here) is to make hello_triple Js.t an abstract type
   in js_impl.mli and include all the code requiring access to its
   fields in js_impl.ml. */

typedef struct _HelloTriple {
  int first;
  int second;
  int third;
} HelloTriple;

/* the hello_triple_get_type() function is built by the
   G_DEFINE_BOXED_TYPE macro in hello.c.  Its declaration is required
   here by the scanner. */
GType hello_triple_get_type(void);

HelloTriple* hello_triple_new(int first, int second, int third);

/* hello_print_triple() and not hello_triple_print() - the latter would
   cause the the scanner to treat the function as the 'print' method
   of a triple object, not as a free-standing function.  That would work
   fine, but since the triple is a bare struct, it does not seem right
   presentionally. */
void hello_print_triple(HelloTriple* triple);

#endif /* HELLO_H */
