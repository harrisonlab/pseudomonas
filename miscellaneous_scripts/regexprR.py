#!/usr/bin/python

'''
see documentation for module re at:
https://docs.python.org/2/library/re.html
'''

import re,sys
sys.path.append('/home/hulinm/local/src')
from rjv.fasta import *

inp = sys.argv[1]
pattern2 = 'T[ATGC][ATGC]GTGG.{15,16}GGTTCC'

#read in just the first line of the input file

#for each sequence in the fasta file
for fa in next_fasta(inp):    
    #for each match found
	for match in re.finditer(pattern2,fa['seq']):
    		print fa['id'], match.group(0), match.start(0), match.end(0)

