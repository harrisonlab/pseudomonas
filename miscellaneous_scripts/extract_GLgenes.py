

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)

header = f.readline().strip().split("\t")

for line in f:
    #split into columns
    cols = line.strip("\n").split("\t")
    if float(cols[7]) <= 0.95: continue 
    if  cols[2] == "8" or cols[2] == "9" or cols[2] == "12" or cols[2] == "14" or cols[2] == "16" or cols[2] == "17" or cols[2] == "19" :
        print line
exit
			




