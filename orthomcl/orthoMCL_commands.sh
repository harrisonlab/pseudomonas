# Commands to run OrthoMCL on the cluster for 108 genomes used in genomics paper
# Followed by commands to extract single copy, all member genes 


# Setting on SQL database
mysql> select user from mysql.user;
ERROR 1142 (42000): SELECT command denied to user 'hulinm_orthomcl'@'149.155.34.72' for table 'user'
mysql '-p hulinm_orthomcl' -u hulinm_orthomcl -h 149.155.34.104
mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE VIEW,CREATE,INDEX,DROP on hulinm_orthomcl.* TO hulinm_orthomcl@'%';
 perl -MDBI -e 1
 perl -MDBD::mysql -e 1
 mkdir -p ~/testing/hulinm_orthomcl

## To log in and drop the database to clear tables before new run, this is needed when it fails with "table already exists" ##
mysql -p -u hulinm_orthomcl -h 149.155.34.104
drop database hulinm_orthomcl ; # Drop the database
create database hulinm_orthomcl ; # Create database again


#Running ORTHO-MCL

 ProjDir=/home/hulinm
  cd $ProjDir
  IsolateAbrv=Pcac_10300_414_404_Pinf
  WorkDir=pseudomonas_data/pseudomonas/analysis/new_ortho/aug
  mkdir -p $WorkDir
  #mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins


## Format fasta file correctly for orthomcl  to create >STRAIN|peg.NUMBER. Example below: 

sed s/fig'|'6666666.216475./Ps_rhaphiolepidis'|'/g rhaphiolepidis.fa > Ps_rhaphiolepidis.fasta

## Run orthomclFilterFasta on 108 genomes

WorkDir=/home/hulinm/pseudomonas_data/pseudomonas/analysis/new_ortho/final_core

Input_dir=$WorkDir/formatted
echo $Input_dir
  Min_length=50
  Max_percent_stops=20
  Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
  Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta
  orthomclFilterFasta $Input_dir $Min_length $Max_percent_stops $Good_proteins_file $Poor_proteins_file

#checks
grep ">" poorProteins.fasta | wc -l : 25691 poor proteins
grep ">" goodProteins.fasta | wc -l : 575031 good proteins
#grep -c ">" ./formatted/*.fasta > features_no

## Run all v all blast

WorkDir=/home/hulinm/pseudomonas_data/pseudomonas/analysis/new_ortho/final_core
Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta

BlastDB=$WorkDir/blastall/all.db

  makeblastdb -in $Good_proteins_file -dbtype prot -out $BlastDB
  BlastOut=$WorkDir/all_results.tsv
  mkdir -p $WorkDir/splitfiles

  SplitDir=/home/armita/git_repos/emr_repos/tools/seq_tools/feature_annotation/signal_peptides
  $SplitDir/splitfile_500.py --inp_fasta /home/hulinm/pseudomonas_data/pseudomonas/analysis/new_ortho/final_core/goodProteins/goodProteins.fasta --out_dir $WorkDir/splitfiles --out_base goodProteins

  ProgDir=/home/hulinm/pseudomonas_data/pseudomonas/analysis/orthomcl
  for File in $(find $WorkDir/splitfiles); do
    Jobs=$(qstat | grep 'blast_500' | wc -l)
    while [ $Jobs -gt 32 ]; do
      sleep 10
      printf "."
      Jobs=$(qstat | grep 'blast_500' | wc -l)
    done
    printf "\n"
    echo $File
    BlastOut=$(echo $File | sed 's/.fa/.tab/g')
    qsub $ProgDir/blast_500.sh $BlastDB $File $BlastOut
  done

...............

