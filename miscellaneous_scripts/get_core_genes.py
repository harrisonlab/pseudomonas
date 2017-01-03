#!/usr/bin/python
import sys
import argparse

input = sys.argv[1]

f = open(input)


#Search for strains within each orthogroup and count no. of strains per OG
for line in f:
    cols = line.strip().split("\t") 
    if int(cols[1]) >= 102 :
        print cols[0]   
