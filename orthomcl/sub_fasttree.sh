#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 3
#$ -l virtual_free=3G
#$ -l h=blacklace03.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_fasttree.sh <phylip alignment file> <output>'

i=$1
o=$2
/home/hulinm/local/src/FastTree $i > $o

