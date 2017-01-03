import sys 

##f = open("9646_effectors_blast.csv")

inputfile = sys.argv[1]

f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    if len(cols) < 3: continue
    if line.startswith('#'): continue
    if line.startswith('gi'): continue
    if line.startswith('CDS_POSITION'): continue
    else: 
        print "    "+"Misc"+"		     "+cols[0]+".."+cols[1]+"\n"+"                     "+"/note="+'"'+cols[2]+'"'    

exit
