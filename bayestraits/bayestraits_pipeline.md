# Running of bayestraitsfinal/multiple_trees on all effectors for a phylogeny
Move effector table onto cluster and remove mac newline characters

 tr '\r' '\n' < effectors_bayes_red.txt > effectors.txt
 tr '\r' '\n' < orthogroups_table.txt > orthogroups.txt
 tr '\r' '\n' < effectors_families.txt > effectors.txt


# First cut the effector table into 1 file per effector


cut -f1,2,66 effectors.txt > ./txt_files/avrA.txt2
cut -f1,3,66  effectors.txt > ./txt_files/avrB.txt2
cut -f1,4,66  effectors.txt > ./txt_files/avrD1.txt2
cut -f1,5,66  effectors.txt > ./txt_files/avrE1.txt2
cut -f1,6,66  effectors.txt > ./txt_files/avrPto.txt2
cut -f1,7,66  effectors.txt > ./txt_files/avrRpm.txt2
cut -f1,8,66  effectors.txt > ./txt_files/avrRps4.txt2
cut -f1,9,66  effectors.txt > ./txt_files/avrRpt2.txt2
cut -f1,10,66  effectors.txt > ./txt_files/hopA1.txt2
cut -f1,11,66  effectors.txt > ./txt_files/hopAA.txt2
cut -f1,12,66  effectors.txt > ./txt_files/hopAB.txt2
cut -f1,13,66  effectors.txt > ./txt_files/hopAD.txt2
cut -f1,14,66  effectors.txt > ./txt_files/hopAE.txt2
cut -f1,15,66  effectors.txt > ./txt_files/hopAF.txt2
cut -f1,16,66  effectors.txt > ./txt_files/hopAG.txt2
cut -f1,17,66  effectors.txt > ./txt_files/hopAH.txt2
cut -f1,18,66  effectors.txt > ./txt_files/hopAI.txt2
cut -f1,19,66  effectors.txt > ./txt_files/hopAL.txt2
cut -f1,20,66  effectors.txt > ./txt_files/hopAM.txt2
cut -f1,21,66  effectors.txt > ./txt_files/hopAO.txt2
cut -f1,22,66  effectors.txt > ./txt_files/hopAQ.txt2
cut -f1,23,66  effectors.txt > ./txt_files/hopAR.txt2
cut -f1,24,66  effectors.txt > ./txt_files/hopAS.txt2
cut -f1,25,66  effectors.txt > ./txt_files/hopAT.txt2
cut -f1,26,66  effectors.txt > ./txt_files/hopAU.txt2
cut -f1,27,66  effectors.txt > ./txt_files/hopAV.txt2
cut -f1,28,66  effectors.txt > ./txt_files/hopAW.txt2
cut -f1,29,66  effectors.txt > ./txt_files/hopAX.txt2
cut -f1,30,66  effectors.txt > ./txt_files/hopAY.txt2
cut -f1,31,66  effectors.txt > ./txt_files/hopAZ.txt2
cut -f1,32,66  effectors.txt > ./txt_files/hopB.txt2
cut -f1,33,66  effectors.txt > ./txt_files/hopBA.txt2
cut -f1,34,66  effectors.txt > ./txt_files/hopBB.txt2
cut -f1,35,66  effectors.txt > ./txt_files/hopBC.txt2
cut -f1,36,66  effectors.txt > ./txt_files/hopBD.txt2
cut -f1,37,66  effectors.txt > ./txt_files/hopBE.txt2
cut -f1,38,66  effectors.txt > ./txt_files/hopBF.txt2
cut -f1,39,66  effectors.txt > ./txt_files/hopBG.txt2
cut -f1,40,66  effectors.txt > ./txt_files/hopBH.txt2
cut -f1,41,66  effectors.txt > ./txt_files/hopBI.txt2
cut -f1,42,66  effectors.txt > ./txt_files/hopBJ.txt2
cut -f1,43,66  effectors.txt > ./txt_files/hopBK.txt2
cut -f1,44,66  effectors.txt > ./txt_files/hopBL.txt2
cut -f1,45,66  effectors.txt > ./txt_files/hopC.txt2
cut -f1,46,66  effectors.txt > ./txt_files/hopD.txt2
cut -f1,47,66  effectors.txt > ./txt_files/hopE.txt2
cut -f1,48,66  effectors.txt > ./txt_files/hopF.txt2
cut -f1,49,66  effectors.txt > ./txt_files/hopG.txt2
cut -f1,50,66  effectors.txt > ./txt_files/hopH.txt2
cut -f1,51,66  effectors.txt > ./txt_files/hopI.txt2
cut -f1,52,66  effectors.txt > ./txt_files/hopK.txt2
cut -f1,53,66  effectors.txt > ./txt_files/hopM.txt2
cut -f1,54,66  effectors.txt > ./txt_files/hopN.txt2
cut -f1,55,66  effectors.txt > ./txt_files/hopO.txt2
cut -f1,56,66  effectors.txt > ./txt_files/hopQ.txt2
cut -f1,57,66  effectors.txt > ./txt_files/hopR.txt2
cut -f1,58,66  effectors.txt > ./txt_files/hopS.txt2
cut -f1,59,66  effectors.txt > ./txt_files/hopT.txt2
cut -f1,60,66  effectors.txt > ./txt_files/hopU.txt2
cut -f1,61,66  effectors.txt > ./txt_files/hopV.txt2
cut -f1,62,66  effectors.txt > ./txt_files/hopW.txt2
cut -f1,63,66  effectors.txt > ./txt_files/hopX.txt2
cut -f1,64,66  effectors.txt > ./txt_files/hopY.txt2
cut -f1,65,66  effectors.txt > ./txt_files/hopZ.txt2

