#!/usr/bin/python

import sys

f1=sys.argv[1]
f2=sys.argv[2]
f3=sys.argv[3]

sourcefile=open(f1)

with open(f2, 'r') as keyfile:
    keys = keyfile.read().split("\t")[0]
 
with open(f3, 'w') as outfile:
    for line in sourcefile:
        if line.split('\t'):
            if line.split('\t')[1] in keys:
                outfile.write(line.split('\t')[1] + "\t" + line.split('\t')[2])
outfile.close()
