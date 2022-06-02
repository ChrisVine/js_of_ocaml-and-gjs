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

void hello_print_pair(HelloPair* pair) {
  printf("first is %d, second is %d\n", pair->first, pair->second);
  fflush(stdout);
}

HelloTriple* hello_triple_new(int first, int second, int third) {
  HelloTriple* ret = malloc(sizeof(HelloTriple));
  ret->first = first;
  ret->second = second;
  ret->third = third;
  return ret;
}

void hello_print_triple(HelloTriple* triple) {
  printf("first is %d, second is %d, third is %d\n",
	 triple->first, triple->second, triple->third);
  fflush(stdout);
}

HelloTriple* hello_double_triple(HelloTriple* triple) {
  hello_triple_new(triple->first * 2, triple->second * 2,
		   triple->third * 2);
}

static HelloTriple* hello_triple_copy(HelloTriple* triple) {
  HelloTriple* ret = malloc(sizeof(HelloTriple));
  *ret = *triple;
  return ret;
}

static void hello_triple_free(HelloTriple* triple) {
  free(triple);
}

/* This macro constructs a function hello_triple_get_type() with the
   signature:

     GType hello_triple_get_type(void)

   which will call g_boxed_type_register_static() for the
   "HelloTriple" type on first invocation. */

G_DEFINE_BOXED_TYPE(HelloTriple, hello_triple,
		    hello_triple_copy, hello_triple_free)
