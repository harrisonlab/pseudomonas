import sys 

##f = open("9646_effectors_blast.csv")

inputfile = sys.argv[1]

f = open(inputfile)

header = f.readline()

for line in f:
    cols = line.strip().split("\t")
    if len(cols) <= 4: continue
    if float(cols[8]) < 0.4: continue
    else: 
        print cols[4] + "    "+"Misc"+"		     "+cols[10]+".."+cols[11]+"\n"+"                     "+"/note="+'"'+cols[0]+'"'    

exit
