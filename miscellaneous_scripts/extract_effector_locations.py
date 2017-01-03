

import sys

# Script to extract locations of effectors from file to be used to get the sequences from genome
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")    
    if cols[9] == "1":
        cols10 = str(int(cols[10])-1)
        print cols[0]+ "\t" + cols[4] + "\t" + cols10 + "\t" + cols[11] # Account for 1-0 problem in python to get ATG rather than TG
    else:
        print cols[0]+"_RC" + "\t" + cols[4] + "\t" + cols[10] + "\t" + cols[11]
exit
			




