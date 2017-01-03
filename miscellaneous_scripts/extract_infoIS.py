import sys 

##f = open("9646_effectors_blast.csv")

inputfile = sys.argv[1]

f = open(inputfile)

header = f.readline()

for line in f:
    cols = line.strip().split("\t")
    if float(cols[10]) <= 0.00001:
        print "    "+"Misc"+"		     "+cols[6]+".."+cols[7]+"\n"+"                     "+"/note="+'"'+cols[1]+'"'    
    
exit
