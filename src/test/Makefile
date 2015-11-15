#Makefile for the test runners ...

CC = gcc
CFLAGS = -g -Wall -Wextra -Werror -Wpointer-arith -Wcast-align -Wwrite-strings -Wswitch-default -Wunreachable-code -Winit-self -Wmissing-field-initializers -Wno-unknown-pragmas -Wundef

TARGET_BASE1=st_test
TARGET_EXTENSION=.out
TARGET1 = $(TARGET_BASE1)$(TARGET_EXTENSION) 
UNITY_ROOT = ./Unity
SRC_FILES1=$(UNITY_ROOT)/unity.c ../stable/stable.c ./test_stable.c ./test_runners/test_stable_runner.c
INC_DIRS=-I$(UNITY_ROOT) -I../include

all: default

default:
	$(CC) $(CFLAGS) $(INC_DIRS) $(SRC_FILES1) -o $(TARGET1)

clean: 
	rm st_test.out
