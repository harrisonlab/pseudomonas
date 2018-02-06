#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_bayestraits.sh <no_replicates> <directory> <tree>'

i=$1
d=$2
t=$3

for EFFECTOR in "$d"/txt_files/*_"$i".txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)

echo $i


COMMANDS=/home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/new_analysis/independant_commands.txt

BayesTraitsV2 $t $EFFECTOR <$COMMANDS


mv "$d"/txt_files/"$EFFECTOR_SHORT".txt.log.txt  "$d"/MLoutput/"$i"/"$EFFECTOR_SHORT"_independant

# Running of bayestraits with phylogenetic tree and effector file for discrete dependant analysis

COMMANDS=/home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/new_analysis/dependant_commands.txt

BayesTraitsV2 $t $EFFECTOR <$COMMANDS
mv "$d"/txt_files/"$EFFECTOR_SHORT".txt.log.txt  "$d"/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant

done
done


