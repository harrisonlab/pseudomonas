#!/usr/bin/python
import sys 

from Bio import SeqIO
 
input = sys.argv[1]
output = sys.argv[2]

input_seq_iterator = SeqIO.parse(open(input, "rU"), "fasta")
short_seq_iterator = (record for record in input_seq_iterator \
                      if len(record.seq) > 500
)
 
output_handle = open(output, "w")
SeqIO.write(short_seq_iterator, output_handle, "fasta")
output_handle.close()
