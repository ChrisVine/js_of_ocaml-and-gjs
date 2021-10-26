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

/* Below: example of function taking a struct (record).  The easiest
   way of doing this with gjs is using GBoxedType, so enabling a
   javascript constructor to be invoked for it. */

#include <glib-object.h>
#include <glib.h>

typedef struct _HelloPair {
  int first;
  int second;
} HelloPair;

#define HELLO_PAIR_TYPE (hello_pair_get_type())

GType hello_pair_get_type(void);

/* We don't want hello_pair_copy and hello_pair_free to be
   introspected (they are for the implementation only), so annotate
   them accordingly */
/**
  * hello_pair_copy: (skip)
  */
HelloPair* hello_pair_copy(HelloPair* pair);

/**
 * hello_pair_free: (skip)
 */
void hello_pair_free(HelloPair* pair);

void hello_pair_print(HelloPair* pair);

#endif /* HELLO_H */
