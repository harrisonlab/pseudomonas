#!/usr/bin/python

import sys

# A script to edit the hrp box motif output for all known effectors of a genome so that the start and end are correct in order to compare the file with the hrp-box locations for the whole genome
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split(" ")
    start = int(cols[1])+int(cols[4])
    end = int(cols[1])+int(cols[5])
    print cols[0] + ' ' + cols[3] + ' ' + str(start) + ' ' + str(end)
exit
			




