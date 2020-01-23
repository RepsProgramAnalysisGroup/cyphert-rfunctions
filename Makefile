SOURCE_DIR = src
OCB_FLAGS = -use-ocamlfind -tag 'thread' -tag 'cclib(-lstdc++)' -package 'z3' -package 'str' -package 'unix' -package 'ocamlgraph' -I $(SOURCE_DIR)
OCB = ocamlbuild

all: rsat

clean: 
	$(OCB) -clean

rsat:
	$(OCB) $(OCB_FLAGS) rsat.native

