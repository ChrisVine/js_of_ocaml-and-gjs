#include <hello.h>
#include <stdio.h>
#include <stdlib.h>

#include <glib.h>
#include <glib-object.h>

void hello_say(const char* name) {
  printf("Hello, %s\n", name);
  fflush(stdout);
}

void hello_invoke(HelloCb func) {
  printf("hello_invoke: ocaml function evaluated to %d\n", func());
  fflush(stdout);
}

void hello_pair_print(HelloPair* pair) {
  printf("first is %d, second is %d\n", pair->first, pair->second);
  fflush(stdout);
}

static HelloPair* hello_pair_copy(HelloPair* pair) {
  HelloPair* ret = malloc(sizeof(HelloPair));
  ret->first = pair->first;
  ret->second = pair->second;
  return ret;
}

static void hello_pair_free(HelloPair* pair) {
  free(pair);
}

/* This macro constructs a function hello_pair_get_type() which will
   call g_boxed_type_register_static() for the "HelloPair" type */
G_DEFINE_BOXED_TYPE(HelloPair, hello_pair,
		    hello_pair_copy, hello_pair_free)
