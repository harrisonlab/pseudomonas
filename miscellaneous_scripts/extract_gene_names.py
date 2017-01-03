#script to extract gene names from fasta file 

import sys

inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip()
    if line.startswith(">"):
        print cols
			




