all: gtk4.js

gtk4.byte: gtk4.ml
	ocamlfind ocamlc -package js_of_ocaml,js_of_ocaml-ppx  \
	-linkpkg -o $@ $<
	chmod 0644 $@

gtk4.js: gtk4.byte
	js_of_ocaml --custom-header="#!/usr/bin/env gjs" $<
	chmod 0755 $@

.PHONY: clean
clean:
	rm -rf *.js *.cmi *.cmo *.byte
