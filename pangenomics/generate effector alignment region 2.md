
#################################################################

# Extracting surrounding region of effector genes for analysis

#################################################################

# Need to do this to obtain surrounding regions for prophage identification 
# This analysis was performed in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/
# Results files have been moved to /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/virulence_genes/effectors/new/effector_families/ for tidiness 

# Process blast file 
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
     echo $family
for hit in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/* ; do
     hit_file=$(basename $hit)
     genome=$(echo $hit_file | cut -f1 -d "n" | cut -f1,2 -d "_" | sed s/"_i"//g )
     echo $genome
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_strand.py $hit > ./nucleotide/nucleotide_region/"$hit_file"
done




# Then get the correct alleles into an info file with strand, contig, start and stop 


# Then split if more than one best hit 



# Rename those that need to be RC 
for locationfile in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/* ; do 
    file_name=$(basename $locationfile) 
    echo $file_name
    strand=$(cut -f8 $locationfile )
    echo $strand
    if [ "$strand"  == "1" ] ; then
    continue
    else 
        cp $locationfile  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/"$file_name"_RC
        rm $locationfile 
    fi
done


# Need to modify locations add and subtract 1000 and then convert any minus numbers to 0 and end of contig to the correct number 

for locationfile in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/* ; do 
    file_name=$(basename $locationfile ) 
    genome=$(echo $file_name | cut -f1 -d "n" | cut -f1,2 -d "_" | sed s/"_i"//g | sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_mi"/"_minion"/g )
    echo $genome
    python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_info_file3.py $locationfile /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/"$genome".info > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/"$file_name".info
done

# For larger region
for locationfile in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/* ; do 
    file_name=$(basename $locationfile | sed s/"_H3_strand"//g  ) 
    path=$(echo $(cd $(dirname "$locationfile") && pwd -P))
    family=$(echo $path | rev | cut -f3 -d "/" | rev)
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g |  sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_mi"/"_minion"/g | sed s/"_minionnion"/"_minion"/g )
    echo $family
    echo $genome
    python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/edit_info_file_100kb.py $locationfile /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/"$genome".info  > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/"$file_name".info
done






# Extract sequence from genome 

for locationfile in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/*info ; do 
    file_name=$(basename $locationfile | sed s/".info"//g ) 
    genome=$(echo $file_name | cut -f1 -d "n" | cut -f1,2 -d "_" | sed s/"_i"//g | sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_mi"/"_minion"/g )
    echo $locationfile
    echo $file_name
    echo $genome
    Jobs=$(squeue | grep 'extract' | wc -l)
    while [ $Jobs -gt 20 ]
    do
        srun sleep 10
        printf "."
        Jobs=$(squeue | grep 'extract' | wc -l)
    done

    sbatch /projects/oldhome/hulinm/git_repos/pseudomonas/extract_seq2.sh  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/"$genome".fa $locationfile "$file_name".fasta
done



# Larger region
for locationfile in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/*info ; do 
    file_name=$(basename $locationfile | sed s/".info"//g ) 
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g |  sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_mi"/"_minion"/g | sed s/"_minionnion"/"_minion"/g )
    echo $locationfile
    echo $file_name
    echo $genome
    Jobs=$(squeue | grep 'extract' | wc -l)
    while [ $Jobs -gt 20 ]
    do
        srun sleep 10
        printf "."
        Jobs=$(squeue | grep 'extract' | wc -l)
    done

    sbatch /projects/oldhome/hulinm/git_repos/pseudomonas/extract_seq2.sh  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/"$genome".fa $locationfile "$file_name".fasta
done




# Reverse complement those with RC at the end 
# Then need to reverse complement RC files and overwrite NT.fasta files that contain seq that should have been RC 
for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/*RC.fasta ; do 
    file_name=$(basename $fasta | sed s/"_RC.fasta"//g  ) 
    genome=$(echo $file_name | cut -f1 -d "n" | cut -f1,2 -d "_" | sed s/"_i"//g | sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_mi"/"_minion"/g )
    echo $genome
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/reverse_complement.py $fasta > "$file_name".fasta

for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/*RC.fasta ; do 
    file_name=$(basename $fasta | sed s/"_RC.fasta"//g  ) 
    genome=$( echo $file_name | sed s/"_2$"//g | sed s/"_1$"//g | sed s/"_1_RC$"//g | sed s/"_2_RC$"//g | sed s/"_RC$"//g |  sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_mi"/"_minion"/g | sed s/"_minionnion"/"_minion"/g )
    echo $genome
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/reverse_complement.py $fasta > "$file_name".fasta



# Then remove all _RC files !!!
for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/*RC.fasta ; do 
    rm $fasta
    
for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/*RC.fasta ; do 
    rm $fasta
     
    # Need to replace name of sequence within each fasta file with name of strain and effector

# Modify name to genome name 

for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/*.fasta ; do 
    file_name=$(basename $fasta | sed s/".fasta"//g  ) 
    genome=$(echo $file_name | cut -f1 -d "n" | cut -f1,2 -d "_" | sed s/"_i"//g )
    echo $genome
    sed s/'>'[0-9]*:[0-9]*-[0-9]*/'>'"$file_name"/g $fasta | sed s/">"/"\n"">"/g  > "$file_name".fa
done

for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/*.fasta ; do 
    file_name=$(basename $fasta | sed s/".fasta"//g  ) 
    genome=$(echo $file_name | cut -f1 -d "n" | cut -f1,2 -d "_" | sed s/"_i"//g )
    echo $genome
    sed s/'>'[0-9]*:[0-9]*-[0-9]*/'>'"$file_name"/g $fasta | sed s/">"/"\n"">"/g  > "$file_name".fa
done

# concatenate to generate effector family file 

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
     echo $family
      cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/*.fa > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/hopAR.fa 
      sed -i '/^$/d' /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/hopAR.fa 
done


      cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/*.fa > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/hopAR.fa 
      sed -i '/^$/d' /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopAR/besthit/alleles/hopAR1/nucleotide/nucleotide_region/100kb/hopAR.fa 



    