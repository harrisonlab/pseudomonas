# Using BayesTraits in discrete mode to model coevolution of effector gene pairs. Using T3E dataset generated for genomics paper, with 102 P. syringae strain phylogenetic tree
# Analysis conducted in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/

# Make table unix compatible 
 tr '\r' '\n' < effector_table_all.txt > effectors.txt


# Splitting effector file up into pairwise comparisons (effectorA x effectorB)
for n in `seq 1 89` ; do
first=$(echo $n)
for i in `seq 2 89` ; do
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

for i in `seq 1 100`; do         
echo $i   
#mkdir $i # For making directory within MLoutput folder
for EFFECTOR in /data/scratch/hulinm/cooccurence_full/files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
cp "$EFFECTOR_SHORT".txt2 /data/scratch/hulinm/cooccurence_full/files/"$EFFECTOR_SHORT"_"$i".txt



for EFFECTOR in /data/scratch/hulinm/cooccurence_full/files/*.txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
echo $EFFECTOR_SHORT
cat $EFFECTOR | sed 1d > $EFFECTOR_SHORT # removing header line



for i in `seq 81 100`; do             
for EFFECTOR in /data/scratch/hulinm/cooccurence_full/files/*_"$i" ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
echo $EFFECTOR_FILE
mv $EFFECTOR_FILE "$EFFECTOR_FILE".txt
done
done

#### Run BayestraitsV2 ####


for i in `seq 1 50`; do
qsub /home/hulinm/git_repos/pseudomonas/bayestraits/sub_bayestraits_effectorsV2.sh $i /data/scratch/hulinm/cooccurence_full /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/tree.nex
done



#####

# Extract Lh value from two files and get ratio, then cat all into one big file for viewing

# First rename files to remove $i

for i in `seq 1 50`; do

for EFFECTOR in /data/scratch/hulinm/cooccurence/txt_files/*.txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
EFFECTOR_SHORTER=$(echo $EFFECTOR_FILE | sed s/_"$i"//g | sed s/".txt"//g )
echo $EFFECTOR_FILE

mv /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORTER"_dependant
mv /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT"_independant /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORTER"_independant
done
done


# 
for i in `seq 1 100`; do
qsub sub_rename_bayes.sh $i data/scratch/hulinm/cooccurence/MLoutput



# Then extract Lh values
for i in `seq 1 100`; do


for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
echo $EFFECTOR_SHORT
echo $i
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_Lh.py /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT"_independant /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".tmp
tr "\n" "\t" < /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".tmp > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".tmp2
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/create_LR.py /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".tmp2 > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR


## 
for i in `seq 1 100`; do
qsub sub_extractLH.sh $i 
done


# Remove temporary files
for i in `seq 1 100`; do
echo $i
rm /data/scratch/hulinm/cooccurence/MLoutput/"$i"/*.tmp /data/scratch/hulinm/cooccurence/MLoutput/"$i"/*.tmp2

# cat all LR into 1 file per run and add the effector names to the first column

for i in `seq 1 100`; do
echo $i
cat /data/scratch/hulinm/cooccurence/MLoutput/"$i"/*_LR > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/likelihood_ratios

mkfifo pipe1
mkfifo pipe2
cut -f1 /data/scratch/hulinm/cooccurence/list  > pipe1 & # In order to add effector names in first column
cut -f1,2,3 /data/scratch/hulinm/cooccurence/MLoutput/"$i"/likelihood_ratios > pipe2 &
paste pipe1 pipe2  > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$i"_likelihood_ratios.txt
rm pipe1 pipe2


# The cat all likelihood statistic files

cat /data/scratch/hulinm/cooccurence/MLoutput/*/*_likelihood_ratios.txt > /data/scratch/hulinm/cooccurence/likelihood_ratio_100_runs.txt



# Use R to calculate p-value statistic

LRs<-read.table("/data/scratch/hulinm/cooccurence/likelihood_ratio_100_runs.txt", col.names=,0)
attach(LRs)
LRs[,5]=pchisq(V4, 8-4, lower.tail=FALSE)
write.table(LRs, "LRs.tmp", sep="\t")

sed s/\"//g LRs.tmp > LRs2.tmp # Remove ""s
sed -i -e "1d" LRs2.tmp # Remove first line

# Get list of genes that had statistically significant p-value over 90% of the time (using python) then sort to get only those that occur 90+ times


python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/sort_by_pvalue.py LRs2.tmp > LRs3.tmp #Get list of genes with p.value <= 0.05
sort LRs3.tmp | uniq -c > LRs4.tmp #Get number of times gene appears (need to manually edit output to make tab delimited)
sed s/" "a/"\t"a/g LRs4.tmp | sed s/" "h/"\t"h/g | sed 's/^[ \t]*//;s/[ \t]*$//' | cut -f1,2 > LRs5.tmp
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/get_90_genes.py LRs5.tmp > statistically_sig_genes.txt #pull out only those that appear 90% or more times
rm *.tmp



#### Bayestraits rate analysis  ####

# Extract 8 different rates from the dependant file
for i in `seq 55 100`; do
for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
echo $EFFECTOR_SHORT
echo $i
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_rates_ML.py /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".rates.tmp
tr "\n" "\t" < /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".rates.tmp > /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".rates.tmp2


# Cat all of the rates for each effector into one file for analysis 

for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
for i in `seq 1 100`; do
echo $i
cat /data/scratch/hulinm/cooccurence/MLoutput/"$i"/"$EFFECTOR_SHORT".rates.tmp >> /data/scratch/hulinm/cooccurence/rates/"$EFFECTOR_SHORT"
done 

##


# Use R to get mean rates for each effector 
for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
echo $EFFECTOR
Rscript /home/hulinm/git_repos/tools/analysis/python_effector_scripts/get_rate_means.R "$EFFECTOR_SHORT" "$EFFECTOR_SHORT"_means
tail -n +2 "$EFFECTOR_SHORT"_means | cut -f2 -d " " | awk 'BEGIN { ORS = " " } { print }' | sed s/" "/"\t"/g | sed "$ s/$/\n/" > "$EFFECTOR_SHORT"_means_list


cat *list > effectors_rate_means
ls *means_list | sed s/_means_list//g > effectors

mkfifo pipe1
mkfifo pipe2
cut -f1 effectors > pipe1 & # In order to add effector names in first column
cut -f1,2,3,4,5,6,7,8 effectors_rate_means > pipe2 &
paste pipe1 pipe2  > effector_pair_rates.txt
rm pipe1 pipe2

# Make directory for those that were significantly associated 

for file in $(cat /data/scratch/hulinm/cooccurence/statistically_sig_genes.txt) ; do  
cp /data/scratch/hulinm/cooccurence/rates/"$file"  /data/scratch/hulinm/cooccurence/rates/sig_genes

# Generate boxplots of rates per gene pair using R

for file in /data/scratch/hulinm/cooccurence/rates/sig_genes/* ; do
echo $file
Rscript /data/scratch/hulinm/cooccurence/rates/make_boxplot.R $file 
done 

# Remove blank space in file name of pdf files 

rename "s/\s+//g" *



