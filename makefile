SOURCE_DIR = src
OCB_FLAGS = -use-ocamlfind -package 'Z3' -package 'str' -package 'unix' -I $(SOURCE_DIR)
OCB = ocamlbuild

all: native

clean: 
	$(OCB) -clean

native:
	$(OCB) $(OCB_FLAGS) rsat.native
