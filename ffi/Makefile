# Identifier prefix "hello" is the symbol prefix for all functions,
# and "Hello" is the identifier prefix for other library names such as
# typedefs in source files.  The latter is adopted also as the
# introspection namespace and so the base name of the gir and typelib
# files that are built.  Setting a namespace version is compulsory for
# the introspection compiler to work and must be included in the name
# of the typelib file.  Where a symbol or identifier prefix begins
# with a lower case letter, gobject-introspection assumes snake_case.
# Where it be begins with an upper case letter, gobject-introspection
# assumes CamelCase.  The usage below reflects common conventions
# about these.

NAMESPACE=Hello
SYMBOL_PREFIX=hello
IDENTIFIER_PREFIX=Hello
SONAME=hello
VERSION=0.1

GI_SCANNER=g-ir-scanner --warn-all --output=$(NAMESPACE)-$(VERSION).gir \
	   --namespace=$(NAMESPACE) --nsversion=$(VERSION)  \
	   --identifier-prefix=$(IDENTIFIER_PREFIX) --symbol-prefix=$(SYMBOL_PREFIX) \
	   --library-path="." --library=$(SONAME) --pkg=gobject-2.0 hello.h

GI_COMPILER=g-ir-compiler --output=$(NAMESPACE)-$(VERSION).typelib $(NAMESPACE)-$(VERSION).gir

GOBJECT_LIBS=$$(pkg-config --cflags --libs gobject-2.0)

all: lib$(SONAME).so ffi_test.js $(NAMESPACE)-$(VERSION).typelib

lib$(SONAME).so: hello.c hello.h
	gcc -std=c99 -O2 -fPIC -shared -I. $(GOBJECT_LIBS) -o $@ $<

$(NAMESPACE)-$(VERSION).typelib: lib$(SONAME).so
	$(GI_SCANNER)
	$(GI_COMPILER)

ffi_test.byte: js_impl.ml ffi_test.ml js_impl.mli
	ocamlfind ocamlc -package js_of_ocaml,js_of_ocaml-ppx -c js_impl.mli
	ocamlfind ocamlc -package js_of_ocaml,js_of_ocaml-ppx  \
	-linkpkg -o $@ js_impl.ml ffi_test.ml
	chmod 0644 $@

ffi_test.js: ffi_test.byte
	js_of_ocaml $<
	chmod 0644 $@

.PHONY: clean
clean:
	rm -f *.so *.gir *.typelib *.js *.cmi *.cmo *.byte
