#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace02.blacklace|blacklace03.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_realphy.sh <output folder> <ref1> <ref2 <ref3>>'

o=$1
r1=$2
r2=$3
r3=$4

java -Xmx6000m -jar  /home/hulinm/local/src/RealPhy/RealPhy_v112.jar . $o -ref1 $r1 -ref2  $r2 -ref3  $r3 -merge 
