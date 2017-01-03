#!/usr/bin/python

'''
see documentation for module re at:
https://docs.python.org/2/library/re.html
'''

import re,sys
from rjv.fasta import *

inp = sys.argv[1]

pattern = 'CATTTACAACCAGTAGACTCCGCTTCC'

#for each sequence in the fasta file
for fa in next_fasta(inp):
    #for each match found
    for match in re.finditer(pattern,fa['seq']):
        print 'match=',match.group(0)
        print 'start=',match.start(0)
        print 'end=',match.end(0)

