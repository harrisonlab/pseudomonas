# Commands to pull out nucleotide sequences of T3E genes from all 339 genomes
# This is done by using tBLASTn to identify effector genes in the genome sequence. The best hits are extracted (accounting for if there is more than one hit)
# By obtaining the nucleotide locations the DNA sequence is extracted
# Gene sequences are then checked to see if they need to be reverse complemented 
# Filtering is performed to remove duplicate alleles of each effector, e.g. hopAT1 hopAT2 by seeing if they are identical and keeping longest hit. This prevents any "real" duplicates e.g. hopAF1-1 and hopAF1-2 in Psm R1 5244 from being removed
# Filtering out of pseudogenes and possible contigs breaks based on threshold 70% ID and 40% QL, presence of (*) and proximity to the start or end of a contig  
# Manual checking of those that appear to be contig breaks to see if they are true 'pseudogenes' or due to the cut off of the gene on the end of a contig
# Gene sequences are then aligned for each effector family and RAxML is used to generate a phylogenetic tree 


#Rename contigs in fasta files

for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fna.gz ; do
 GENOME_FILE=$(basename $GENOME)
 GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fna.gz//g)
 echo $GENOME_SHORT
 gunzip $GENOME_FILE
 python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/rename.py -i "$GENOME_SHORT".fna -o "$GENOME_SHORT".fa


# Run blast for effectors on all genomes

 for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT

 for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
     EFFECTOR_FILE=$(basename $EFFECTOR)
     EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
     echo $EFFECTOR_SHORT
#     mkdir -p ./"$EFFECTOR_SHORT"/new/output/besthit

 /home/hulinm/git_repos/tools/pathogen/blast/blast2csv.pl  $EFFECTOR tblastn $GENOME  5  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT"


# Process output to remove files that did not achieve thresholding values 
#First need to split files to create hit2 file when there is more than 1 hit e.g. 5244 hopAF1

 for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT


for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_blast_hit2.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT" > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2

# Removal of files that contain no hits !!

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT

  	cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/
	find . -type f -size 0 | xargs rm
  cd

# Filter csv files based on threshold of 40% ID, 60% QL
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT
    
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_present_effectors.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT"  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/"$GENOME_SHORT"_"$EFFECTOR_SHORT"
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_present_effectors.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2

# Removal of files that contain no hits !!!

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT

  	cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output
	find . -type f -size 0 | xargs rm
  cd

# Then sort by per_length and extract 'best hit' from file 
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
sort -n -r  -k8 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/"$GENOME_SHORT"_"$EFFECTOR_SHORT" | sed '/^$/d' | sort --stable -n -r -k9 |  head -n1  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"
sort -n -r  -k8 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2 | sed '/^$/d' | sort --stable -n -r -k9 |  head -n1  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2

#Remove empty files  !!!

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT

  	cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit
	find . -type f -size 0 | xargs rm
  cd



# Then need to rename files with reverse complement (hit_strand = -1) to allow reverse complementation of DNA sequence before alignments

 for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)

/home/hulinm/git_repos/tools/analysis/python_effector_scripts/find_RC_effectors.sh /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT" | sed s/" "/"\t"/g > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_RC
/home/hulinm/git_repos/tools/analysis/python_effector_scripts/find_RC_effectors.sh /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2 | sed s/" "/"\t"/g > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2_RC

# Remove files with nothing in: 

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT


  	cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit
	find . -type f -size 0 | xargs rm
    cd
done


# Then extract nucleotide locations to use to extract sequence from genome fasta file
 for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
#cut -f5,11,12 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT" > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_locations
#cut -f5,11,12 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2_locations
#cut -f5,11,12 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_RC > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_locations_RC
cut -f5,11,12 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/new/output/besthit/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2_RC > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$GENOME_SHORT"_"$EFFECTOR_SHORT"_hit2_locations_RC
done
done

# Remove files with nothing in: 

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT

  	cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide
	find . -type f -size 0 | xargs rm
  cd


