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
# verify Gauss_vgs.gauss_theorem [@@auto];;
[✓] Theorem proved.
#
```


## OCaml development

```
$ make setup
$ make run
opam exec -- dune exec -- my_program
Enter a positive integer: 55

The sum of the integers from 1 to 55 is 1540
```

## Python bindings 
Upon each `make build`, verify that a `main_python.so` shared object file is created within the `src-python/wrapper` 
directory. This shared object file can be used to import as a python module. To do this, first add the python module to your
Python PATH. Then, running the `test.py` file should then call the extracted OCaml function from within Python. 


## Verification goals

```
$ make test-vgs
Testing `Verification Goals'.
This run has ID `DBD01C83-FB0E-4757-B500-F73F166EBB7F'.

  [OK]          Guass          0   Gauss' theorem holds.

Full test results in `./_build/default/test-vgs/_build/_tests/Verification Goals'.
Test Successful in 0.000s. 1 test run.
```

## Notes

Because `imandra-client` is distributed as bytecode, it requires a very specific
set of dependencies to function.

If those dependencies conflict with your app's requirements, you can set up
separate `opam` switches for your app and for running the `test-vgs`.
