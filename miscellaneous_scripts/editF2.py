


import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!
inputfile = sys.argv[1]

#open both files
f = open(inputfile)


for line in f:
    cols = line.strip().split("\t")
    new_start=int(cols[1])-501  
    new_start2=str(new_start)
    new_end=int(cols[2])+500   
    new_end2=str(new_end)
    if int(new_start2) < 0: 
         new_start2 = "0"
    print cols[0] + "\t" +  new_start2  + "\t" +  new_end2

exit
			




