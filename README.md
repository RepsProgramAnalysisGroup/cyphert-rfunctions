# cyphert-rfunctions
SAT solving with R-function

# Dependencies
 - Z3 with ocaml bindings

# Build
`ocamlfind ocamlopt -linkpkg -package Z3 str.cmxa unix.cmxa r_fun_test.ml`
