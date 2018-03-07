# Ranger - DTL for tracking evolution of genes through horizontal gene transfer 

# Reformat trees with R to remove branch lengths
# R script to go through all gene trees and remove branch lengths will want to keep support values in for OptResolutions (for weakly supported trees)
# Analysis performed in Genomics Pseudomonas paper 2018. RANGER-DTL takes an input of rooted species tree and unrooted gene tree. As the gene trees contained nodes with low support, OptResolutions was used to generate a series of optimally rooted gene trees, with any nodes with 0% support collapsed. Ranger-DTL was ran on 100 randomly selected, rooted gene trees. The program was run 100 times for three different costs (2,3,1/3,3,1/2,4,1) for duplication, transfer and loss events respectively. AggregateRanger then summarised the results to retain only those events that occurred in all possible cost scenarios. The results for each separately rooted tree of each effector were then combined to determine events that occurred in all possible gene trees. Due to the programs requirement for binary trees, spurious transfer events between almost identical strains were removed based on a phylogenetic distance of <0.01 branch length (nucleotide substitutions per site) using python. The transfer events for each effector gene were visualised on the species tree using the R packages ggtree and APE (Paradis et al., 2004; Yu et al., 2017). 




for genetree in ./RAxML_bipartitions.* ; do 
genetree_short=$(basename $genetree | sed s/"RAxML_bipartitions."//g | sed s/".fa"//g) 
echo $genetree_short
Rscript /home/hulinm/git_repos/tools/analysis/python_effector_scripts/edittree2.R $genetree $genetree_short
done

# Then use sed to remove any '-' dashes as the program doesn't allow these 

for file in * ; do 
sed -i s/"-"//g $file 
sed -i s/syr7268A/R27968A/g $file
sed -i s/avellBPIC631/avelBP631/g $file
sed -i s/myricaeAZ8448/myriAZ8448/g $file
sed -i s/act302091/acti302091/g $file
done

# For species tree edit names that are incorrect

sed -i s/myricaeAZ8448/myriAZ8448/g species_tree
sed -i s/syr7268A/R27968A/g species_tree
sed -i s/"-"//g species_tree 

# Use FigTree to root tree then remove branch lengths using R
tree <- read.tree("/Users/hulinm/Documents/species_tree.tre")
tree$edge.length<-NULL
write.tree(tree, "rooted")
# Combine species tree and gene tree for OptRoot/OptResolutions

for file in * ; do 
file_short=$(basename $file) 
cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/rooted_species_tree $file > /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/"$file_short".tre
done

# Or use OptResolutions.linux on unresolved gene trees to get rooted non-binary tree. Cut off all support values less than 10 (Can't do higher due to complexity of program not allowing multiple outdegrees)

for file in *.tre ; do 
file_short=$(basename $file | sed s/".tre"//g) 
echo $file_short
/home/hulinm/local/src/Linux/SupplementaryPrograms/wrapper.sh -i $file -B 1 -o ./1_BS/"$file_short"_optres
done



# Then need to extract all the possible optimal trees for testing 

for file in *_optres ; do 
file_short=$(basename $file | sed s/"_optres"//g)
grep "((" $file > "$file_short".tmp
done
 
for file in *.tmp ; do
file_short=$(basename $file | sed s/".tmp"//g)
echo $file_short
split -dl 1 -a 4 $file genes_"$file_short"_
done

# Then combine with species tree

for file in genes_* ; do 
file_short=$(basename $file | sed s/"genes_"//g ) 
echo $file_short
cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/rooted_species_tree $file > ./gene_trees/"$file_short"
done


rm *0000

# RangerDTL to reconcile DTLs of each gene tree onto species tree using different potential costs 


# Randomly sample 100 trees from optres output and do analysis on these trees 

for effector in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/*.tre ; do 
effector_short=$(basename $effector | sed s/".tre"//g) 
number=$(ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"_* | wc -l)

entries=($(shuf -i 1-$number -n 100 | sort -n))

for entry in "${entries[@]}"; do
    number2=$(echo "$entry" | sed -e :a -e 's/^.\{1,3\}$/0&/;ta')


for tree in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"_"$number2" ; do 
tree_short=$(basename $tree) 
echo $tree_short
mkdir -p ./"$effector_short"/"$tree_short"
cp $tree ./files


# Analysis 
for tree in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/* ; do 
tree_short=$(basename $tree)
effector_short=$(echo $tree_short | rev | cut -f2 -d "_" | rev) 
echo $effector_short
for i in `seq 1 100`; do
echo $i
Jobs=$(qstat | grep 'sub_ranger' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_ranger' | wc -l)
    done
qsub /home/hulinm/git_repos/pseudomonas/sub_ranger.sh /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/"$tree_short" /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/$tree_short/"$tree_short"_out_"$i" 2 3 1
rm ./sub_ranger*
done
for i in `seq 101 200`; do
echo $i
Jobs=$(qstat | grep 'sub_ranger' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_ranger' | wc -l)
    done
qsub /home/hulinm/git_repos/pseudomonas/sub_ranger.sh /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/"$tree_short"  /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/$tree_short/"$tree_short"_out_"$i" 3 3 1
rm ./sub_ranger*
done


for i in `seq 201 300`; do
echo $i
Jobs=$(qstat | grep 'sub_ranger' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_ranger' | wc -l)
    done
rm ./sub_ranger*
qsub /home/hulinm/git_repos/pseudomonas/sub_ranger.sh /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/"$tree_short" /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/$tree_short/"$tree_short"_out_"$i" 2 4 1

done
done
done
done
done
done



# New script 
for tree in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/* ; do 
tree_short=$(basename $tree)
effector_short=$(echo $tree_short | rev | cut -f2 -d "_" | rev) 
echo $effector_short

cd   /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$tree_short"/
/home/hulinm/local/src/Linux/CorePrograms/AggregateRanger_recipient.linux "$tree_short"_out_ > "$tree_short"_output2






# Processing aggregate output to get list of HGT events that have occurred for each gene 

# Get transfers that occurred in all runs for each gene tree

for tree in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/* ; do 
tree_short=$(basename $tree)
effector_short=$(echo $tree_short | rev | cut -f2 -d "_" | rev) 
echo $effector_short

grep "Transfers = 300" ./"$effector_short"/$tree_short/"$tree_short"_output2 | grep "300 times" |  cut -d "[" -f4  | sed s/"Most Frequent mapping --> "//g | sed s/"], "//g | sed s/"times"//g > ./"$effector_short"/$tree_short/"$tree_short"_donors 
grep "Transfers = 300" ./"$effector_short"/$tree_short/"$tree_short"_output2 | grep "300 times" |  cut -d "[" -f5  | sed s/"Most Frequent recipient --> "//g | sed s/"]."//g | sed s/"times"//g > ./"$effector_short"/$tree_short/"$tree_short"_recipients



# Combine donors and recipients into one file 
mkfifo pipe1
mkfifo pipe2
cut -f1 ./"$effector_short"/$tree_short/"$tree_short"_donors   > pipe1 & 
cut -f1  ./"$effector_short"/$tree_short/"$tree_short"_recipients > pipe2 &
paste pipe1 pipe2  >  ./"$effector_short"/$tree_short/"$tree_short"_transfer_events
rm pipe1 pipe2
done

# All transfer events 
for tree in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/* ; do 
tree_short=$(basename $tree)
effector_short=$(echo $tree_short | rev | cut -f2 -d "_" | rev) 
echo $effector_short
sed s/", [0-9]*"//g ./"$effector_short"/$tree_short/"$tree_short"_transfer_events >  ./"$effector_short"/$tree_short/"$tree_short"_transfer_events2
done 

# The above results are for each separate gene tree. As there are multiple optimal gene trees concatenate all results and see how often (in how many trees) each transfer occurred 

for tree in /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/files/* ; do 
tree_short=$(basename $tree)
effector_short=$(echo $tree_short | rev | cut -f2 -d "_" | rev) 
echo $effector_short
number=$(ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/*/*transfer_events2 | wc -l)
echo $number

cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/*/*transfer_events2 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfer_events
sort /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfer_events  | uniq -c  |  sed -e 's/^[ \t]*//'  | sed s/"\s""\t"/"\t"/g | sed s/"\s"/"\t"/g > /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfer_counts2
# or perl -lane'$,=" ";print sort @F' /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfer_events | sort | uniq -c  |  sed -e 's/^[ \t]*//'  | sed s/"\s""\t"/"\t"/g | sed s/"\s"/"\t"/g > /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfer_counts2
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_effector_events80.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfer_counts2 $number | sed s/"\t""\t"/"\t"/g | cut -f2,3  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfers2

sed -i '/^$/d' /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/effector_trees/combined/1_BS/gene_trees/"$effector_short"/"$effector_short"_transfers2
done




# Get distances file using R

library(reshape2)
library(ape)
library(phangorn)
tree2 <- read.tree("/Users/hulinm/species_tree_original")
distmat<-dist.nodes(tree2)
distances<-melt(distmat)
write.table(distances, "distances") 

# Get list of all nodes and tips in order from output of ranger (with node labels of nx) 
sed -i  s/","/"\n"/g tree
sed -i  s/")"/"\n"/g tree
sed -i  s/")"//g tree
sed -i  s/"("//g tree
sed -i  s/";"//g tree

sed -i s/"n[0-9]*"//g tree
sed -i '/^$/d' tree

# dist (distances) tree1 (names in order 203 times), tree2 (names repeated individually 203 times)
perl -0777pe '$_=$_ x 203' tree > tree1
perl -ne 'print "$_" x203' tree > tree2

mkfifo pipe1
mkfifo pipe2
mkfifo pipe3
cut -f1 tree1   > pipe1 & 
cut -f1  tree2 > pipe2 &
cut -f1  dist > pipe3 &
paste pipe1 pipe2 pipe3 > tree_distances
rm pipe1 pipe2 pipe3
done


#sed s/'"'//g tree_distances | sed s/" "/"\t"/g | cut -f2,3,4 | tail -n +2 > tree_distances2 

# Remove pairs < 0.01 branch length apart
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_tips_0.0001.py tree_distances > tree_distances2
sed s/" "/"\t"/g tree_distances2 > tree_distances3
wc -l: 
41209 tree_distances
38662 tree_distances2


for file in *_transfers ; do 
file_short=$(basename $file | sed s/"_transfers"//g) 
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_transfers.py $file /home/hulinm/pseudomonas_data/pseudomonas/analysis/ranger/tree_distances3  > "$file_short"_long_transfers
sed -i '/^$/d'  "$file_short"_long_transfers

# Get all transfer event files 
for file in *_long_transfers ; do 
file_short=$(basename $file) 
awk 'BEGIN{print "d    r"}{print}' $file > "$file_short"2


