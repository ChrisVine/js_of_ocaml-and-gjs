# 'make build' to build the program

# 'make run' to run locally the program so built

.PHONY: build
build:
	dune build --profile release

.PHONY: debug
debug:
	dune build --profile dev

.PHONY: run
run:
	@exec gjs _build/default/main.bc.js

.PHONY: clean
clean:
	rm -rf _build
