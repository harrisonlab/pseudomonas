import sys
import Bio

inputfile = sys.argv[1]


from Bio.Blast import NCBIXML
blast = NCBIXML.parse(open(inputfile ,'rU'))
for record in blast:
    if record.alignments:
        # to print the "best" matches e-score
        print record.alignments[0].hsps[0].expect
