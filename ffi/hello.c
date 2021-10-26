#include <hello.h>
#include <stdio.h>

void hello_say(const char* name) {
  printf("Hello, %s\n", name);
  fflush(stdout);
}

void hello_invoke(HelloCb func) {
  printf("hello_invoke: ocaml function evaluated to %d\n", func());
  fflush(stdout);
}

HelloPair* hello_pair_copy (HelloPair* pair) {
  HelloPair* ret = malloc(sizeof(HelloPair));
  ret->first = pair->first;
  ret->second = pair->second;
  return ret;
}

void hello_pair_free (HelloPair* pair) {
  free(pair);
}

GType hello_pair_get_type (void) {
    static GType type = 0;
    if (G_UNLIKELY (!type))
        type = g_boxed_type_register_static("HelloPair",
					    (GBoxedCopyFunc) hello_pair_copy,
					    (GBoxedFreeFunc) hello_pair_free);
    return type;
}

void hello_pair_print(HelloPair* pair) {
  printf("first is %d, second is %d\n", pair->first, pair->second);
  fflush(stdout);
}
