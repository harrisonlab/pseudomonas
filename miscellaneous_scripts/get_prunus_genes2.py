

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, and the script will
#DELETE the input file!!

inputfile = sys.argv[1]
outputfile = sys.argv[2]


#open both files
f = open(inputfile)
o = open(outputfile, 'wb' )

for line in f:
    cols = line.strip().split("\t")
    if cols[1] == "1" and  cols[2] == "1" and cols[3] == "1" and cols[4] == "0":   
        o.write(cols[0] + "\n")
    if cols[1] == "1" and cols[2] == "1" and cols[3] == "0" and cols[4] == "0": 
        o.write(cols[0] + "\n")
    if cols[1] == "1" and cols[2] == "0" and cols[3] == "1" and cols[4] == "0":
        o.write(cols[0] + "\n")  
    if cols[1] == "0" and cols[2] == "1" and cols[3] == "1" and cols[4] == "0":
        o.write(cols[0] + "\n")     
    if cols[1] == "1" and cols[2] == "0" and cols[3] == "0" and cols[4] == "0":
        o.write(cols[0] + "\n")  
    if cols[1] == "0" and cols[2] == "1" and cols[3] == "0" and cols[4] == "0":
        o.write(cols[0] + "\n")  
    if cols[1] == "0" and cols[2] == "0" and cols[3] == "1" and cols[4] == "0":
        o.write(cols[0] + "\n")  
exit
			




