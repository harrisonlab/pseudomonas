import sys 


input = sys.argv[1]

f = open(input)

for line in f:
    cols = line.strip().split("\t")
    if float(cols[5]) <= 0.05:
        print cols[1]
exit
