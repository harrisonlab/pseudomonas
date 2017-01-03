#!/usr/bin/python

import sys


sourcefile=open("leaf_genes_hrp_locations")

with open('leaf_genes_hrp_ID', 'r') as keyfile:
    keys = keyfile.read().split()

with open('output_hrp', 'w') as outfile:
    for line in sourcefile:
        if line.split(' '):
            if line.split(' ')[0] in keys:
                outfile.write(line)
outfile.close()
