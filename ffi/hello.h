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

/* Below: example of function taking or returning a struct (record).
   The easiest way of doing this with gjs is using GBoxedType, so
   enabling a javascript constructor to be invoked for it. */

typedef struct _HelloPair {
  int first;
  int second;
} HelloPair;

/* the hello_pair_get_type() function is built by the
   G_DEFINE_BOXED_TYPE macro in hello.c.  Its declaration is required
   here by the scanner. */
GType hello_pair_get_type(void);

/* hello_print_pair() and not hello_pair_print() - the latter would
   cause the the scanner to treat the function as the 'print' method
   of a pair object, not as a free-standing function.  That would work
   fine, but since the pair is a bare struct, it does not seem right
   presentionally. */
void hello_print_pair(HelloPair* pair);

/* hello_double_pair() and not hello_pair_double() - see above. */
HelloPair* hello_double_pair(HelloPair* pair);

#endif /* HELLO_H */
