

import sys


inputfile = sys.argv[1]

f = open(inputfile)



for line in f:
    if line.startswith('ProteinID'): continue

    cols = line.strip().split("\t")

    cols4 = int(cols[4])
    cols6 = int(cols[4]) + int(cols[6])
    cols7 = int(cols[4]) + int(cols[7]) 
    print cols[0] + "\t" + str(cols6) + "\t" +  str(cols7)
exit
			




