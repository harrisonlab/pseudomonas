# Get blast output files for all pangenomics isolates and SG strains 
# Commands used to get correct allele then determine if a possible pseudogene vs. if at the end of a contig 


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
     # mkdir -p ./"$family"/results_blast
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    
    cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/"$family"*/"$GENOME_SHORT"* > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results 


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family 
      for GENOME in $(cat /data2/scratch2/hulinm/genomes/withSG/list) ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
      cat ./"$family"*/"$GENOME_SHORT"*   > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results 


# Modify hopA and hopB folders to remove additional effectors
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

#grep -e "hopA1" -e "hopA2" "$GENOME_SHORT"_initial_results > "$GENOME_SHORT"_initial_results1
#grep -e "hopB1" "$GENOME_SHORT"_initial_results > "$GENOME_SHORT"_initial_results1

mv "$GENOME_SHORT"_initial_results1 "$GENOME_SHORT"_initial_results



# Repeat of the filtering of best hits to include the full effector description in order to filter out the pseudogenes described in T3SS (pseudomonassyringae.org) spreadsheet. Will use the names to move any described as full-length in the final analysis to the pseudogene folder

# First modify the results file to rename any duplicate alleles e.g. hopAY1 is present twice in Pph and both labelled the same 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_duplicates.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results2
done
done

# Process blast file 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_effector_blast.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits
done



# Processing to get best hit. Sort by Per-ID, Per-Length, Contig no. and Length of hit
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

sort -n -r -k7 -k6 -k3 -k2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits    > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits2
done


# Filter by best hit and check if overlapping contigs to see if more than one hit available. Currently only picks up two max
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)

    for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_hits2; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f3 -d " ")
    start1=$(echo $first_hit | cut -f4 -d " ")
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H1

    while read line; do
        contig2=$(echo $line | cut -f3 -d " ")
        start2=$(echo $line | cut -f4 -d " ")
        if [ "$contig2"  != "$contig1" ] ; then
        echo $line
        fi
    done < $file >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H1

    head -2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H1  >   /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2
    second_hit=$(head -2 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2  | tail -1 )
    contig2=$(echo $second_hit | cut -f3 -d " ")
    start2=$(echo $second_hit | cut -f4 -d " ")
    num=5000 # Modified to 5000 to stop hopAB1 and hopAB4 in Psm R1 5300 which are both same hit coming out as two seperate hits. 
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
    done <  $file >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2 


head -2  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H2  >   /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H3
sed s/" "/"\t"/g /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H3 |  cut -f1 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4

done
done




