import sys 


inputfile = sys.argv[1]

f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    if len(cols) > 13 : continue
    if len(cols) < 5 : continue
    if float(cols[7]) < 0.2 and float(cols[8]) < 0.2: continue
    else: 
        print cols[0] + "\t" + cols[6] + "\t" + cols[7] + "\t" + cols[8] + "\t" + cols[10] + "\t" + cols[11]

exit
