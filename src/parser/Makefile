#Parser Makefile

CC = gcc
CFLAGS = -Wall --std=gnu99 -O0 -g -flto
LDFLAGS = -O0 -flto
INC = -I../include
casdir = ../assembly
stdir = ../stable
sources = grammar.tab.c lex.yy.c parser.c $(casdir)/caswriter.c $(stdir)/stable.c $(casdir)/regs.c $(casdir)/x86_gen.c

all: parser

parser: objs
	$(CC) $(LDFLAGS) ./*.o -o cmm	

objs: bison flex $(sources)
	$(CC) -c $(INC) $(CFLAGS) $(sources)

bison: grammar.y
	bison -d -t grammar.y

flex: lex.l
	flex lex.l

clean: 
	rm *.o 

realclean: 
	rm *.o grammar.tab.h grammar.tab.c lex.yy.c cmm
