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

/* Below: example of function taking or returning a struct (record).
   The easiest way of doing this with gjs is using GBoxedType, so
   enabling a javascript constructor to be invoked for it. */

#include <glib.h>
#include <glib-object.h>

typedef struct _HelloPair {
  int first;
  int second;
} HelloPair;

/* the hello_pair_get_type() function is built by the
   G_DEFINE_BOXED_TYPE macro in hello.c.  Its declaration is required
   here by the scanner. */
GType hello_pair_get_type(void);

void hello_pair_print(HelloPair* pair);

HelloPair* hello_pair_double(HelloPair* pair);

#endif /* HELLO_H */
