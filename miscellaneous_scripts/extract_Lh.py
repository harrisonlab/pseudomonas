import sys 

##f = open("9646_effectors_blast.csv")

independant = sys.argv[1]
dependant = sys.argv[2]

I = open(independant)
D = open(dependant)

for line in I:
    cols = line.strip().split("\t")
    if line.startswith("1"): 
        print cols[1]
    else: continue
I.close

for line in D: 
    cols = line.strip().split("\t")
    if line.startswith("1"): 
        print cols[1]
    else: continue
D.close 

exit
