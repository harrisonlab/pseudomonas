import sys 

##f = open("9646_effectors_blast.csv")

inputfile = sys.argv[1]

f = open(inputfile)

for line in f:
    cols = line.strip().split("\t")
    if len(cols) <= 4: continue
    if float(cols[8]) < 0.4 and float(cols[7]) < 0.6 : continue
    else: 
        print line 
exit
