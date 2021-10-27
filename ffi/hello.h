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

typedef struct _HelloPair {
  int first;
  int second;
} HelloPair;

void hello_pair_print(HelloPair* pair);

#endif /* HELLO_H */
