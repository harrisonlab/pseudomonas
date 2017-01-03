import sys 

##f = open("9646_effectors_blast.csv")

input = sys.argv[1]

f = open(input)

for line in f:
    cols = line.strip().split("\t")
    cols3 = float(cols[1]) - float(cols[0])
    cols4 = 2 * float(cols3)
    print cols[0] + "\t" + cols[1] + "\t" + str(cols4)
exit
