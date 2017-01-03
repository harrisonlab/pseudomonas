

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("_")
    cols6e = int(cols[6])-501 
    print cols[0]+'_'+cols[1]+'_'+cols[2]+'_'+cols[3]+'_'+cols[4]+'_'+cols[5] +  '\t' +str(cols6e)+ '\t' + cols[7] 
exit
			




