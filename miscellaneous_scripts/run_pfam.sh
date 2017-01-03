#!/bin/bash

## This program scans an amino acid fasta file for pfam domains and outputs the results. Run from /home/hulinm/pfam3/

for FASTA in /home/hulinm/aa_files/*.fasta ; do
	FASTA_FILE=$(basename $FASTA) 
	GENOME_SHORT=$(echo $FASTA_FILE | sed s/_aa.fasta//g) 
	echo $GENOME_SHORT

perl -I /home/hulinm/pfam2/PfamScan/ /home/hulinm/pfam2/PfamScan/pfam_scan.pl -fasta $FASTA -dir /home/hulinm/pfam3 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/"$GENOME_SHORT"_pfam

## Next use regular expression searcher to pull out only those pfam matches associated with effector-like domains 

 python /home/hulinm/regexpr_pfam.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/"$GENOME_SHORT"_pfam  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/"$GENOME_SHORT"_pfam_effectors
 
 ## Next cut out the first column to get column IDs. Then remove blank lines
 
 cut -f1 -d ' ' /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/"$GENOME_SHORT"_pfam_effectors |  sed '/^$/d' > /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/"$GENOME_SHORT"_pfam_effectorsID
 
 ## Use this to pull out corresponding sequences from amino acid fasta file extract_seq.pl
 
 perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_seq.pl $FASTA /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/"$GENOME_SHORT"_pfam_effectorsID > /home/hulinm/pseudomonas_data/pseudomonas/analysis/pfam/output/candidates/"$GENOME_SHORT"_pfam_candidates
 
done 
 
