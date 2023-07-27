(lang dune 2.9)

(name imandra-starter-template)

; (using fmt 1.2)

;; Use imandra-extract to generate ml files from iml.

(dialect
 (name imandra)
 (implementation
  (extension "iml")
  (preprocess
   (run imandra-extract %{input-file}))
  (format
   (run ocamlformat %{input-file})))
 (interface
  (extension "imli")))
