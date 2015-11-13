#Makefile for the symbol table

INCL = ../include
CC = gcc
CFLAGS = -O1 -Wall --std=c99 
CLDFLAGS = -O1
sources = stable.c st_tester.c
objs = $(sources:.c=.o)

all: stable

stable: $(objs)
	$(CC) $(CLDFLAGS) -I$(INCL) $? -o $@

%.o: %.c $(INCL)/cmm.h $(INCL)/stable.h
	$(CC) $(CFLAGS) -c -I$(INCL) $<

clean: 
	rm *.o

realclean: 
	rm *.o stable

.PHONY: all clean realclean