# Use these locations to extract NT sequence from genome fasta


    rm ./*/nucleotide/*.fasta
    rm ./*/nucleotide/*.fasta_RC





#Original
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*_"$EFFECTOR_SHORT"_locations ; do
    f=$(basename $file)
    f_short=$(echo $f | sed s/_locations//g)
    genome=$(echo $f_short | rev | cut -d '_' -f2- | rev )
    echo $genome
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    while [ $Jobs -gt 24 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/extract_seq.sh /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$genome".fa $file /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$f_short".fasta
done


#Hit2

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
EFFECTOR_FILE=$(basename $EFFECTOR)
EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
echo $EFFECTOR_SHORT
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*_"$EFFECTOR_SHORT"_hit2_locations ; do
echo $file 
f=$(basename $file)
f_short=$(echo $f | sed s/_hit2_locations//g)
genome=$(echo $f_short | rev | cut -d '_' -f2- | rev )
echo $genome
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    while [ $Jobs -gt 24 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/extract_seq.sh /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$genome".fa $file /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$f_short".hit2.fasta
done



#RC
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/hopZ*; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*_"$EFFECTOR_SHORT"_locations_RC ; do
    f=$(basename $file)
    f_short=$(echo $f | sed s/_locations_RC//g)
    genome=$(echo $f_short | rev | cut -d '_' -f2- | rev )
echo $genome
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    while [ $Jobs -gt 24 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/extract_seq.sh /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$genome".fa $file /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$f_short".fasta_RC
done





#RC hit2
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    echo $EFFECTOR_SHORT
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*_"$EFFECTOR_SHORT"_hit2_locations_RC ; do
    f=$(basename $file)
    f_short=$(echo $f | sed s/_hit2_locations_RC//g)
    genome=$(echo $f_short | rev | cut -d '_' -f2- | rev )
echo $genome
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    while [ $Jobs -gt 24 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/extract_seq.sh /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$genome".fa $file /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$f_short".hit2.fasta_RC
done




# !!!!!!!! Then need to reverse complement RC files and overwrite NT.fasta files that contain seq that should have been RC 
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
for RC in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*.fasta_RC ; do
    file=$(basename $RC)
    file_short=$(echo $file | sed s/.fasta_RC//g)
    echo $file_short
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/reverse_complement.py $RC > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/"$file_short".fasta



# Then remove all _RC files !!!
for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
for RC in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*.fasta_RC ; do
    file=$(basename $RC)
    file_short=$(echo $file | sed s/.fasta_RC//g)
    echo $file
    rm $RC


# Move fasta files for each effector into their own family folder in effector families directory !!!!!

for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
    EFFECTOR_FILE=$(basename $EFFECTOR)
    EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
    FAMILIES=$(echo $EFFECTOR_SHORT | cut -d "-" -f1 | rev | cut -c 2- | rev )
    echo $FAMILIES

    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$EFFECTOR_SHORT"/nucleotide/*.fasta /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$FAMILIES"



# Need to replace name of sequence within each fasta file with name of strain and effector !!!

 for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
        GENOME_FILE=$(basename $GENOME)
        GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    for EFFECTOR in /home/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/*.fasta; do
        EFFECTOR_FILE=$(basename $EFFECTOR)
        EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
        FAMILIES=$(echo $EFFECTOR_SHORT | cut -d "-" -f1 | rev | cut -c 2- | rev )
        echo $FAMILIES

        sed s/'>'[0-9]*:[0-9]*-[0-9]*/'>'"$GENOME_SHORT"_"$EFFECTOR_SHORT"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$FAMILIES"/"$GENOME_SHORT"_"$EFFECTOR_SHORT".fasta > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$FAMILIES"/"$GENOME_SHORT"_"$EFFECTOR_SHORT".fa

# Remove blank files

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family
    cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"
    find . -type f -size 0 | xargs rm
    cd






# Blast each strains effectors for each family against each other in order to work out identical ones e.g. 5244 hopA1-1, hopA1-2. Then use python to remove those that are duplicated, leaving the longest version

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
echo $family
#mkdir -p ./"$family"/blast/hits
#rm ./"$family"/*.fasta
 for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)


