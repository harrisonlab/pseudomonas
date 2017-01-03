

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
    cols = line.strip().split("\t")
    if cols[1] == "1" or cols[2] == "1" or cols[3] == "1" or cols[4] == "1" or cols[5] == "1" : 
        o.write(cols[0]+ "\n")
exit
			




