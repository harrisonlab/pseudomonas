#!/usr/bin/python

import sys

f1=sys.argv[1]
f2=sys.argv[2]
f3=sys.argv[3]

sourcefile=open(f1)

with open(f2, 'r') as keyfile:
    keys = keyfile.read().split()

with open(f3, 'w') as outfile:
    for line in sourcefile:
        if line.split('\t'):
            if line.split('\t')[0] in keys:
                outfile.write(line)
outfile.close()
