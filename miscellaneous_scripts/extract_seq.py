import sys


gene_locations = sys.argv[1]
fasta = sys.argv[2]
output = sys.argv[3]


f2 = open(gene_locations)
f1 = open(fasta)
f3 = open(output)

AI_DICT = {}
for line in f2:
    AI_DICT[line[:-1]] = 1

skip = 0
for line in f1:
    if line[0] == '>':
        accessorIDWithArrow = line[0]
        accessorID = accessorIDWithArrow[1:-1]
        # print accessorID
        if accessorID in AI_DICT:
            f3.write(line)
            skip = 0
        else:
            skip = 1
    else:
        if not skip:
            f3.write(line)

f1.close()
f2.close()
f3.close()
