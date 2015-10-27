#Parser Makefile

CC = gcc
CFLAGS = -Wall --std=c99 -O3 -flto

all: parser

parser: objs
	$(CC) $(CFLAGS) grammar.tab.o lex.yy.o parser.o -o cmm	

objs: bison flex parser.c
	$(CC) -c $(CFLAGS) grammar.tab.c lex.yy.c parser.c

bison: grammar.y
	bison -d -t grammar.y

flex: lex.l
	flex lex.l

clean: 
	rm *.o grammar.tab.h grammar.tab.c lex.yy.c cmm
