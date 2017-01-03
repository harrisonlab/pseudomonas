import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]
outfile = sys.argv[2]

#open both files
f = open(inputfile)
n = open(outfile, 'w')

header = f.name
n.write(header + '\n')

for line in f:
    cols = line.strip().split("|")
    if "type III" in line:  
        n.write("hrp or effector" + '\n')
    else: 
        n.write(line)
exit




