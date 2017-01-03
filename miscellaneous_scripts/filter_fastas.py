

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]
outputfile = sys.argv[2]


#open both files
f = open(inputfile)
out = open(outputfile, 'w')


for line in f:
    if line.startswith(">"):
        out.write(line)
    else:  
        out.write(":" + line)

exit
			




