#!/bin/bash

###########
#Dillon Daudert
#11/4/2015
#
#This tests the syntax correctness of the contents of the /input folder, using the parser cmm
###########

echo "Testing syntax"

for filename in /home/dillon/C-minus-minus/src/test/func_test/input/*.cm; do
	echo ${filename}
	./cmm $filename > ${filename}.out
done

echo "Done testing syntax"
