

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    cols3e = int(cols[3])-501 
    if int(cols3e) < 0:
        cols3e = 0
    cols4e = int(cols[4])+500  
    print cols[0]+':'+str(cols3e)+'-'+str(cols4e)+'\t'+cols[8] 
exit
			




