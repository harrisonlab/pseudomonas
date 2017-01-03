

import sys

#read the input and output filename from the command line
#make sure you get these the right way round, or the script will
#DELETE the input file!!

inputfile = sys.argv[1]
outfile = sys.argv[2]

#open both files

searchquery = '> gi'


with open(inputfile) as f1:
    with open(outfile, 'a') as f2:
        header = f1.name
#        f2.write(header)
        lines = f1.readlines()
        for i, line in enumerate(lines):
            if line.startswith(searchquery):
                f2.write(header)             
                f2.write(line)
                f2.write(lines[i + 1])


#for i, line in enumerate(lines):
 #   cols = line.strip().split("|")
  #  if len(cols) < 3: continue
   # if cols[0] == '> gi':
    #    n.write(line)
#        n.write(likes[i+1]

#for line in f:
 #   cols = line.strip().split("|")
  #  if len(cols) < 3: continue
   # if cols[0] == '> gi':
    #    n.write(line) 
			




