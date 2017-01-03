#!/bin/bash
# A script to submit all blast2csv.pl output files (in csv format) to the blast_differentials_ql.sh script modified to allow redirection of output files into designated folders
# The script blast_differentials_ql.sh is modified to allow the query length threshold to be adjusted, meaning only hits with query_length percent over a designated threshold give a 1 in the final report
# The script then makes ones master csv file will all effectors and all genomes 

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/family_effectors/fastafiles/*.fasta ; do 
	EFFECTOR_FILE=$(basename $EFFECTOR)
	EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/_effectors.csv././g | sed s/.fasta//g) 	
	NEWSTRING=$(ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector_blast/effectors2/"$EFFECTOR_SHORT"/*_effectors.csv.fasta)
	echo $NEWSTRING
	/home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/blast/blast_differentials_ql.sh $NEWSTRING	
done

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/family_effectors/fastafiles/*.fasta ; do 
	EFFECTOR_FILE=$(basename $EFFECTOR)
	EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/_effectors.csv././g | sed s/.fasta//g) 	
	NEWSTRING=$(ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector_blast/effectors2/"$EFFECTOR_SHORT"/*_effectors.csv.fasta)
	cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector_blast/effectors2/output/"$EFFECTOR_SHORT"_ql/presence_tab.csv >> effectors.csv
done

#NEWSTRING=$(ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector_blast/effectors2/hopM1/*_effectors.csv.fasta)
#echo $NEWSTRING
#/home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/blast/blast_differentials_ql.sh $NEWSTRING


## additional genomes

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/family_effectors/fastafiles/*.fasta ; do 
	EFFECTOR_FILE=$(basename $EFFECTOR)
	EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/_effectors.csv././g | sed s/.fasta//g) 	
	NEWSTRING=$(ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector_blast/additional/effectors2/"$EFFECTOR_SHORT"/*_effectors.csv.fasta)
	echo $NEWSTRING
	/home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/blast/blast_differentials_ql2.sh $NEWSTRING	
done

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/family_effectors/fastafiles/*.fasta ; do 
	EFFECTOR_FILE=$(basename $EFFECTOR)
	EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/_effectors.csv././g | sed s/.fasta//g) 	
	cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector_blast/additional/effectors2/output/"$EFFECTOR_SHORT"_ql/presence_tab.csv >> additional_effectors.csv
done
	