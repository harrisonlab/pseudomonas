from Bio import SeqIO
import sys

input = sys.argv[1]

for record in SeqIO.parse(input, "fasta"):
    print ">" +  record.id
    print record.seq.reverse_complement()
