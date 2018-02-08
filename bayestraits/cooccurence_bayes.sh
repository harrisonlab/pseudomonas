# Using BayesTraits in discrete mode to model coevolution of effector gene pairs. Using T3E dataset generated for genomics paper, with 102 P. syringae strain phylogenetic tree
# Analysis conducted in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/

# Splitting effector file up into pairwise comparisons (effectorA x effectorB)
for n in `seq 1 65` ; do
first=$(echo $n)
for i in `seq 2 65` ; do
second=$(echo $i)
cut -f1,$first,$second effectors.txt > ./files/"$n"_"$i" 
done 
done

# Rename each effector pair file
for file in * ; do
mv $file $(head -1 $file| sed s/"effector\t"//g | sed s/"\t"/"_"/g).txt2

# Remove single files generated when comparing effector with itself 

rm !(*_*)


# Make files compatible with bayestraits
# Currently working in data/scratch folder due to cluster problems 
for i in `seq 1 100`; do         
echo $i   
mkdir $i # For making directory within MLoutput folder
for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
cp "$EFFECTOR_SHORT".txt2 /data/scratch/hulinm/"$EFFECTOR_SHORT"_"$i".txt



for EFFECTOR in /data/scratch/hulinm/*.txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
echo $EFFECTOR_SHORT
cat $EFFECTOR | sed 1d > $EFFECTOR_SHORT # removing header line


for i in `seq 1 100`; do             
for EFFECTOR in /data/scratch/hulinm/*_"$i" ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
echo $EFFECTOR_FILE
mv $EFFECTOR_FILE "$EFFECTOR_FILE".txt


# Run BayestraitsV2


for i in `seq 3 50`; do
qsub /home/hulinm/git_repos/pseudomonas/bayestraits/sub_bayestraits_effectorsV2.sh $i /data/scratch/hulinm/cooccurence /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/tree.nex
done