# Make directories for storing hits and determining pseudogenes etc. 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family 
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/*_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
    rm ./"$family"/fasta/*
    rm ./"$family"/besthit/nucleotide/*
    rm ./"$family"/besthit/nucleotide/seq/*
    rm ./"$family"/besthit/alleles/"$allele2"/*
    rm ./"$family"/besthit/alleles/"$allele2"/out/*
    rm ./"$family"/besthit/alleles/"$allele2"/protein/*
    rm ./"$family"/besthit/alleles/"$allele2"/out/pseudo/*
    rm ./"$family"/besthit/alleles/"$allele2"/out/contig/*
    

# Move protein sequence to fasta folder 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in  $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    echo $GENOME_SHORT
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
 #   grep "$allele" /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results2 | cut -f13 | awk 'BEGIN{print ">'$GENOME_SHORTER'_'$allele'"}1' | head -2 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/fasta/"$GENOME_SHORTER"_"$allele".fasta
    cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/fasta/"$GENOME_SHORTER"_"$allele".fasta  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/protein/"$GENOME_SHORT"_"$allele".fasta
done
done
done


# Move the best hit to this folder based on blast results 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g | sed s/'"'//g  | sed s/"'"//g  )
    echo $allele2
grep -w "$allele" /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_initial_results2 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/"$GENOME_SHORT"_"$allele"





# Filter results by threshold and bin into pseudogenes (*), possible pseudogenes - then filter by position on contig to determine if likely a contig break 
# Create file of allele names correct hits, pseudogenes (*), possible pseudogenes


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
for blast in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/"$GENOME_SHORT"_"$allele" ; do     
echo $blast
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_blast2.py $blast /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$GENOME_SHORT"_"$allele"_full  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$GENOME_SHORT"_"$allele"_pseudo 
done
done
done
done

# Remove empty files 
      
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out
find . -type f -size 0 | xargs rm
cd    
      
# Remove empty files 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo
find . -type f -size 0 | xargs rm
cd    


# Get list of effector alleles that have a premature stop codon in blast output 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    grep "*" /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/protein/* >  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops
    cut -f1  -d ":" /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops |  cut -f16  -d "/" | sed s/".fasta"//g >  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops2
done

# move the full-length result file to the pseudogenes folder for those with premature stop codons

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
for effector in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops2 ) ; do 
    echo $effector 
mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$effector"_full /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$effector"_pseudo
done
done
done
done



# Remove empty files 


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo
find . -type f -size 0 | xargs rm
cd    

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/
find . -type f -size 0 | xargs rm
cd  
     
     
     
     
      


# Define those effectors thats best hit was to known pseudogenes within Ps 


# First create list of all results files 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
      ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/*H4  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_all
      rev /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_all | cut -f1 -d "/" | rev > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_all2
      mv /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_all2 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_all
done

# Then work out which besthit files contain only known pseudogenes (this should filter out those that have both full length and pseudogenes, and only print those which all besthits are pseudogenes)

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4 ; do 
file_name=$(basename $file) 

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_non-pseudogenes.py $file /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/known_pseudogenes2 >> /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_nonpseudogenes
rev /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_nonpseudogenes | cut -f1 -d "/" | rev  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_nonpseudogenes2
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_pseudogenes.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_all /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_nonpseudogenes2 > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_pseudogenes
done
done
done


#### Move known pseudogene effector to the pseudogene folder 

# example: GCA_900099665.1_IMG-taxon_2687453723_annotated_assembly_genomic_avrE1_Psy_61_full
GCA_000163315.1

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 

for pseudogene in  $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_pseudogenes) ; do 
pseudogene2=$(echo $pseudogene | sed s/"_H4"//g) 
cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$pseudogene2"* /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/
done
done
done
done

#### Rename full file to pseudo within pseudogene folders 


for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/pseudo/*_full ; do 
    path=$(echo $(cd $(dirname "$file") && pwd -P))
    echo $path
    file_name=$(basename $file | sed s/"_full"//g)
    echo $file_name
    cp $file $path/"$file_name"_pseudo

# Remove full file of pseudogene from the out folder
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
for pseudogene in  $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$family"_pseudogenes) ; do 
    pseudogene2=$(echo $pseudogene | sed s/"_H4"//g) 
	rm /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$pseudogene2"*

done
done
done
done

# Then remove full files from pseudo folder
rm /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/pseudo/*full 





# Also move putative pseudogenes to pseudogene folder based on the presence of a suitable start AA (M, V, L, I) at the start of the sequence 
# Will need to check these results as will be dependant on the original blast sequence as to whether or not a suitable start AA was present 


	
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/*_full ; do 
    path=$(echo $(cd $(dirname "$file") && pwd -P))
    echo $path
    file_name=$(basename $file | sed s/"_full"//g)
    echo $file_name
    head -1 $file | sed 's/\s\+/\t/g' >  "$path"/"$file_name"_2
    python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_blast_start.py "$path"/"$file_name"_2 "$path"/"$file_name"_start_codon
	rm "$path"/"$file_name"_2
	
# Remove empty files (This need to go to completion!)

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out
find . -type f -size 0 | xargs rm
cd    
    
     

# copy the full file for those that did not have the correct start codon to pseudogene folder 


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$GENOME_SHORT"_"$allele"_start_codon ; do 
    file_name=$(basename $file | sed s/"_start_codon"//g)
    echo $file_name
cp /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$file_name"_start_codon  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$file_name"_pseudo
done
done
done
done
done


# Remove the full file for those that did not have the correct start codon from the out folder


for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/*_start_codon ; do 
    file_name=$(basename $file | sed s/"_start_codon"//g)
    echo $file_name

	rm /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/"$file_name"_full
done

# Filter the possible pseudogenes by proximity to start or end of particular contig to give a score of pseudogene or contig break  

# First create file with lengths of each contig
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/get_contig_info.pl $GENOME > /data2/scratch2/hulinm/genomes/"$GENOME_SHORT".info
done

#Then print output for each blast if at the start or end of a contig into a new file 

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    
for file in /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$GENOME_SHORT"_"$allele"_pseudo ; do
    file_short=$(basename $file | sed s/"_pseudo"//g)
    echo $file_short

    python  /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_effector_blast.py $file /data2/scratch2/hulinm/genomes/"$GENOME_SHORT".info > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/contig/"$file_short"_contigbreaks
done


# Remove empty files 


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo
find . -type f -size 0 | xargs rm
cd    

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
    
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/contig/
find . -type f -size 0 | xargs rm
cd  

for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    
cd 	/home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/
find . -type f -size 0 | xargs rm
cd  


 


# Manually check those that had contig breaks to check if they are true pseudogenes or likely to be full length just disrupted by the contig break 


# Generate presence absence table of full_length genes by concatenating effector lists 



for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
  
ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/*_full | xargs -n 1 basename | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "."  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt
ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/pseudo/*_pseudo | xargs -n 1 basename | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "."  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo
ls /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/contig/*_contigbreaks | xargs -n 1 basename | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "."  > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb
done


for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family 
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/"$GENOME_SHORT"_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2 >> alleles
    
    sort alleles | uniq > allele_list 
    
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/allele_list ); do
sed -i 's/_avr[^ ]*//g' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".txt
sed -i 's/_avr[^ ]*//g' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".cb
sed -i 's/_avr[^ ]*//g' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".pseudo
sed -i 's/_hop[^ ]*//g' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".txt
sed -i 's/_hop[^ ]*//g' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".cb
sed -i 's/_hop[^ ]*//g' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".pseudo
done


