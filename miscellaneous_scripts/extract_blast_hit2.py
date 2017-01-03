

import sys

inputfile = sys.argv[1]

f = open(inputfile)

for line in f:
    line=line.strip()
    cols = line.strip().split("\t")
    if line.startswith("ID"): continue   # Removes header line
    if len(cols) < 14 : continue	 # Removes those that only hit themselves  
    else:  
        hit2 =  cols[0:4] +  cols[13:22] 			 # Print hit 2 information
	s1 = str(hit2)
	s2 = s1.replace('], [','\n')
	s3 = s2.replace('[','')
	s4 = s3.replace(']','')
	s5= s4.replace(',','\t')		
        s6= s5.replace("'","")
	print s6



