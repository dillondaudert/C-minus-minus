#Parser Makefile

CC = gcc
CFLAGS = -Wall --std=gnu99 -O3 -flto
LDFLAGS = -O3 -flto
INC = -I../assembly
casdir = ../assembly

all: parser

parser: objs
	$(CC) $(LDFLAGS) grammar.tab.o lex.yy.o parser.o caswriter.o -o cmm	

objs: bison flex parser.c $(casdir)/caswriter.c
	$(CC) -c $(INC) $(CFLAGS) $(casdir)/caswriter.c grammar.tab.c lex.yy.c parser.c 

bison: grammar.y
	bison -d -t grammar.y

flex: lex.l
	flex lex.l

clean: 
	rm *.o 

realclean: 
	rm *.o grammar.tab.h grammar.tab.c lex.yy.c cmm
