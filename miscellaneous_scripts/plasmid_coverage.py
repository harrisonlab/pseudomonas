

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)

average = 0

for line in f:
    cols = line.strip().split('\t')
    if cols[0] == 'control':
        average +=  float(cols[2])



f.seek(0)

average= average/4

for line in f:
    cols = line.strip().split('\t')
    if len(cols) < 3: continue
    if cols[0] == 'control':
        print cols[0] + '\t' +  str(average) + '\t' + str(float(average)/float(average)) 
    else: 
        print cols[0] + '\t' + cols[2] +  '\t' + str(float(cols[2])/float(average)) 

f.close()


		




