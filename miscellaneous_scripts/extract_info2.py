import sys 

##f = open("9646_effectors_blast.csv")

inputfile = sys.argv[1]

f = open(inputfile)

header = f.readline()

for line in f:
    cols = line.strip().split("\t")
    print "    "+"Misc"+"		     "+cols[1]+".."+cols[2]+"\n"+"                     "+"/note="+'"'+cols[0]+'"'    

exit
