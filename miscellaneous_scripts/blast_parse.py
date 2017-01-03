import sys
import Bio

inputfile = sys.argv[1]
outfile = sys.argv[2]


result_handle = open(inputfile)
o=open(outfile, 'wb')


#header = "IS" +  "\t" + "e value" + "\t" + "hit_start" + "\t" + "hit_end" + "\n"

#o.write(header)

from Bio.Blast import NCBIStandalone
blast_parser = NCBIStandalone.BlastParser()
blast_record = blast_parser.parse(result_handle)


E_VALUE_THRESH = 0.04
for alignment in blast_record.alignments:
    for hsp in alignment.hsps:
        if hsp.expect < E_VALUE_THRESH:
            o.write(alignment.title + "\t" +  str(hsp.expect) + "\n")
