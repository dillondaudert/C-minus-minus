#Makefile for the compiler
#Compiles all executables for the compiler itself

CC = gcc
CFLAGS = -O1 -Wall --std=c99 -I./include
CLDFLAGS = -O1

symdir = ./stable
parsedir = ./parser

all: parser stable

parser: 
	cd ./parser
	sh make

stable: ${symdir}/*.c
	cd ${symdir}
	sh make
