
# Repeat of the filtering of best hits to include the full effector description in order to filter out the pseudogenes described in T3SS (pseudomonassyringae.org) spreadsheet. Will use the names to move any described as full-length in the final analysis to the pseudogene folder

# Process blast file 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in  //data2/scratch2/hulinm/genomes/withSG/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_effector_blast_strand.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits_strand
done

# Processing to get best hit. Sort by Per-ID, Per-Length, Contig no. and Length of hit
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in  /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
echo $GENOME_SHORT  
sort -n -r -k7 -k6 -k3 -k2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits_strand    > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits2_strand
done


# Filter by best hit and check if overlapping contigs to see if more than one hit available. Currently only picks up two max
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in  /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
GENOME_FILE=$(basename $GENOME)
GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
echo $GENOME_SHORT  


    for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits2_strand; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f3 -d " ")
    start1=$(echo $first_hit | cut -f4 -d " ")
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H1_strand

    while read line; do
        contig2=$(echo $line | cut -f3 -d " ")
        start2=$(echo $line | cut -f4 -d " ")
        if [ "$contig2"  != "$contig1" ] ; then
        echo $line
        fi
    done < $file >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H1_strand

    head -2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H1_strand  >   /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2_strand
    second_hit=$(head -2 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2_strand  | tail -1 )
    contig2=$(echo $second_hit | cut -f3 -d " ")
    start2=$(echo $second_hit | cut -f4 -d " ")
    num=5000 # Modified to 5000 to stop hopAB1 and hopAB4 in Psm R1 5300 which are both same hit coming out as two seperate hits 
    start2_up="$(($start2-$num))" 
    start2_up=$(echo $start2_up | sed 's/^-.*/0/')
    start2_down="$(($start2+$num))" 

    while read line; do  
        contig3=$(echo $line | cut -f3 -d " ")
        start3=$(echo $line | cut -f4 -d " ")
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
    done <  $file >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2_strand 


head -2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2_strand  >   /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H3_strand
sed s/" "/"\t"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H3_strand |  cut -f1 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4_strand

done
done



# Then get the correct alleles into an info file with strand, contig, start and stop 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/*_H3_strand /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide
done

# Remove empty files

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
echo $family 
cd /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide/
sed -i '/^$/d' *
find . -type f -size 0 | xargs rm
cd  

# Then split if more than one best hit 

for locationfile in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/nucleotide/*H3_strand ; do 
    file_name=$(basename $locationfile | sed s/"_H3_strand"//g  ) 
    echo $file_name
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    line=$(wc -l $locationfile | cut -f1 -d " ")
    echo $line
    if [ "$line"  == "1" ] ; then
    continue
    else 
        tail -1 $locationfile > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide/"$file_name"_2
        head -1  $locationfile > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide/"$file_name"_1
        rm $locationfile 
    fi
done


# Rename those that need to be RC 
for locationfile in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/nucleotide/* ; do 
    file_name=$(basename $locationfile | sed s/"_H3_strand"//g  ) 
    echo $file_name
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    strand=$(cut -f8 -d " " $locationfile )
    echo $strand
    if [ "$strand"  == "1" ] ; then
    continue
    else 
        cp $locationfile  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide/"$file_name"_RC
        rm $locationfile 
    fi
done


# Need to modify locations add and subtract 1000 and then convert any minus numbers to 0 and end of contig to the correct number 

for locationfile in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/nucleotide/* ; do 
    file_name=$(basename $locationfile | sed s/"_H3_strand"//g  ) 
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g )
    echo $family
    echo $genome
    python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_info_file2.py $locationfile /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$genome".info > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide/"$file_name".info
done

# For larger region
for locationfile in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/nucleotide_region/* ; do 
    file_name=$(basename $locationfile | sed s/"_H3_strand"//g  ) 
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g )
    echo $family
    echo $genome
    python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_info_file_100kb.py $locationfile /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$genome".info > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide_region/"$file_name".info
done






# Extract sequence from genome 

for locationfile in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/nucleotide/*.info ; do 
    file_name=$(basename $locationfile | sed s/".info"//g  ) 
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g )
    echo $family
    echo $genome
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    while [ $Jobs -gt 50 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/extract_seq.sh  /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/"$genome".fa $locationfile /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide/seq/"$file_name".fasta
done

# Larger region
for locationfile in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/hopAR/besthit/nucleotide_region/*.info ; do 
    file_name=$(basename $locationfile | sed s/".info"//g  ) 
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g )
    echo $family
    echo $genome
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    while [ $Jobs -gt 50 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'extract_se' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/extract_seq.sh  /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/"$genome".fa $locationfile /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/nucleotide_region/seq/"$file_name".fasta
done




# Reverse complement those with RC at the end 
# !!!!!!!! Then need to reverse complement RC files and overwrite NT.fasta files that contain seq that should have been RC 
for fasta in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/*/besthit/nucleotide/seq/*RC.fasta ; do 
    file_name=$(basename $fasta | sed s/"_RC.fasta"//g  ) 
    path=$(echo $(cd $(dirname "$fasta") && pwd -P))
    family=$(echo $path | rev | cut -f4 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g )
    echo $family
    echo $genome
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/reverse_complement.py $fasta > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/besthit/nucleotide/seq/"$file_name".fasta



# Then remove all _RC files !!!
for fasta in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/*/besthit/nucleotide/seq/*.fa ; do 
    rm $fasta
    
    
    # Need to replace name of sequence within each fasta file with name of strain and effector

# Modify name to genome name 

for fasta in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/*/besthit/nucleotide/seq/*.fasta ; do 
    file_name=$(basename $fasta | sed s/"_RC.fasta"//g  ) 
    path=$(echo $(cd $(dirname "$fasta") && pwd -P))
    family=$(echo $path | rev | cut -f4 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g )
    echo $family
    echo $genome

    sed s/'>'[0-9]*:[0-9]*-[0-9]*/'>'"$file_name"/g $fasta | sed s/">"/"\n"">"/g  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/besthit/nucleotide/seq/"$file_name".fa
done

# concatenate to generate effector family file 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/besthit/nucleotide/seq/*.fa > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/besthit/nucleotide/seq/"$family".fa 
      sed -i '/^$/d' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/"$family"/besthit/nucleotide/seq/"$family".fa 
done



    
