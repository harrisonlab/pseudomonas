

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]
namelist = sys.argv[2]




#open both files
f = open(inputfile)

names = {}
with open(namelist) as f1:
    for line in f1:
        name = line.strip()
        names[name] = True

for i,line in enumerate(f):
    cols = line.strip().split(" ")
    name = cols[0]
#    print name        
    if not name in names: continue    
    else:
        print line    
exit
			




