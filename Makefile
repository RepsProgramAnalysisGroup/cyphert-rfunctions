SOURCE_DIR = src
OCB_FLAGS = -use-ocamlfind -tag 'thread' -tag 'cclib(-lstdc++)' -package 'z3' -package 'str' -package 'unix' -package 'ocamlgraph' -I $(SOURCE_DIR)
OCB = ocamlbuild

all: rsatlosslist rsatloss

clean: 
	$(OCB) -clean

rsatloss:
	$(OCB) $(OCB_FLAGS) rsatLoss.native

rsatlosslist:
	$(OCB) $(OCB_FLAGS) rsatLossList.native