## merge hits
  WorkDir=/home/hulinm/pseudomonas_data/pseudomonas/analysis/new_ortho/final_core
  MergeHits=all_blast.tab
  printf "" > $MergeHits
  for Num in $(ls $WorkDir/splitfiles/*.tab | rev | cut -f1 -d '_' | rev | sort -n); do
    File=$(ls $WorkDir/splitfiles/*_$Num)
    cat $File
  done > $MergeHits

  ## find orthologs. Run from home directory

  ProgDir=/home/hulinm/git_repos/tools/pathogen/orthology/orthoMCL
  MergeHits=pseudomonas_data/pseudomonas/analysis/new_ortho/final_core/all_blast.tab
  GoodProts=pseudomonas_data/pseudomonas/analysis/new_ortho/final_core/goodProteins/goodProteins.fasta
  qsub $ProgDir/qsub_orthomclMH.sh $MergeHits $GoodProts 1.5



#### Subsequent processing to obtain single copy all member genes for phylogenetic analysis  #### 
# This was done in "/home/hulinm/analysis/" as orthomcl saved all the results to /home/hulinm instead of the pseudomonas_data folder 


# First split goodProteins.fasta into file for each orthogroup
python /home/hulinm/git_repos/tools/pathogen/orthology/orthoMCL/orthoMCLgroups2fasta.py --orthogroups final_core_orthogroups.txt2 --fasta ../../../../goodProteins/goodProteins.fasta --out_dir ./fasta/


# Get list of strains used in orthomcl from formatted aa_file folder

ls | sed s/.fasta//g > list
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/make_strain_list.py list > list2

# Process orthogroups.txt output file to remove gene numbers leaving it as just orthogroup: strain| strain| strain|
sed s/[.]peg.[0-9]*//g final_core_orthogroups.txt2 | sed s/peg.[0-9]*//g  > final_core_orthogroups.tmp


# Use python and bash to extract frequencies of each strain's genes per OG, and extract those with multiple copies
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/orthogroup_gene_freq.py final_core_orthogroups.tmp list2 > ortho_gene_freq
python get_multiple_copy.py ortho_gene_freq | sort -u | awk '{print $0".fa"}' > multiple_copy_OGs


#Use this list to mv multiple copy member fastas to new folder, then count no. of ">" in each to find those with all members (core)

for file in $(cat ../multiple_copy_OGs); do mv "$file" /home/hulinm/analysis/orthology/orthomcl/final_core/fasta/multiple_copy/ ; done
mv *.fa single_copy/ # This will move all remaining fasta files into single copy folder


for file in /home/hulinm/analysis/orthology/orthomcl/final_core/fasta/single_copy/*.fa ; do
file_bn=$(basename $file)
file_short=$(echo $file_bn | sed s/.fa//g)
grep -c ">" $file > "$file_short".tmp

cat *.tmp > no_genes

ls *.fa | sed s/".fa"//g > gene_list # Create list of single_copy genes

# Generate file with each orthogroup and number of strains that have a gene in this OG by extracting data from the different files and feeding into pipes
mkfifo pipe1
mkfifo pipe2
cut -f1 no_genes > pipe1 &
cut -f1 gene_list > pipe2 &
paste pipe2 pipe1  > no_genes_per_OG
rm pipe1 pipe2
rm *.tmp

# Then extract those genes with 108 single copy members to get basic core genome

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/get_core_genes.py no_genes_per_OG > all_member_genes


# Then will need to pull out NT sequence locations and get nucleotide sequence and add to final file


# Use list of all member genes to get names of individual strain's genes to extract nucleotide sequence from fasta file
for file in $(cat all_member_genes); do cp "$file".fa /home/hulinm/analysis/orthology/orthomcl/final_core/fasta/single_copy/core_genes ; done

# Get gene names from fa file

for file in /home/hulinm/analysis/orthology/orthomcl/final_core/fasta/single_copy/core_genes/*.fa ; do
file_short=$(basename $file | sed s/".fa"//g)
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_gene_names.py $file | sed s/">"//g > "$file_short"_genes


#Use this list to extract NT sequences of each orthogroup from NT fasta file of all sequences
# This will give all NT sequences of core genes ready for phylogenetic analysis 

for orthogroup in /home/hulinm/analysis/orthology/orthomcl/final_core/fasta/single_copy/core_genes/*_genes ; do
og=$(basename $orthogroup | sed s/"_genes"//g)
echo $og
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_seq.pl /home/hulinm/pseudomonas_data/pseudomonas/analysis/new_ortho/final_core/formatted/NT/all_NT.fa $orthogroup > ./fasta/"$og".fa









