import sys

inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    if len(cols) < 5: continue
    if line.startswith("ID"): continue
    if float(cols[7]) < 0.7: continue
    if float(cols[8]) < 0.7: continue 
    else:
        print cols[4] + "\t" + "tblastn" + "\t" + "match" + "\t" + cols[10] + "\t" + cols[11] + "\t" + cols[5] + "\t" + cols[9] + "\t" + "1" + "\t" + cols[0]
exit
