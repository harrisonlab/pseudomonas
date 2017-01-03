

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]

#open both files
f = open(inputfile)
#"header" = "IS"  + "\t" + "Seq_len"  + "\t" + "No.hits"  + "\t" + "Hit"  + "\t" + "E.value"  + "\t" + "Hit_len"  + "\t" + "Per_len"  + "\t" + "Per_ID"  + "\t" + "Strand"  + "\t" + "Start"  + "\t" + "End"
#print "header"

for line in f:
    cols = line.strip().split("\t")

    if line.startswith('12345ID'): continue
    if len(cols) < 8: continue
    cols7 = int(cols[7])
    cols8 = int(cols[8])
    if cols7 >= 80 and cols8 >= 80:
        print  cols[0] + "\t" + cols[3] + "\t" + cols[4] + "\t" + cols[5] + "\t" + cols[6] + "\t" + cols[7] + "\t" + cols[8] + "\t" + cols[9] + "\t" + cols[10] + "\t" + cols[11]
exit
			