rename effector files txt2 to avoid confusing program with *.txt

# Edit text files in ./txt_files folder to make compatible with bayestraits

for i in `seq 1 100`; do              # Run analysis 100 times
#mkdir $i
# Running of bayestraits with phylogenetic tree and effector file for discrete independant analysis

for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/txt_files/*.txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
#cp "$EFFECTOR_SHORT".txt2 "$EFFECTOR_SHORT"_"$i".txt
echo $EFFECTOR_SHORT
cat $EFFECTOR | sed 1d > $EFFECTOR_SHORT # removing header line


for i in `seq 1 100`; do              # Run analysis 100 times
for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/txt_files/*_"$i" ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
echo $EFFECTOR_FILE
#mv $EFFECTOR_FILE "$EFFECTOR_FILE".txt


# Submit to cluster in batches using qsub

for i in `seq 1 100`; do
qsub /home/hulinm/git_repos/pseudomonas/bayestraits/sub_bayestraits_effectorsV2.sh $i /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/boottree.nex
done


# Extract Lh value from two files and get ratio, then cat all into one big file for viewing

# First rename files to remove $i

for i in `seq 1 100`; do

for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/txt_files/*_"$i".txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
EFFECTOR_SHORTER=$(echo $EFFECTOR_FILE | sed s/_"$i"//g | sed s/".txt"//g )
echo $EFFECTOR_SHORT

mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORTER"_dependant
mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_independant /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORTER"_independant
done
done


# Then extract Lh values
for i in `seq 1 100`; do
for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/effector_files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
echo $EFFECTOR_SHORT
echo $i

mkfifo pipe1
mkfifo pipe2
tail -n +26 /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_independant | cut -f1,2  > pipe1 & # In order to add effector names in first column
tail -n +30 /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_dependant | cut -f2  > pipe2 &
paste pipe1 pipe2  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR.tmp
rm pipe1 pipe2
python  /home/hulinm/git_repos/tools/analysis/python_effector_scripts/create_LR2.py  /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR.tmp >  /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR



# Remove temporary files
for i in `seq 1 100`; do
rm /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/*.tmp 


# Chi-square test to see if significant difference between models. Get number of trees for which this gene was significantly associated with pathogenicity 
for i in `seq 1 100`; do
for EFFECTOR in /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/effector_files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
echo $EFFECTOR_SHORT
echo $i
Rscript /home/hulinm/git_repos/tools/analysis/python_effector_scripts/likelihood_bayes.R /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results

sed s/\"//g  /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results | cut -d " " -f2,3,4,5,6 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results.tmp # Remove ""s
sed -i -e "1d" /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results.tmp # Remove first line

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/sort_by_pvalue2.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results.tmp > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results.tmp2 #Get list of genes with p.value <= 0.05
sort /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results.tmp2 | uniq -c | wc -l  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$EFFECTOR_SHORT"_LR_results.tmp3 #Get number of times gene appears (need to manually edit output to make tab delimited)




# cat all LR into 1 file per run and add the effector names to the first column

for i in `seq 1 100`; do
cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/*_LR_results.tmp3 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/likelihood_ratios

mkfifo pipe1
mkfifo pipe2
cut -f1 /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/effector_list  > pipe1 & # In order to add effector names in first column
cut -f1 /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/likelihood_ratios > pipe2 &
paste pipe1 pipe2  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/"$i"/"$i"_likelihood_ratios.txt
rm pipe1 pipe2






# The cat all likelihood statistic files

cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/MLoutput/*/*_likelihood_ratios.txt > /home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/likelihood_ratio_100_runs.txt



# Use R to calculate p-value statistic



LRs<-read.table("/home/hulinm/pseudomonas_data/pseudomonas/analysis/bayestraits/final/multiple_trees/likelihood_ratio_100_runs.txt", col.names=,0)
attach(LRs)
LRs[,5]=pchisq(V4, 8-4, lower.tail=FALSE)
write.table(LRs, "LRs.tmp", sep="\t")

sed s/\"//g LRs.tmp > LRs2.tmp # Remove ""s
sed -i -e "1d" LRs2.tmp # Remove first line

# Get list of genes that had statistically significant p-value over 90% of the time (using python) then sort to get only those that occur 90+ times


python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/sort_by_pvalue.py LRs2.tmp > LRs3.tmp #Get list of genes with p.value <= 0.05
sort LRs3.tmp | uniq -c > LRs4.tmp #Get number of times gene appears (need to manually edit output to make tab delimited)
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/get_90_genes.py LRs4.tmp > statistically_sig_genes.txt #pull out only those that appear 90% or more times
rm *.tmp
