

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]
outputfile = sys.argv[2]


#open both files
f = open(inputfile)
o = open(outputfile, 'wb' )

for line in f:
    cols = line.strip().split(",")
    if cols[1] == "0" and cols[2] == "0" and cols[3] == "1" and  cols[4] == "0":
        o.write("pss only"  + '\t' + cols[0] + "\n")  
exit
			




