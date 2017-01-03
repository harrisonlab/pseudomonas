import sys 


input = sys.argv[1]

f = open(input)

for line in f:
    cols = line.strip().split("\t")
    if float(cols[0]) >= 90 :
        print cols[1]
exit
