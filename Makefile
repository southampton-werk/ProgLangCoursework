# 
# Rules for compiling and linking the typechecker/evaluator
#
# Type
#   make         to rebuild the executable file sdlc
#   make clean   to remove all intermediate and temporary files
#   make depend  to rebuild the intermodule dependency graph that is used
#                  by make to determine which order to schedule 
#	           compilations.  You should not need to do this unless
#                  you add new modules or new dependencies between 
#                  existing modules.  (The graph is stored in the file
#                  .depend)

# These are the object files needed to rebuild the main executable file
#
OBJS =   sdlparser.cmo sdllexer.cmo path.cmo main.cmo

# Files that need to be generated from other files
DEPEND += sdllexer.ml sdlparser.ml 

COMMONOBJS = str.cma

# When "make" is invoked with no arguments, we build an executable 
# typechecker, after building everything that it depends on
all: $(DEPEND) $(OBJS) sdlc

# Include an automatically generated list of dependencies between source files
include .depend

# Build an executable typechecker
sdlc: $(OBJS) main.cmo 
	@echo Linking $@
	ocamlc -o $@ $(COMMONOBJS) $(OBJS) 

# Compile an ML module interface
%.cmi : %.mli
	ocamlc -c $<

# Compile an ML module implementation
%.cmo : %.ml
	ocamlc -c $<

# Generate ML files from a parser definition file
sdlparser.ml sdlparser.mli: sdlparser.mly
	@rm -f sdlparser.ml sdlparser.mli
	ocamlyacc -v sdlparser.mly
	@chmod -w sdlparser.ml sdlparser.mli

# Generate ML files from a lexer definition file
%.ml %.mli: %.mll
	@rm -f $@
	ocamllex $<
	@chmod -w $@

# Clean up the directory
clean::
	rm -rf sdllexer.ml sdlparser.ml sdlparser.mli *.o *.cmo *.cmi sdlparser.output \
	   sdlc TAGS *~ 

# Rebuild intermodule dependencies
depend:: $(DEPEND) 
	ocamldep $(INCLUDE) *.mli *.ml > .depend

# 
