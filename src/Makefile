#Makefile for the compiler
#Compiles all executables for the compiler itself


srcdir = .
symdir = $(srcdir)/stable
parsedir = $(srcdir)/parser
maindir = $(srcdir)/main
bindir = $(srcdir)/bin
includedir = $(srcdir)/include
assemdir = $(srcdir)/assembly

CC = gcc
CFLAGS = -O1 -Wall --std=c99 -I$(includedir)
CLDFLAGS = -O1

all: parser stable generator

bindir: 
	mkdir bin

parser: include $(parsedir)/Makefile

generator: include $(assemdir)/Makefile

stable: 
	cd $(symdir)
	$(MAKE)

mv-parser: parser bindir
	@echo "Creating directory structure"
	mv $(parsedir)/cmm $(bindir)
	mv $(parsedir)/*.h $(includedir)

clean: 
	@echo "Removing object files"
	@cd $(parsedir) && $(MAKE) clean
	@cd $(symdir) && $(MAKE) clean

realclean:
	@echo "Deleting all compiled files"
	@cd $(parsedir) && $(MAKE) realclean
	@cd $(symdir) && $(MAKE) realclean
	@rm -R $(bindir)

.PHONY: parser stable clean realclean