for fasta in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$GENOME_SHORT"_"$family"* ; do
  echo $fasta
  file=$(basename $fasta)
  fasta_short=$(echo $file | sed s/.fa//g)
  echo $fasta_short
  fgenome=$(echo $fasta_short | rev | cut -d '_' -f2- | rev )

  for query in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$GENOME_SHORT"_"$family"* ; do
    echo $query
    file=$(basename $query)
    query_short=$(echo $file | sed s/.fa//g)
    echo $query_short
    q_genome=$(echo $query_short | rev | cut -d '_' -f2- | rev )

/home/hulinm/git_repos/tools/pathogen/blast/blast2csv.pl  $fasta blastn $query  1 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/"$fasta_short"_"$query_short"

done
done
done
done


# Remove header from files !!

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      for file in 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/* ; do
      echo $file
      sed -i '1d'  $file
done
      
# Remove blank files 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/
      find . -type f -size 0 | xargs rm
      cd





# Processing blast output files to get list of effector files to remove as they are identical

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/"$GENOME_SHORT"_"$family"* > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_blast
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_identical_effectors.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_blast /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_blast2
done
done






# This filtering was not working for hopF as the alleles are too closely related 
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF1/"$GENOME_SHORT"_hopF1 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF2-1/"$GENOME_SHORT"_hopF2-1 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF2-2/"$GENOME_SHORT"_hopF2-2 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF2-3/"$GENOME_SHORT"_hopF2-3  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF2-4/"$GENOME_SHORT"_hopF2-4 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF3/"$GENOME_SHORT"_hopF3 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/hopF4/"$GENOME_SHORT"_hopF4 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results
done

for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/"$GENOME_SHORT"* > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"

# Get names of best hits
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_hopF_effectors.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT" /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hits
done


# Processing to get hit !!
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
echo $GENOME_SHORT  
sort -n -r -k5 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hits | sort -n -r -k6 | sed s/HopF4a/hopF4/g | sed s/HopF4b/hopF4/g | sed s/hopF2_Pac_MAFF302273/hopF2-1/g | sed s/hopF2_Pae_089_23/hopF2-2/g | sed s/hopF2_Pae_2250/hopF2-2/g | sed s/hopF2_Pae_NCPPB3681/hopF2-2/g | sed s/hopF2_Pan_MAFF302091/hopF2-2/g | sed s/hopF2_PanPsa-JPT_ICMP9617/hopF2-2/g | sed s/hopF2_PanPsa-V_ICMP18884/hopF2-2/g | sed s/hopF2_Pto_DC3000/hopF2-3/g | sed s/hopF2_Pdp_PDDCC529/hopF2-4/g | sed s/hopF2_Pmp_MAFF302280/hopF2-4/g | sed s/hopF2_Pto_K40/hopF2-4/g | sed s/hopF2_Pto_Max13/hopF2-4/g | sed s/hopF2_Pto_NCPPB1108/hopF2-4/g | sed s/hopF2_Pto_T1/hopF2-4/g   > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF_alleles
done


# Extract the hopF alleles 
# Currently only predicts 2 possible hopF alleles per genome
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
GENOME_FILE=$(basename $GENOME)
GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
echo $GENOME_SHORT  


    for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF_alleles ; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f2 -d " ")
    start1=$(echo $first_hit | cut -f3 -d " ")
    num=100
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF

    while read line; do
        contig2=$(echo $line | cut -f2 -d " ")
        start2=$(echo $line | cut -f3 -d " ")
        if [ "$contig2"  != "$contig1" ] ; then
        echo $line
        fi
    done < $file >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF

    head -2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF  >   /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_2_hopF 
    second_hit=$(head -2 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_2_hopF | tail -1 )
    contig2=$(echo $second_hit | cut -f2 -d " ")
    start2=$(echo $second_hit | cut -f3 -d " ")
    num=100
    start2_up="$(($start2-$num))" 
    start2_up=$(echo $start2_up | sed 's/^-.*/0/')
    start2_down="$(($start2+$num))" 

    while read line; do  
        contig3=$(echo $line | cut -f2 -d " ")
        start3=$(echo $line | cut -f3 -d " ")
        start3_up="$(($start3-$num))"
        start3_up=$(echo $start3_up | sed 's/^-.*/0/')
        start3_down="$(($start3+$num))" 
        if [ "$contig3"  = "$contig2" -a "$start3"  -ge $start2_up -a "$start3" -le $start2_down ] ; then
        continue
        elif [ "$contig3"  = "$contig1" -a "$start3"  -ge $start1_up -a "$start3" -le $start1_down ] ; then
        continue
        else 
        echo $line
        fi
    done <  $file >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_2_hopF


head -2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_2_hopF  >   /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_3_hopF 
sed s/" "/"\t"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_3_hopF |  sed s/"_"/"\t"/g | cut -f1 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF_alleles2

done
done



# Move to new folder !!!
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for hopF in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF_alleles2 ); do
    mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/"$GENOME_SHORT"_"$hopF".fa /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/NT
done

# Get list of files !!!

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

sort -k3 -n -r  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_blast2 | cut -f1 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_files
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_files ; do
    to_keep=$(head -1 $file)

while read line; do
  if [ "$line" != "$to_keep" ] ; then
  echo $line
  fi
 done < $file > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_files_to_delete


# Rename hopF members
for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

for hopF in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/blast_results/results/"$GENOME_SHORT"_hopF_alleles2 ); do

