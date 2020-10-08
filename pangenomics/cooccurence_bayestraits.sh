#################################################################

# BayesTraits co-occurrence analysis 

#################################################################

# Using BayesTraits in discrete mode to model coevolution of effector gene pairs. 
# Using T3E dataset generated from 234 genomes (not the epiphytes) 
# Analysis conducted in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new

# Co-occurence models 

# Dependant v Independant models to see if there is significant coevolution between two genes
# Also run the covarion model which sees if D and I are occurring on different parts of the tree 
# Run three times to see if results are consistent 
# Take highest likelihood model
# Use BayesFactors to pull out significant difference between different models D v I then covarion v D. 
# Extract the rate distributions for best fitting model


# Then seperate these out into synergistic and antagonistic interactions 
# Synergistic, cooccur and have mutually dependant effectors. Either needed to work together on particular pathways or work on different pathways
# Antagonistic, they may be redundant with each other and therefore loss of A when B is present or used in different systems to perform the same function 

# Make table unix compatible 
 tr '\r' '\n' < pseudomonas_effector_table.txt > effectors.txt

# If using a smaller set of genomes (subset, remove phylogroup 2) 

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_effectors_bayes.py list effectors.txt > effectors.txt2 
sed -i '/^$/d' effectors.txt2
mv  effectors.txt2  effectors.txt

# Splitting effector file up into pairwise comparisons (effectorA x effectorB)
for n in `seq 2 103` ; do
first=$(echo $n)
echo $first
for i in `seq 3 103` ; do
second=$(echo $i)
cut -f1,$first,$second effectors.txt > ./txt_files/"$n"_"$i" 
done 
done

