

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
    if cols[1] == "1" or cols[2] == "1" or cols[3] == "1" or cols[4] == "1" or cols[5] == "1" or cols[6] == "1" or cols[7] == "1" or cols[8] == "1" or cols[9] == "1" or cols[10] == "1" or cols[11] == "1" or cols[12] == "1" or cols[13] == "1" or cols[14] == "1" or cols[15] == "1" or cols[16] == "1" or cols[17] == "1" or cols[18] == "1" or cols[19] == "1" or cols[20] == "1" or cols[21] == "1" or cols[22] == "1" or cols[23] == "1" or cols[24] == "1" or cols[25] == "1" or cols[26] == "1" or cols[27] == "1" or cols[28] == "1" or cols[29] == "1" or cols[30] == "1"  : 
        o.write(cols[0]+ "\t" + "1" + "\n")
    if cols[1] == "0" and cols[2] == "0" and cols[3] == "0" and cols[4] == "0" and cols[5] == "0" and cols[6] == "0" and cols[7] == "0" and cols[8] == "0" and  cols[9] == "0" and cols[10] == "0" and cols[11] == "0" and cols[12] == "0" and cols[13] == "0" and cols[14] == "0" and cols[15] == "0" and cols[16] == "0" and cols[17] == "0" and cols[18] == "0" and cols[19] == "0" and cols[20] == "0" and cols[21] == "0" and cols[22] == "0" and cols[23] == "0" and cols[24] == "0" and cols[25] == "0" and cols[26] == "0" and cols[27] == "0" and cols[28] == "0" and cols[29] == "0" and cols[30] == "0" :  
        o.write(cols[0]+ "\t" + "0" + "\n")
exit
			




