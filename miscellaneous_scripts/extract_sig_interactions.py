

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)

#header = f.readline().strip().split("\t")

for line in f:
    #split into columns
    cols = line.strip("\n").split("=")
    if float(cols[1]) <= 0.01:
        print line
exit
			




