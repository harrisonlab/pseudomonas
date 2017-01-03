#!/usr/bin/python

import sys


sourcefile=open("leaf.gff3")

with open('leaf_genes_hrp_ID', 'r') as keyfile:
    keys = keyfile.read().split()

with open('output', 'w') as outfile:
    for line in sourcefile:
        if line.split('\t'):
            if line.split('\t')[0] in keys:
                outfile.write(line)
outfile.close()
