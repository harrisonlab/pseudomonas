

import sys


inputfile = sys.argv[1]

f = open(inputfile)

for line in f:
    cols = line.strip().split(" ")
    print  cols[1] + "\t" + cols[0] + "\t" + cols[2] 
exit
			




