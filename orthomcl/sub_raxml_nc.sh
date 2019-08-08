#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_raxml.sh <phylip alignment file>'

i=$1
o=$2
m=$3
raxmlHPC-AVX -s $i -n $o -m GTRGAMMA -f a ­­$m -x $RANDOM -N 100 ­I autoMRE -p 12345 

