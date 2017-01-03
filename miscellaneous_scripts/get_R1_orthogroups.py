

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]


#open both files
f = open(inputfile)

for line in f:
    cols = line.strip().split("\t")
    if line.startswith("orthogroup1"): 
        print line 
    if line.startswith("5244") or line.startswith("2341") or line.startswith("5269") or line.startswith("5300") or line.startswith("9629") or line.startswith("9657") or line.startswith("9326") or line.startswith("9646"): 
        print line
    else: continue 
exit
			




