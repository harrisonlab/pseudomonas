# Script to pull out q values from bayestraits output

import sys 


infile = sys.argv[1]

f = open(infile)

for line in f: 
    cols = line.strip().split("\t")
    if line.startswith("1"): 
        print cols[2] + "\t" + cols[3] + "\t" + cols[4] + "\t" + cols[5] + "\t" + cols[6] + "\t" + cols[7] + "\t" + cols[8] + "\t" + cols[9]
    else: continue

exit
