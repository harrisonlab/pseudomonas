#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 3
#$ -l virtual_free=3G
#$ -l h=blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_raxml.sh <phylip alignment file>'

i=$1
o=$2
og=$3
raxmlHPC-AVX -s $i -n $o -m PROTGAMMAJTT -f a -x $RANDOM -N 100 -p 12345 -o $og


