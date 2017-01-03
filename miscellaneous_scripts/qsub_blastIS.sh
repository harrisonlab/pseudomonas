#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace02.blacklace|blacklace03.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace


set -u
set -e
set -o pipefail

Usage='qsub_blastIS.sh <protein_fasta> <is_db>' 

prot_fasta=$1
is_db=$2
prot_BN=$(basename $prot_fasta) 
prot_SHORT=$(echo $prot_BN | sed s/.fa//g) 
	echo $prot_SHORT
	
/home/hulinm/git_repos/tools/pathogen/blast/blast2csve5.pl $prot_fasta blastp $is_db 1  > ./blast/"$prot_SHORT".csv