# Rename each effector pair file
for file in * ; do
mv $file $(head -1 $file | sed s/"strain\t"//g | sed s/"\t"/"_"/g).txt2
done

 

# Remove single files generated when comparing effector with itself 

rm !(*_*)
sed -i '/^$/d' *
sed -i 1d *


# Get rooted tree into nexus format for bayestraits and remove the node labels 

Rscript /home/hulinm/git_repos/tools/analysis/python_effector_scripts/treetonex.R tree tree.nex

# Alternatively use the bootstrapped trees 

/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/boottree.nex


# Make files compatible with bayestraits

for i in `seq 1 3`; do         
echo $i   
#mkdir $i # For making directory within MLoutput folder
for EFFECTOR in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
cp "$EFFECTOR_SHORT".txt2 //projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/"$EFFECTOR_SHORT"_"$i".txt
done
done

# Run bayestraits with each effector pair with the 1000 bootstrapped trees generated with IQTREE. RJHP 0-100
# Trialled various parameters, used "ori" command file for this analysis

# Parameters 
3
2
IT 5500000
BI 500000
RJHP exp 0 1000
stones 100 10000
run
#

for EFFECTOR in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/*.txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
echo $EFFECTOR_SHORT
        Jobs=$(qstat | grep 'bayes' | wc -l)
    while [ $Jobs -gt 200 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'bayes' | wc -l)
    done
qsub /projects/oldhome/hulinm/git_repos/pseudomonas/bayestraits/sub_bayestraits3_testing2.sh boottree1.nex "$EFFECTOR_SHORT".txt /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new ori
done



# Then make log file compatible with R 
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/
for logfile in $WorkDir/output/*dep ; do 
filename=$(basename $logfile)
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_mcmc_output.py   $logfile > $WorkDir/output/out/"$filename"_out
done

for logfile in $WorkDir/output/*ind ; do 
filename=$(basename $logfile)
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_mcmc_output.py   $logfile > $WorkDir/output/out/"$filename"_out
done


# Further modifications to make compatible with R
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/
for logfile in $WorkDir/output/out/*dep_out ; do 
filename=$(basename $logfile | sed s/"_out"//g )
sed s/"Tree No"/Tree_No/g  $logfile | sed s/"Dep \/ InDep"/"Dep_\/_InDep"/g | sed s/"No Off Parmeters"/No_Off_Parmeters/g | sed s/"No Off Zero"/No_Off_Zero/g  | sed s/"Model string"/"Model_string"/g | sed s/"Root - "/Root_-_/g | sed s/"RJRates - Mean"/RJRates_Mean/g  >  $WorkDir/output/out/"$filename"_out2 # Independant analysis 
cut -f1,2,3,4,5,8,9,10,11,12,13,14,15,16  $WorkDir/output/out/"$filename"_out2  >  $WorkDir/output/out/"$filename"_out3
done

for logfile in $WorkDir/output/out/*ind_out ; do 
filename=$(basename $logfile | sed s/"_out"//g )
sed s/"Tree No"/Tree_No/g $logfile | sed s/"Dep \/ InDep"/"Dep_\/_InDep"/g |  sed s/"No Off Parmeters"/No_Off_Parmeters/g | sed s/"No Off Zero"/No_Off_Zero/g  | sed s/"Model string"/"Model_string"/g | sed s/"Root - "/Root_-_/g | sed s/"RJRates - Mean"/RJRates_Mean/g  > $WorkDir/output/out/"$filename"_out2 # Independant analysis 
cut -f1,2,3,4,5,7,8,9,10,11,12,13,14,15,16 $WorkDir/output/out/"$filename"_out2  >  $WorkDir/output/out/"$filename"_out3
done

#for logfile in $WorkDir/output/out/*cv_out ; do 
#filename=$(basename $logfile | sed s/"_out"//g )
#sed s/"Tree No"/Tree_No/g $logfile | sed s/"Dep \/ InDep"/"Dep_\/_InDep"/g |  sed s/"No Off Parmeters"/No_Off_Parmeters/g | sed s/"No Off Zero"/No_Off_Zero/g  | sed s/"Model string"/"Model_string"/g | sed s/"Root - "/Root_-_/g | sed s/"RJRates - Mean"/RJRates_Mean/g  > $WorkDir/output/out/"$filename"_out2 # Independant analysis 
#cut -f1,2,3,4,5,7,8,9,10,11,12,13,14,15,16 $WorkDir/output/out/"$filename"_out2   >  $WorkDir/output/out/"$filename"_out3
#done


# Run Rscript to generate ESS, Gelman statistics and generate plots
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/
for effector in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/effector_combinations3) ; do 
echo $effector
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R $WorkDir/output/out/"$effector"_1.txt_ind_out3 $WorkDir/output/out/"$effector"_2.txt_ind_out3  $WorkDir/output/out/"$effector"_3.txt_ind_out3 "$effector"_ind $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R $WorkDir/output/out/"$effector"_1.txt_dep_out3 $WorkDir/output/out/"$effector"_2.txt_dep_out3  $WorkDir/output/out/"$effector"_3.txt_dep_out3 "$effector"_dep $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R $WorkDir/output/out/"$effector"_1.txt_cv_out3 $WorkDir/output/out/"$effector"_2.txt_cv_out3  $WorkDir/output/out/"$effector"_3.txt_cv_out3 "$effector"_cv $WorkDir/output/out/
done

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/

Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_avrPto1_1scale.txt_ind_out3 avrA1_avrPto1_2scale.txt_ind_out3 avrA1_avrPto1_3scale.txt_ind_out3 avrA1_avrPto1_scale $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_avrB1_1scale.txt_ind_out3 avrA1_avrB1_2scale.txt_ind_out3 avrA1_avrB1_3scale.txt_ind_out3 avrA1_avrB1_scale $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_avrRps4_1scale.txt_ind_out3 avrA1_avrRps4_2scale.txt_ind_out3 avrA1_avrRps4_3scale.txt_ind_out3 avrA1_avrRps4_scale $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_hopAO2_1scale.txt_ind_out3 avrA1_hopAO2_2scale.txt_ind_out3 avrA1_hopAO2_3scale.txt_ind_out3 avrA1_hopAO2_scale $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_hopAO2_1longscale.txt_ind_out3 avrA1_hopAO2_2longscale.txt_ind_out3 avrA1_hopAO2_3longscale.txt_ind_out3 avrA1_hopAO2_longscale $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_hopAO2_1K.txt_ind_out3 avrA1_hopAO2_2K.txt_ind_out3 avrA1_hopAO2_3K.txt_ind_out3 avrA1_hopAO2_K $WorkDir/output/out/
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/bayes_stats2.R avrA1_hopAO2_1long.txt_ind_out3 avrA1_hopAO2_2long.txt_ind_out3 avrA1_hopAO2_3long.txt_ind_out3 avrA1_hopAO2_long $WorkDir/output/out/

# Pull out the acceptance rate from schedule file 
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/
for logfile in $WorkDir/output/*schedule ; do 
filename=$(basename $logfile | sed s/_schedule//g)
echo $filename > $WorkDir/output/acceptance4/"$filename"_out
tail -1 $logfile| cut -f13 >> $WorkDir/output/acceptance4/"$filename"_out
echo $(cat $WorkDir/output/acceptance4/"$filename"_out) > $WorkDir/output/acceptance4/"$filename"_acceptance
rm $WorkDir/output/acceptance4/"$filename"_out
done


grep -v txt /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/effector_combinations3 > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/effector_combinations4













# Generating NULL files in which the effector presence and absence is randomly shuffled 
# Create null table 

head -n 1 effectors.txt > effectors_header
sed 1d effectors.txt > effectors_withoutheader.txt
shuf effectors_withoutheader.txt > null_effectors
tr [:blank:] \\t < effectors_header > effectors_header2
cat effectors_header2 null_effectors > null_effectors.txt

# Splitting effector file up into pairwise comparisons (effectorA x effectorB)
for n in `seq 2 103` ; do
first=$(echo $n)
echo $first
for i in `seq 3 103` ; do
second=$(echo $i)
cut -f1,$first,$second null_effectors.txt > ./txt_files2/"$n"_"$i" 
done 
done

# Rename each effector pair file
for file in * ; do
#mv $file $(head -1 $file | sed s/"strain\t"//g | sed s/"\t"/"_"/g).txt2
mv $file $(head -1 $file | sed "s/^[ \t]*//" | sed s/"\t"/"_"/g).txt2
done

# Remove single files generated when comparing effector with itself 

rm !(*_*)
sed -i '/^$/d' *
sed -i 1d *


# Make files compatible with bayestraits

for i in `seq 1 3`; do         
echo $i   
#mkdir $i # For making directory within MLoutput folder
for EFFECTOR in /data2/scratch2/hulinm/bayestraits/new/withoutP2/txt_files2/*.txt2 ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt2//g)
cp "$EFFECTOR_SHORT".txt2 /data2/scratch2/hulinm/bayestraits/new/withoutP2/txt_files2/"$EFFECTOR_SHORT"_"$i".txt
done
done

# Run bayestraits with each effector pair with the 1000 bootstrapped trees generated with IQTREE. RJHP 0-100
for EFFECTOR in /data2/scratch2/hulinm/bayestraits/new/withoutP2/txt_files2/*.txt ; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.txt//g)
echo $EFFECTOR_SHORT
        Jobs=$(qstat | grep 'bayes' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'bayes' | wc -l)
    done
qsub /home/hulinm/git_repos/pseudomonas/bayestraits/sub_bayestraits3_testing_null.sh pa_withoutP2_boottree1.nex "$EFFECTOR_SHORT".txt data2/scratch2/hulinm/bayestraits/new/withoutP2 ori
done









# Comparing models and pulling out statistically significant interactions 

#####

# Extract Lh value from two files and get ratio, then cat all into one big file for viewing

# In /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output

for file in *stones ; do 
file_short=$(basename $file | sed s/"_stones"//g )
echo $file_short
grep "marginal" $file > ./lh/"$file_short"_likelihood
done

# Concatenate results of three separate runs 
for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/*.txt ; do
file_short=$(basename $file | cut -f1,2 -d "_")
echo $file_short
 
cat "$file_short"_1.txt_dep_likelihood "$file_short"_2.txt_dep_likelihood "$file_short"_3.txt_dep_likelihood >  "$file_short"_dep_likelihood
cat "$file_short"_1.txt_ind_likelihood "$file_short"_2.txt_ind_likelihood "$file_short"_3.txt_ind_likelihood >  "$file_short"_ind_likelihood

done

# Then paste together independant and dependant models and calculate the LR statistic 
for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/*.txt2 ; do
file_short=$(basename $file | cut -f1,2 -d "_")
echo $file_short
paste "$file_short"_ind_likelihood "$file_short"_dep_likelihood > "$file_short".tmp
cut -f2,4  "$file_short".tmp >  "$file_short".tmp2
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/create_LR.py "$file_short".tmp2 > "$file_short".LR
done


# Get median LR of the three replicate runs 
for file in //projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/*.txt2 ; do
file_short=$(basename $file | cut -f1,2 -d "_")
echo $file_short
sort -nk3  "$file_short".LR | sed -n '2p' > "$file_short".LR2



# Concatenate all
for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/txt_files/*.txt ; do
file_short=$(basename $file | cut -f1,2 -d "_" | sed s/".txt"//g)
echo $file_short >> list

cat *.LR2 > likelihood_ratios
paste list likelihood_ratios > likelihood_ratios2

# Just medians 
uniq list > list2

# Remove those which had 0 strains with both effectors 
grep -v hopBK1_hopBL2 list2 | grep -v hopBK1_hopX3 | grep -v hopBL2_hopX3 | grep -v hopAM1_hopX3 > list3
# withoutP2 analysis 
grep -v hopAJ1_hopJ1 list2  > list3

cat *.LR2 > likelihood_ratios_median
paste list3 likelihood_ratios_median > likelihood_ratios_median2


# run chi-squared 
R
LRs<-read.table("/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/likelihood_ratios_median2", col.names=,0)
attach(LRs)
LRs[,5]=pchisq(V4, 8-4, lower.tail=FALSE)
write.table(LRs, "LRs_median.tmp", sep="\t")

sed s/\"//g LRs_median.tmp > LRs_median2.tmp # Remove ""s
sed -i -e "1d" LRs_median2.tmp # Remove first line

# Get list of significant interactions based on p<0.05
# Also get corrected list using BH method

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/get_sig_interacting_genes.py LRs_median2.tmp > LRs_median_sig.tmp # Before correction

R
LRs<-read.table("/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/LRs_median2.tmp", col.names=,0)
attach(LRs)
p2<-p.adjust(LRs$V6, method = "BH", n = length(LRs$V6))
write.table(p2, file="BH")

sed -i s/\"//g BH
sed -i -e "1d" BH
cut -f2 -d " " BH > BH2

paste LRs_median2.tmp BH2 > LRs_median_corr.tmp 
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/get_sig_interacting_genes2.py LRs_median_corr.tmp  > LRs_median_corr_sig.tmp  # Before correction


# Use R to statistically compare transition rates 


# Get results for median lh value 
for file in *LR2 ; do 
file_short=$(basename $file | sed s/".LR2"//g)
echo $file_short
for line in $(cat $file | cut -f3 | sed s/"\."/"\[.\]"/g | sed s/"-"//g) ; do  
num=$(grep -r -n "$line" "$file_short".LR  | cut -f1 -d ":" )
echo $num
cp //projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output/"$file_short"_"$num".txt_dep /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output/rate_comparison/


# Then make log file compatible with R 
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output/rate_comparison
for file in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output/LRs_median_sig.tmp)  ; do 
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_mcmc_output.py   $file* > $WorkDir/"$file"_out
done

# Further modifications to make compatible with R
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output/rate_comparison
for logfile in $WorkDir/*_out ; do 
filename=$(basename $logfile | sed s/"_out"//g )
sed s/"Tree No"/Tree_No/g  $logfile | sed s/"Dep \/ InDep"/"Dep_\/_InDep"/g | sed s/"No Off Parmeters"/No_Off_Parmeters/g | sed s/"No Off Zero"/No_Off_Zero/g  | sed s/"Model string"/"Model_string"/g | sed s/"Root - "/Root_-_/g | sed s/"RJRates - Mean"/RJRates_Mean/g  >  $WorkDir/"$filename"_out2 # Independant analysis 
cut -f1,2,3,4,5,8,9,10,11,12,13,14,15,16  $WorkDir/"$filename"_out2  >  $WorkDir/"$filename"_out3
done


# Do the Two-sample Kolmogorov-Smirnov test and pull out median values for each distribution
# Generate file with p.value, comparison rates and two median values
WorkDir=//projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/bayestraits/cooccurence/new/output/rate_comparison
for file in $WorkDir/*_out3 ; do 
file_short=$(basename $file | sed s/"_out3"//g)
echo $file_short
Rscript /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/test_bayes_significant_rates.R $file "$file_short"_t1.tmp "$file_short"_t2.tmp "$file_short"_t3.tmp "$file_short"_t4.tmp
# unix
cat "$file_short"_t1.tmp "$file_short"_t2.tmp "$file_short"_t3.tmp "$file_short"_t4.tmp | cut -f2,3,4,5 | grep -v "Var" | sed s/'"'//g | sed s/"and"/"\t"/g > "$file_short"_rates.tmp
# Use python to only keep lines where col0 <0.05 and then pull out highest median of the significant rate pairs 
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_bayes_rates.py "$file_short"_rates.tmp > "$file_short"_rates.tmp2
sed s/"q12"/"R"/g "$file_short"_rates.tmp2 | sed s/"q13"/"R"/g | sed s/"q42"/"R"/g | sed s/"q43"/"R"/g | sed s/"q21"/"S"/g | sed s/"q24"/"S"/g | sed s/"q31"/"S"/g | sed s/"q34"/"S"/g | sed s/" "//g | sort | uniq > "$file_short"_rates
done

# Make all results on one line and then paste all into a table format 
sed -i ':a;N;$!ba;s/\n/ /g' *rates
ls *rates > list
cat *rates > global_rates
paste list global_rates > global_rates2

# Copy this to working directory and then make suitable for network in R
# Change those that scored highly for both trends as "m"
sed s/"R S"/"m"/g global_rates2 > global_rates3
sed -i s/"_rates"//g global_rates3
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_bayes_corr.py    global_rates3 LRs_median_corr_sig.tmp > global_rates_corr



# Generating network in R of linked genes from bayestraits analysis (done on local machine)

install.packages("statnet", dependencies = TRUE) 
library(statnet)
set.seed(12345)
LRs<-read.table("/Users/hulinm/Desktop/global_rates_corr.txt", col.names=,1)
#LRs<-read.table("/Users/hulinm/Desktop/global_rates_corr_yopT.txt", col.names=,1)
#LRs<-read.table("/Users/hulinm/Desktop/global_rates_corr_pto.txt", col.names=,1)
#LRs<-read.table("/Users/hulinm/Desktop/global_rates_corr_hopF.txt", col.names=,1)

attach(LRs)
library(ggplot2)
library(gplots)
library(reshape2)
library(plyr)
library(network)
matrix<-acast(LRs, e1~e2)
matrix[is.na(matrix)] <- 0

# Need to make matrix into a square

un1 <- unique(sort(c(colnames(matrix), rownames(matrix))))
m2 <- matrix(NA, length(un1), length(un1), dimnames = list(un1, un1))
m2[row.names(matrix), colnames(matrix)] <- matrix
m2[is.na(m2)] <- 0
diag(m2)<-0

m2 <- network(x = m2, # the network object
                  directed = FALSE, # specify whether the network is directed
                  loops = FALSE, # do we allow self ties (should not allow them)
                  matrix.type = "adjacency", # the type of input
                  ignore.eval = FALSE, 
                  names.eval = "weights")

# Plot network 
library(GGally)
set.edge.attribute(m2, "color", ifelse(m2 %e% "weights" >0.98, "firebrick", "grey"))

a<-ggnet2(m2, size= "degree", edge.size = "weights",  edge.col="color", label = TRUE, label.size = 2)
ggsave("network_bayes.pdf", plot = a, width = 20, height = 20)
dev.off()
