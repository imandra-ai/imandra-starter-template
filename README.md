# Imandra Starter Template

This repository contains a suggested layout for an Imandra project to support the following workflows:

* Developing a pure-IML model with the Imandra Commander REPL.
* Developing an OCaml program which uses the pure model directly, using `dune` to compile a fast native executable.
* An automated test runner to run verification goals over the IML model, suitable for CI/CD.

## Prerequisites

- The [`opam` package manager](https://opam.ocaml.org/).


## Project layout

* `./src-iml/` contains pure IML (Imandra Modelling Langauge - a subset of OCaml) code. All the code to be reasoned about should go here.
* `./src-ocaml/` contains any OCaml code. This could be your CLI tool, web server, etc. The code here can use the model code defined in `./src-iml/`.
* `./test-vgs/` contains the automated script for running verification goals.


## Model development with Imandra

```
$ cd src-iml
$ imandra-repl
...
# #use "load.iml";;
...
# Gauss.sum_integers_up_to 10;;
- : Z.t = 55
# verify Gauss.gauss_theorem [@@auto];;
[✓] Theorem proved.
#
```


## OCaml development

```
$ make setup
$ make run
```

## Verification goals

```
$ make test
```

## Notes

Because `imandra-client` is distributed as bytecode, it requires a very specific
set of dependencies to function.

If those dependencies conflict with your app's requirements, you can set up
separate `opam` switches for your app and for running the `test-vgs`.
