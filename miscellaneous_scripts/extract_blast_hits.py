

import sys

inputfile = sys.argv[1]

f = open(inputfile)

for line in f:
    line=line.strip()
    cols = line.strip().split("\t")
    if line.startswith("ID"): continue   # Removes header line
    if len(cols) < 14 : continue	 # Removes those that only hit themselves  
    cols16 = float(cols[16])
    cols17 = float(cols[17])
    if cols16 >= 0.8 and cols17 >= 0.8 : # Get those two-member orthogroups thats hit another OG with >80% ID and QL 
        print cols[0] 			 # Print the OG to remove and the OG that it hit 
			




