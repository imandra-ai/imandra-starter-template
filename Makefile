IMANDRA_SWITCH=/usr/local/var/imandra

all: build test

_opam:
	opam switch create . --empty
	opam install -y ocaml-base-compiler.4.06.1
	opam switch set-base ocaml-base-compiler.4.06.1
	opam repo add imandra

setup: _opam
	opam install -y . --deps-only --working-dir

build:
	opam exec -- dune build

run:
	opam exec -- dune exec -- my_program

clean:
	opam exec -- dune clean

install-iml:
	opam exec --switch=$(IMANDRA_SWITCH) -- dune build @install
	opam exec --switch=$(IMANDRA_SWITCH) -- dune install

.PHONY: test
test:
	opam exec --switch=$(IMANDRA_SWITCH) -- dune runtest test-vgs/
