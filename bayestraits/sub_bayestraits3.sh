#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 1
#$ -l virtual_free=1G
#$ -l h=blacklace06.blacklace|blacklace07.blacklace|blacklace08.blacklace|blacklace09.blacklace|blacklace10.blacklace

Usage='sub_bayestraitsV3_test.sh <no_replicates> <tree> <trait_file> <directory>'

i=$1
tree=$2
file=$3
d=$4

file_short=$(basename $file)

# Running of bayestraits with phylogenetic tree and effector file for discrete independant analysis


COMMANDS=/$d/i_commands

/home/hulinm/local/src/BayesTraitsV3.0.1-Linux/BayesTraitsV3 /$d/$tree /$d/txt_files/$file </$d/$COMMANDS


mv /$d/txt_files/"$file_short".Log.txt /$d/output/"$file_short"_ind
mv /$d/txt_files/"$file_short".Stones.txt /$d/output/"$file_short"_ind_stones
mv /$d/txt_files/"$file_short".Schedule.txt /$d/output/"$file_short"_ind_schedule


# Running of bayestraits with phylogenetic tree and effector file for discrete dependant analysis

COMMANDS=/$d/d_commands

/home/hulinm/local/src/BayesTraitsV3.0.1-Linux/BayesTraitsV3 /$d/$tree /$d/txt_files/$file </$d/$COMMANDS

mv /$d/txt_files/"$file_short".Log.txt /$d/output/"$file_short"_dep
mv /$d/txt_files/"$file_short".Stones.txt /$d/output/"$file_short"_dep_stones
mv /$d/txt_files/"$file_short".Schedule.txt /$d/output/"$file_short"_dep_schedule

# Running of bayestraits with phylogenetic tree and effector file for discrete dependant analysis

COMMANDS=./cv_commands

/home/hulinm/local/src/BayesTraitsV3.0.1-Linux/BayesTraitsV3 /$d/$tree /$d/txt_files/$file </$d/$COMMANDS

mv /$d/txt_files/"$file_short".Log.txt /$d/output/"$file_short"_cv
mv /$d/txt_files/"$file_short".Stones.txt /$d/output/"$file_short"_cv_stones
mv /$d/txt_files/"$file_short".Schedule.txt /$d/output/"$file_short"_cv_schedule