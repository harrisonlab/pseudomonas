import sys

inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    print cols[0] + "\t" + "tblastn" + "\t" + "match" + "\t" + cols[6] + "\t" + cols[7] + "\t" + cols[10] + "\t" + "+" + "\t" + "1" + "\t" + cols[1]
exit
