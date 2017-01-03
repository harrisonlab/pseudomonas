#!/usr/bin/env python

"""
blast2gff.py [options] <blast file>
"""

import sys
from optparse import OptionParser
from blast import BlastFile
import gff


usage = "%prog [options] <blast file>"
parser = OptionParser(usage=usage)
parser.add_option(
    "-s", "--source", 
    dest="source",
    help="GFF source (Default: match)", 
    default='match')
parser.add_option(
    "-n", "--note", 
    dest="note",
    help="Note",
    default=None)
options, args = parser.parse_args()


output = []
extrema = []
scores = []
for hsp in BlastFile(args[0]):
    tokens = hsp.queryId.split('|')
    if len(tokens)>4:
        name = tokens[3]
    else:
        name = hsp.queryId
    
    g = gff.Feature(
        reference=hsp.subjectId.split(':')[0],
        source=options.source,
        type='HSP',
        start=hsp.sStart,
        end=hsp.sEnd,
        score=hsp.bitScore,
        strand=hsp.strand(),
        group='Match %s ; Evalue %g' % (name, hsp.eValue)
    )
    if options.note:
        g.group += ' ; Note "%s"' % options.note
    
    output.append(g)
    extrema.append(g.start)
    extrema.append(g.end)
    scores.append(hsp.bitScore)

output.sort(key=lambda x: x.start)
if output:
    g = output[0]
    match = gff.Feature(
        reference=g.reference,
        source=options.source,
        type='match',
        start=min(extrema),
        end=max(extrema),
        score=sum(scores),
        strand=g.strand,
        group='Match %s' % name
    )
    if options.note:
        match.group += ' ; Note "%s"' % options.note
    output.insert(0,match)

for g in output:
    print g


