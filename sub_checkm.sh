#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace06.blacklace

Usage='sub_checkM.sh <input directory> <output directory>'

i=$1
o=$2

/home/vicker/programs/checkm-v1.0.12/CheckM-1.0.12/bin/checkm lineage_wf -t 8 -x fa $i $o


