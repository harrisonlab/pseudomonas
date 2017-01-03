

import sys

inputfile = sys.argv[1]

f = open(inputfile)

for line in f:
    line=line.strip()
    cols = line.strip().split("\t")
    if line.startswith("ID"): continue   # Removes header line
    if len(cols) < 14 : continue	 # Removes those that only hit themselves  
    cols3 = float(cols[3])
    if cols3 > 1 : 
        print line 			 # Print the OG to remove and the OG that it hit 

			




