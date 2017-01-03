#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace02.blacklace|blacklace03.blacklace|blacklace04.blacklace|blacklace05.blacklace|blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_bayestraits.sh <no_replicates>'

i=$1

for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/effectors_extended/txt_files/*_"$i".txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)

echo $i


TREE=/home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/new_analysis/tree.nex
COMMANDS=/home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/new_analysis/independant_commands.txt

BayesTraitsV2 $TREE $EFFECTOR <$COMMANDS


mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/effectors_extended/txt_files/"$EFFECTOR_SHORT".txt.log.txt  /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/effectors_extended/MLoutput/"$i"/"$EFFECTOR_SHORT"_independant

# Running of bayestraits with phylogenetic tree and effector file for discrete dependant analysis

COMMANDS=/home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/new_analysis/dependant_commands.txt

BayesTraitsV2 $TREE $EFFECTOR <$COMMANDS
mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/effectors_extended/txt_files/"$EFFECTOR_SHORT".txt.log.txt  /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/effectors_extended/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant

done
done


