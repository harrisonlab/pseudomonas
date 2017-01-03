#!/usr/bin/python

'''
This program builds 100Kb gff features of windows accross the genome
'''


#-----------------------------------------------------
# Step 1
# Import variables & load input files
#-----------------------------------------------------

import sys
import argparse
import re
import numpy
from sets import Set
from Bio import SeqIO

ap = argparse.ArgumentParser()
ap.add_argument('--genome',required=True,type=str,help='Assembly file')

conf = ap.parse_args()


#-----------------------------------------------------
# Step 2
# Identify the length and gene density of FoL chromosomes
#-----------------------------------------------------

genome_file = open(conf.genome, 'r')
for cur_record in SeqIO.parse(genome_file,"fasta"):
    seq_id = cur_record.id
    seq_len = len(cur_record.seq)
    i = 1
    interval_start = 1
    interval_stop = 10000
    while interval_stop <= seq_len:
        outline = "\t".join([str(seq_id), "window", "10kb_window", str(interval_start), str(interval_stop), ".", "+", ".", "ID=" + str(seq_id) + "_" + str(i) + ";"])
        print(outline)
        i += 1
        interval_start += 10000
        interval_stop += 10000
    outline = "\t".join([str(seq_id), "window", "10kb_window", str(interval_start), str(seq_len), ".", "+", ".", "ID=" + str(seq_id) + "_" + str(i) + ";"])
    print(outline)
