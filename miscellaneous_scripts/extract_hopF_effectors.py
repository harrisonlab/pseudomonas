import sys 

inputfile = sys.argv[1]
output = sys.argv[2]

f = open(inputfile)
f2 = open(output, 'w')


for line in f:
    cols = line.strip().split("\t")
    if len(cols) <= 4 : continue
    
    if line.startswith("ID"): continue
    if float(cols[7]) < 0.6 and float(cols[8]) < 0.4 or float(cols[7]) >= 1.01: continue
    else: 
        f2.write(cols[0] + "\t" + cols[4] + "\t" + cols[10] + "\t" + cols[11] + "\t" + cols[7] + "\t" + cols[8] + "\n") 
f2.close()
exit
