

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    line=line.strip()
    cols = line.strip().split("\t")
    if len(cols) < 5: continue  
    if line.startswith("ID"): continue
    cols8 = float(cols[8])
    if cols8 >= 0.7:
        print cols[0] 

			




