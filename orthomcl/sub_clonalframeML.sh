#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_clonalframeML.sh <tree file> <xmfa file> <output name> <mean> <sd>'

tree=$1
xmfa=$2
out=$3
meanbranch=$4
sdbranch=$5


/home/hulinm/local/src/ClonalFrameML/src/ClonalFrameML $tree $xmfa $out -xmfa_file true -ignore_incomplete_sites true -emsim 100 -prior_mean "0.1 0.001 0.1 "$meanbranch"" -prior_sd "0.1 0.001 0.1 "$sdbranch""



