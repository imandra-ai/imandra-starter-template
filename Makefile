all: build test

_opam:
	opam switch create . --empty
	opam install -y ocaml-base-compiler.4.12.1
	opam switch set-base ocaml-base-compiler.4.12.1
	opam repo add imandra https://github.com/AestheticIntegration/opam-repository.git

setup: _opam
	opam install -y --deps-only --with-test --working-dir .

build:
	opam exec -- dune build

run:
	opam exec -- dune exec -- my_program

clean:
	opam exec -- dune clean


.PHONY: format
format:
	opam exec -- dune build @fmt --auto-promote

# Verification goals

IMANDRA_SWITCH ?= /usr/local/var/imandra
IMANDRA_SERVER ?= imandra_network_client
dune_imandra = OPAMSWITCH="$(IMANDRA_SWITCH)" IMANDRA_SERVER="$(IMANDRA_SERVER)" opam exec -- dune

.PHONY: test-vgs
test-vgs:
	$(dune_imandra) build @test-vgs/runtest

.PHONY: watch-vgs
watch-vgs:
	$(dune_imandra) build @test-vgs/runtest -w