sed s/'>'[0-9]*:[0-9]*-[0-9]*/'>'"$GENOME_SHORT"_"$hopF"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/NT/"$GENOME_SHORT"_"$hopF".fa > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/"$GENOME_SHORT"_"$hopF".fa
#sed s/'>'"$GENOME_SHORT"_"hopF"/'>'"$GENOME_SHORT"_"$hopF"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/"$GENOME_SHORT"_"$hopF".fasta > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/hopF/"$GENOME_SHORT"_"$hopF".fa
done


# Then use this list to remove all effectors that are identical to longest sequence in each effector family folder

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family

for GENOME in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

for delete in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/blast/hits/"$GENOME_SHORT"_files_to_delete ); do
    cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"
    rm "$delete".fa
done
done
done


# Filtering out pseudogenes, contig breaks etc. to build presence, absence matrix of effectors 







# Phylogenetics 

# Can then align all sequences for each effector and do phylogenetic analysis !!!

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
          echo $family
cat  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/*.fa > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$family".fasta
sed s/">"/"\n"">"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$family".fasta > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$family".fa
sed -i '/^$/d' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$family".fa
done






# Alignment
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
    for fasta in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$family".fa ; do 
    file_short=$(basename $fasta)
    Jobs=$(qstat | grep 'sub_clustal' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_clustal' | wc -l)
    done
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_clustal.sh $fasta
done


# Move to alignment folder 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/"$family".fasta /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/alignment/"$family".fasta


# Convert to phylip format and shorten names of strains to allow phylip format 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family
    # Cut back strain name to ensure it is 10 characters or less for phylip
    cut -f1,2 -d "_"  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/alignment/"$family".fasta | sed s/"GCA_"//g | cut -f1 -d "."  
    python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/fasta2phylip.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/alignment/"$family".fasta -o /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/alignment/"$family".phy -r

## Appending names perl -pe 's/$/_$seen{$_}/ if ++$seen{$_}>1 and /^>/; ' hopAW.fas


# Sub raxml phylogenetic tree builder

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family    
    qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_raxml.sh /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/effector_families/new/alignments/"$family".fasta "$family"


# Move to trees folder 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      cp ./RAxML_bipartitions."$family" /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/alignments/trees/"$family".tre






## Additional Filtering to automatically generate heatmap 

# Obtain those effectors that scored lower than threshold in the tBLASTn

# Identify start codon 
# Identify if it is at the end of a contig. 
--> If yes possible contig break
--> If no possible pseudogenisation 

# Identify if location of gene ends at the end of a contig 
--> Possible contig break 

# Identify effectors with premature stop (*) within the BLAST hit and label of possible pseudogenes 




 
