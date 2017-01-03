\

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    if line.startswith( "ID"): continue
    if len(cols) < 6:
        print cols[0] + "\t" +  "0"
    else: 
        QL= str(float(cols[7]) * 100)
        ID= str(float(cols[8]) * 100) 
        print cols[0] + "\t" + cols[1] + "\t" + cols[2] + "\t" + cols[3] + "\t" + cols[4] + "\t" + cols[5] + "\t" + cols[6] + "\t" + QL + "\t" + ID  + "\t" + cols[9] + "\t" + cols[10] + "\t" + cols[11] + "\t" + cols[12]
exit
			




