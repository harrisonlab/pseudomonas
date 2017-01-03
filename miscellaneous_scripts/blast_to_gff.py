#!/usr/bin/python

from sys import argv
import csv

"""
Converts minimal (3 field or more) tab separated BED/blast result files into minimal (9 field)
tab separated GFF files.
Usage: blast_to_gff.py <BED-infile> <GFF-outfile>
By: Alvar Almstedt
"""

class Table(object):

    def __init__(self, input_file_name, output_file_name):
        self.input_file_name = input_file_name
        self.output_file_name = output_file_name

# This method reads the input blast result. For best results, input the blast flags in the same order as in the
# "fieldnames" list beneath.
    def read_result(self):
        with open(self.input_file_name, 'r') as in_file:
            global fields
            fieldnames = ["header", "sstart", "sstop", "qheader","qlen", "qstart", "qstop", "sframe", "bitscore"]

            blast_reader = csv.DictReader(in_file, delimiter='\t', fieldnames=fieldnames)
            file_contents = []  # This will be the list where each value is dict created from one line of input
            for i in blast_reader:
                file_contents.append(i)
            fields = len(file_contents[0])  # set fields variable to number of fields read from input
            return file_contents

# This method writes the output gff file
    def write_gff(self):

        with open(self.output_file_name, 'w+') as gff_out:
            fieldnames = ["header", "blastresult", "hit", "start", "stop", "score", "orientation", "period", "ID"]
            read_results = self.read_result()
            gff_writer = csv.DictWriter(gff_out, delimiter='\t', fieldnames=fieldnames)
            iterator = 1
            for i in read_results:
                gff_writer.writerow({"header": str(i["header"]),
                                     "blastresult": "blast_result",
                                     "hit": "hit",
                                     "start": str(min(int(i["sstart"]), int(i["sstop"]))),
                                     "stop": str(max(int(i["sstart"]), int(i["sstop"]))),
                                     "score": ".",
                                     "orientation": self.orientation(i["sstart"], i["sstop"]),
                                     "period": ".",
                                     "ID": self.number_of_fields(fields, i, iterator)})
                iterator += 1

# This method sets the orientation of the sequence
    def orientation(self, start, end):
        if int(start) < int(end):
            return "+"
        return "-"

# This method creates a different comment field depending on how many fields the input file contains. Feel free to
# change the numbers if the output of field 9 looks weird.
    def number_of_fields(self, amount, i, iterator):
        if amount < 4:
            return "ID=%s;Parent=%s" % (i["header"] + "_%s" % iterator, i["header"])
        elif amount < 6:
            return "ID=%s;Parent=%s;QueryStart=%s;QueryStop=%s" % (i["header"] + "_%s" % iterator, i["header"],
                                                                   i["qstart"], i["qstop"])
        return "ID=%s;Parent=%s;QueryID=%s;QueryLength=%s;QueryStart=%s;QueryStop=%s;SubjectFrame=%s;Bitscore=%s" % \
                   (i["header"] + "_%s" % iterator, i["header"], i["qheader"], i["qlen"], i["qstart"], i["qstop"],
                    i["sframe"], i["bitscore"])

if __name__ == "__main__":
    infile = argv[1]
    outfile = argv[2]
    listprint = Table(infile, outfile)
    listprint.read_result()
    listprint.write_gff()