for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/allele_list ); do
sed -i "1s/^/${allele} \n/"  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".txt
sed -i "1s/^/${allele} \n/"  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".pseudo
sed -i "1s/^/${allele} \n/"  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/"$allele"/out/"$allele".cb
done


paste -d ',' /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/*.txt | column -s $'\t' -tn   > effectors

sed 's/^,/NA,/g' effectors  > effectors2
sed 's/,$/,NA/g' effectors2  > effectors3
sed s/",,"/",NA,"/g effectors3 > effectors4
sed s/",,"/",NA,"/g effectors4 > effectors5



# Create list of genomes tested
for GENOME in /data2/scratch2/hulinm/genomes/*.fa ; do
      GENOME_FILE=$(basename $GENOME)
      GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
	echo $GENOME_SHORT | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "." >> genome_list
done

# Create presence file (3 for full length, 2 for pseudogene, 1 for contig break) 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family 
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/*_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g )  
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_effector_dict2.py /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/genome_list > /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".presence
done 
done

# Create file with just result number per genome 
for family in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
    echo $family 
for allele in $(cat /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/results_blast/*_H4) ; do 
    allele2=$(echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g )  
cut -f2 /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".presence >  /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/"$family"/besthit/alleles/"$allele2"/out/"$allele2".presence2
done 

# Paste all effector results together with the genome name to create presence/absence table 
paste -d "," genome_list /home/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/*.presence2   > effector_list_full

# Filter to the exact genomes used in phylogeny 

 python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_data_dict_comma.py effector_list_full strains > effector_table_full


