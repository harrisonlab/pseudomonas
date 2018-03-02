# Commands to run OrthoMCL on the cluster for 108 genomes used in genomics paper

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








