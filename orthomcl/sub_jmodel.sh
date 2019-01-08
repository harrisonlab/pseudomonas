#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace

Usage='sub_jmodel.sh <phylip alignment file> <model_output'

i=$1
o=$2
java -jar /home/hulinm/local/src/jmodeltest-2.1.10/jModelTest.jar -d $i > $o


