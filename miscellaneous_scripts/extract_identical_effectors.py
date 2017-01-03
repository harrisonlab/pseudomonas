import sys 

inputfile = sys.argv[1]
output = sys.argv[2]

f = open(inputfile)
f2 = open(output, 'w')


for line in f:
    cols = line.strip().split("\t")
    if len(cols) <= 4 : continue
    if line.startswith("ID"): continue
    if cols[0] == cols[4] : continue 
    if str(cols[5]) >= 0.00000000000000000002 :
        f2.write(line)  
f2.close()
exit
