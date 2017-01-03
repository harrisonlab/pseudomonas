#!/usr/bin/python

'''
read in data from a tab-separated-value file
only output those line where the marker name is in a list
'''

import sys

#read the input and output filename from the command line
inputfile = sys.argv[1]
namelist = sys.argv[2]

#store the names in a dictionary
names = {}
with open(namelist) as f1:
    for line in f1:
        name = line.strip()
        names[name] = True

#read in just the first line of the input file
with open(inputfile) as f2:
    for line in f2: 
        cols = line.strip().split("\t")
        name=cols[8]  
        if not name in names: continue
        print line     
