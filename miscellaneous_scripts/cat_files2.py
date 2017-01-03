import glob
import sys

read_files = glob.glob("*.txt")

with open("resultfile", "wb") as outfile:
    for f in read_files:
            for line in f: 
		if "type III" not in line:
                outfile.write(f.read())
