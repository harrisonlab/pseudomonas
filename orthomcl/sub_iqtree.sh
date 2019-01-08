#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -l virtual_free=4G
#$ -l h=blacklace03.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_iqtree.sh <phylip alignment file> <partition file> <outgroup name>'

i=$1
p=$2
o=$3
/home/hulinm/local/src/iqtree-1.6.8-Linux/bin/iqtree -s $i  -bb 1000 -spp $p -o $o

