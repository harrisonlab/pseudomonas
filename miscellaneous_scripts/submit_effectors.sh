#!/bin/bash
# A script to submit all genomes (contigs.fasta) to blast2csv.pl for effector detection 

	

for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/SPADES/genomes/*.fasta ; do
	GENOME_FILE=$(basename $GENOME) 
	GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fasta//g)
	echo $GENOME_SHORT
	
	for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/family_effectors/fastafiles/*.fasta ; do
		EFFECTOR_FILE=$(basename $EFFECTOR)
		EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/_effectors.csv.fasta//g) 
		echo $EFFECTOR_SHORT
		mkdir -p $EFFECTOR_SHORT/output
			
		/home/hulinm/git_repos/tools/pathogen/blast/blast2csv_ql_dna.pl $EFFECTOR tblastn $GENOME 5 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effectors/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT"
	done
done 




