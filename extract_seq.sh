#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace02.blacklace|blacklace03.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='extract_seq.sh <input fasta> <locations> <output file>'

i=$1
l=$2
o=$3
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_seqs2.py $i $l $o 

