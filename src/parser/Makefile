#Parser Makefile

CC = gcc
CFLAGS = -Wall --std=gnu99 -O3 -flto
LDFLAGS = -O3 -flto
INC = -I../include
casdir = ../assembly
stdir = ../stable
sources = grammar.tab.c lex.yy.c parser.c $(casdir)/caswriter.c $(stdir)/stable.c $(casdir)/regs.c

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
