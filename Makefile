all: build test

_opam:
	opam switch create . --empty
	opam install -y ocaml-base-compiler.4.08.1
	opam switch set-base ocaml-base-compiler.4.08.1
	opam repo add imandra https://github.com/AestheticIntegration/opam-repository.git

setup: _opam
	opam install -y --deps-only --with-test --working-dir .

build:
	opam exec -- dune build

run:
	opam exec -- dune exec -- my_program

clean:
	opam exec -- dune clean

.PHONY: test
test:
	opam exec -- dune runtest test-vgs/

.PHONY: format
format:
	opam exec -- dune build @fmt --auto-promote
