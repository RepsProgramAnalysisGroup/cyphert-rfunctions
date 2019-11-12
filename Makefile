SOURCE_DIR = src
OCB_FLAGS = -use-ocamlfind -package 'Z3' -package 'str' -package 'unix' -package 'ocamlgraph' -I $(SOURCE_DIR)
OCB = ocamlbuild

all: native

clean: 
	$(OCB) -clean

native:
	$(OCB) $(OCB_FLAGS) rsat.native

rsat2:
	$(OCB) $(OCB_FLAGS) rsat2.native

rsatloss:
	$(OCB) $(OCB_FLAGS) rsatLoss.native
