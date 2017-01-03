

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]
outputfile = sys.argv[2]

#open both files
f = open(inputfile, 'r')
fout = open(outputfile, 'w')

header= 'contig' + '\t' + 'length_kb' + '\t' + 'coverage' + '\n' 
fout.write(header) 
headercols=header.strip().split('\t')

for line in f:
    cols = line.strip().split("_")
    length2 = int(cols[3])/float(1000)
    fout.write(cols[1]+'\t'+str(length2)+'\t'+cols[5]+'\n') 

fout.close()
f.close()


			




