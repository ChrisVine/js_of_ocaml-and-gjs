#include <hello.h>
#include <stdio.h>
#include <stdlib.h>

void hello_say(const char* name) {
  printf("Hello, %s\n", name);
  fflush(stdout);
}

void hello_invoke(HelloCb func) {
  printf("hello_invoke: ocaml function evaluated to %d\n", func());
  fflush(stdout);
}

GBytes* hello_get_bytes(void) {
  char arr[] = "I am a GBytes return value";
  return g_bytes_new(arr, sizeof(arr) - 1);
}

HelloPair* hello_pair_new(int first, int second) {
  HelloPair* ret = malloc(sizeof(HelloPair));
  ret->first = first;
  ret->second = second;
  return ret;
}

void hello_print_pair(HelloPair* pair) {
  printf("first is %d, second is %d\n", pair->first, pair->second);
  fflush(stdout);
}

static HelloPair* hello_pair_copy(HelloPair* pair) {
  HelloPair* ret = malloc(sizeof(HelloPair));
  *ret = *pair;
  return ret;
}

static void hello_pair_free(HelloPair* pair) {
  free(pair);
}

/* This macro constructs a function hello_pair_get_type() with the
   signature:

     GType hello_pair_get_type(void)

   which will call g_boxed_type_register_static() for the "HelloPair"
   type on first invocation. */

G_DEFINE_BOXED_TYPE(HelloPair, hello_pair,
		    hello_pair_copy, hello_pair_free)
