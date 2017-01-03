

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]


#open both files
f = open(inputfile)

row = []
for line in f:
    row.append(line.strip().split('\t'))
    cols = zip(*row)
    cols1 = cols[1]
    print type(cols[1])
#    def listsum(cols1):
 #       total = 0
  #      for i in (cols1):
   #         total = total + i 
    #    return total 
   # print(listsum(cols1))
			




