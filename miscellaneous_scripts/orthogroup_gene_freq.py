#!/usr/bin/python
import sys
import argparse

input = sys.argv[1]
strains = sys.argv[2]

f = open(input)
d = open(strains)


#Generate dictionary
AI_DICT = {}
for line in d:
    AI_DICT[line[:-1]] = 1

#Search for strains within each orthogroup and count no. of strains per OG
for line in f:
    line = line.rstrip("\n")
    split_line = line.split(" ")
    orthogroup_id = split_line[0].replace(":", "")
    for isolate in AI_DICT.keys():
        num_genes = line.count((isolate))
        print orthogroup_id + "\t" + isolate + "\t" + str(num_genes)
