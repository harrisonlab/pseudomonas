#################################################################

# tBLASTn pipeline to identify T3 effector genes in Ps genomes

#################################################################



# Performing on all epiphytes, 234 Ps genomes from NCBI as well as newly sequenced strains 
# Genomes location: /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes
# Analysis in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/
# For tidiness the results files have been moved to /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/virulence_genes/effectors
# This includes all SG subset within Ps major phylogroups (after contamination screen on ncbi), minion samples, 234 ncbi genomes, Apple samples from New York, George strains, FPM and apricot strains


# Run tBLASTn script


 for EFFECTOR in /projects/oldhome/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/all/new/*.fasta; do
     EFFECTOR_FILE=$(basename $EFFECTOR)
     EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
     echo $EFFECTOR_SHORT
   # mkdir -p ./"$EFFECTOR_SHORT"/new/output/besthit

for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
  
    Jobs=$(squeue | grep 'sub_tbla' | wc -l)
    while [ $Jobs -gt 20 ]
    do
        srun sleep 10
        printf "."
        Jobs=$(squeue | grep 'sub_tbla' | wc -l)
    done

sbatch /projects/oldhome/hulinm/git_repos/pseudomonas/sub_tblastn_slurm.sh  $GENOME $EFFECTOR /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/"$EFFECTOR_SHORT"

done


# Filter out hits

 for EFFECTOR in /projects/oldhome/hulinm/git_repos/tools/analysis/effector_detection/pathogen/effector_detector/effectorfiles/effectors/fastafiles/files/families/all/new/*.fasta; do
     EFFECTOR_FILE=$(basename $EFFECTOR)
     EFFECTOR_SHORT=$(echo $EFFECTOR_FILE | sed s/.fasta//g)
     echo $EFFECTOR_SHORT
 #    mkdir -p ./"$EFFECTOR_SHORT"/new/output/besthit

for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_t3e_hits.py /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT".hits.txt2 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/"$EFFECTOR_SHORT"/"$GENOME_SHORT"_"$EFFECTOR_SHORT".hits.txt3
done
done

# Move to family folder 
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
     mkdir -p ./"$family"/out
     

for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
    
  #  cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/"$family"*/"$GENOME_SHORT"*.txt3 > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/"$GENOME_SHORT"_initial_results 
  #  cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopA1*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopA2*/"$GENOME_SHORT"*.txt3  > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopA/"$GENOME_SHORT"_initial_results 
    cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopB1*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopB2*/"$GENOME_SHORT"*.txt3  > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopB/"$GENOME_SHORT"_initial_results 

# Combining effectors into correct families 
# cat hopBB, hopX3 and hopF >> hopF
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
    cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopBB*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopX3/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopF/"$GENOME_SHORT"_initial_results > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopF/"$GENOME_SHORT"_initial_results2 
done
# cat avrRps, hopAQ and hopK >> hopK
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
    cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/avrRps*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopAQ*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopK/"$GENOME_SHORT"_initial_results > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopK/"$GENOME_SHORT"_initial_results2 
done
# cat hopAE and hopW >> hopW

for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
    cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopAE*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopW/"$GENOME_SHORT"_initial_results > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopW/"$GENOME_SHORT"_initial_results2 
done
# cat hopAO and hopD >> hopD

for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
    cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopAO*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopD/"$GENOME_SHORT"_initial_results > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopD/"$GENOME_SHORT"_initial_results2 
done
# cat hopAC and hopB >> hopB

for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
    cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/hopAC*/"$GENOME_SHORT"*.txt3 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopB/"$GENOME_SHORT"_initial_results > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/hopB/"$GENOME_SHORT"_initial_results2 
done

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families ); do
      echo $family
     # mkdir -p ./"$family"/results_blast
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
     mv /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/"$GENOME_SHORT"_initial_results2 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/"$GENOME_SHORT"_initial_results
done

# Manually removed folders hopBB, avrRps, hopAQ, hopAE, hopAO and hopAC
# Next split into individual hits based on location in genome and if the hits overlap with each other or not 
# This is done sequentially to ensure up to five separate hits are identified per genome per effector family
# After this, the files will be sorted to chose the best hit per location. This stops closely related alleles e.g. hopBB and hopF being misidentified. Also able to identify duplicate hits across genome
# Currently works on the assumption that the different hits are not within 5kb 

# Get up to five non-overlapping hits into their own files  

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
      echo $family
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT

for file in $WorkDir/"$family"/"$GENOME_SHORT"_initial_results   ; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f2 -d " " )
    start1=$(echo $first_hit | cut -f5 -d " " )
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit >  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t2

while read line; do
    contig2=$(echo $line |  cut -f2 -d " "  )
    start2=$(echo $line |  cut -f5 -d " " )
    if [ "$contig2"  = "$contig1" -a "$start2"  -gt $start1_up -a "$start2" -lt $start1_down ] ; then
	echo $line
	else
	echo $line OTHER
    fi
done < $file >>  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t2

grep -v OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t2 > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_hit1
grep OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t2 | sed s/"OTHER"//g > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t3


for file in $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t3 ; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f2 -d " " )
    start1=$(echo $first_hit | cut -f5 -d " " )
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit >  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t4

while read line; do
    contig2=$(echo $line |  cut -f2 -d " "  )
    start2=$(echo $line |  cut -f5 -d " " )
    if [ "$contig2"  = "$contig1" -a "$start2"  -gt $start1_up -a "$start2" -lt $start1_down ] ; then
	echo $line
	else
	echo $line OTHER
    fi
done < $file >>  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t4

grep -v OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t4 > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_hit2
grep OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t4 | sed s/"OTHER"//g > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t5


for file in  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t5 ; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f2 -d " " )
    start1=$(echo $first_hit | cut -f5 -d " " )
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit >   $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t7

while read line; do
    contig2=$(echo $line |  cut -f2 -d " "  )
    start2=$(echo $line |  cut -f5 -d " " )
    if [ "$contig2"  = "$contig1" -a "$start2"  -gt $start1_up -a "$start2" -lt $start1_down ] ; then
	echo $line
	else
	echo $line OTHER
    fi
done < $file >>  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t7

grep -v OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t7 > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_hit3
grep OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t7 | sed s/"OTHER"//g > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t8


for file in $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t8 ; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f2 -d " " )
    start1=$(echo $first_hit | cut -f5 -d " " )
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit >  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t10

while read line; do
    contig2=$(echo $line |  cut -f2 -d " "  )
    start2=$(echo $line |  cut -f5 -d " " )
    if [ "$contig2"  = "$contig1" -a "$start2"  -gt $start1_up -a "$start2" -lt $start1_down ] ; then
	echo $line
	else
	echo $line OTHER
    fi
done < $file >>  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t10

grep -v OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t10 > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_hit4
grep OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t10 | sed s/"OTHER"//g > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t11


for file in $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t11 ; do
    echo $file
    first_hit=$(head -1 $file )
    contig1=$(echo $first_hit | cut -f2 -d " " )
    start1=$(echo $first_hit | cut -f5 -d " " )
    num=5000
    start1_up="$(($start1-$num))" 
    start1_up=$(echo $start1_up | sed 's/^-.*/0/') # When at start of contig, replace minus number with 0
    start1_down="$(($start1+$num))" 
    echo $first_hit >  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t12

while read line; do
    contig2=$(echo $line |  cut -f2 -d " "  )
    start2=$(echo $line |  cut -f5 -d " " )
    if [ "$contig2"  = "$contig1" -a "$start2"  -gt $start1_up -a "$start2" -lt $start1_down ] ; then
	echo $line
	else
	echo $line OTHER
    fi
done < $file >>  $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t12

grep -v OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t12 > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_hit5
grep OTHER $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t12 | sed s/"OTHER"//g > $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t13
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t2
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t3
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t4
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t5
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t7
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t8
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t10
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t11
rm $WorkDir/"$family"/"$GENOME_SHORT"_initial_results_t12
done

# Remove files with blank data 
# Sort by identity and length and head to get best hit 
# Move to best hit folder and sort into full length, contig break and pseudogenes
# Generate presence-absence data table for each genome 

# Removal of files that contain no hits, first remove empty lines and then remove files with size 0

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
      echo $family

  	cd 	/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/
    sed -i '/^$/d' *initial*
	find . -type f -size 0 | xargs rm
  cd
done


# Sorting by  ID and head of each hit file to get best hit 
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
      echo $family
      #  mkdir -p ./"$family"/out
for i in "$WorkDir"/"$family"/*hit* ; do 
i2=$(basename $i)
sed s/" "/"\t"/g  $i | sort -n -r -k8 | head -n +1 > "$WorkDir"/"$family"/out/"$i2"
done


# Move to best hit folder and sort into full length, contig break and pseudogenes
# Generate presence-absence data table for each genome 
# Get alleles 


# Get blast output for the best hits of each effector 
# alleles
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
      echo $family
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
     head -n +1  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/out/"$GENOME_SHORT"_initial_results_hit* | cut -f1 | grep -v "=" | sed '/^$/d' > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/"$GENOME_SHORT"_initial_results_alleles
done

# Get blast output for the best hits of each effector 
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
      echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
    allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2

    mkdir -p ./"$family"/fasta/
    mkdir -p  ./"$family"/besthit/nucleotide/
    mkdir -p  ./"$family"/besthit/nucleotide/seq/
    mkdir -p  ./"$family"/besthit/alleles/"$allele2"/
    mkdir -p  ./"$family"/besthit/alleles/"$allele2"/out/
    mkdir -p  ./"$family"/besthit/alleles/"$allele2"/protein/
    mkdir -p  ./"$family"/besthit/alleles/"$allele2"/out/pseudo/
    mkdir -p  ./"$family"/besthit/alleles/"$allele2"/out/contig/
    
 
    cp "$WorkDir"/"$family"/out/* "$WorkDir"/"$family"/besthit/
done   

# Extract the protein sequence from this best hit file 

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family


for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/* ; do
fasta_short=$(basename $fasta) 
allele=$(cat $fasta | cut -f1 | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g | sed s/"'"//g)
fasta_shorter=$(echo $fasta_short | sed s/"_initial_results"//g )
echo $fasta_shorter
cut -f10  $fasta  | awk 'BEGIN{print ">'$fasta_shorter'_'$allele'"}1' > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele"/protein/"$fasta_shorter".fa
done


# Move the best hit to this folder based on blast results 
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT

for fasta in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/* ; do
fasta_short=$(basename $fasta) 
allele=$(cat $fasta | cut -f1 | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g | sed s/"'"//g)
fasta_shorter=$(echo $fasta_short | sed s/"_initial_results"//g )
echo $fasta_shorter

grep "$allele" $fasta  > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele"/"$fasta_shorter"



# Filter results by threshold and bin into pseudogenes (*), possible pseudogenes - then filter by position on contig to determine if likely a contig break 
# Create file of allele names correct hits, pseudogenes (*), possible pseudogenes


for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/"$GENOME_SHORT"_initial_results_alleles) ; do 
    allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
for blast in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/"$GENOME_SHORT"* ; do     
echo $blast
blast_shorter=$(basename $blast)
echo $blast_shorter
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_blast2.py $blast  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$blast_shorter"_full /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$blast_shorter"_pseudo 
done
done
done
done



# Remove empty files 
      
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
    allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
cd 	/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out
find . -type f -size 0 | xargs rm
cd    
      
# Remove empty files 

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
    allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
cd 	/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo
find . -type f -size 0 | xargs rm
cd    


# Get list of effector alleles that have a premature stop codon in blast output 

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
    allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2
    grep "*" /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/protein/* >  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops
    cut -f1  -d ":" /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops |  cut -f17  -d "/" | sed s/".fa"//g >  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops2
done  

# Get list of effector alleles that have a premature stop codon in blast output and move the full-length result file to the pseudogenes folder

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
    allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
    echo $allele2

for effector in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$allele2"_prematurestops2 ) ; do 
mv /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$effector"_full /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$effector"_pseudo
done


# Filter the possible pseudogenes by proximity to start or end of particular contig to give a score of pseudogene or contig break  

# First create file with lengths of each contig
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
perl /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/get_contig_info.pl $GENOME > /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/"$GENOME_SHORT".info
done

# Then print output for each blast if at the start or end of a contig into a new file 

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/*_pseudo ; do
file_short=$(basename $file | sed s/"_pseudo"//g)
filename=$(basename $file | sed s/"_pseudo"//g | rev | cut -d "_" -f 2- | rev  )
echo $filename
    python  /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_effector_blast_cb.py $file /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/"$GENOME_SHORT".info > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$file_short"_contigbreaks
done

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
cd 	/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo
find . -type f -size 0 | xargs rm
cd    
done







# Also move putative pseudogenes to pseudogene folder based on the presence of a suitable start AA (M, V, L, I) at the start of the sequence 
# Will need to check these results as will be dependant on the original blast sequence as to whether or not a suitable start AA was present 



    
for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/*/besthit/alleles/*/out/*_full ; do
    path=$(echo $(cd $(dirname "$file") && pwd -P))
    echo $path
    file_name=$(basename $file | sed s/"_full"//g)
    echo $file_name
    python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_blast_start2.py "$path"/"$file_name"_full "$path"/"$file_name"_start_codon

	
# Remove empty files (This need to go to completion)

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
cd 	/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out
find . -type f -size 0 | xargs rm
cd    
done
     

# copy the full file for those that did not have the correct start codon to pseudogene folder 

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/*_start_codon ; do
filename=$(basename $file | sed s/"_start_codon"//g)
echo $filename
cp $file /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/"$filename"_pseudo

done
done


# Remove the full file for those that did not have the correct start codon from the out folder

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2

for file in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/*_start_codon ; do
    filename=$(basename $file | sed s/"_start_codon"//g)
    echo $filename
	rm /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$filename"_full 
	rm /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$filename"_pseudo 
done



# Generate presence absence table of full_length genes by concatenating effector lists 


for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family
for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2

#rm /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/*.txt
#rm /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/*.cb
#rm /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/*.pseudo

ls /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/*_full | xargs -n 1 basename | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "."  | sed s/"_initial"//g | sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_hit3"//g | sed s/"_hit4"//g | sed s/"_hit5"//g    > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt
ls /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/*_pseudo | xargs -n 1 basename | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "."  | sed s/"_initial"//g | sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_hit3"//g | sed s/"_hit4"//g | sed s/"_hit5"//g     > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo
ls /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/pseudo/*_contigbreaks | xargs -n 1 basename | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "."  | sed s/"_initial"//g | sed s/"_hit1"//g | sed s/"_hit2"//g | sed s/"_hit3"//g | sed s/"_hit4"//g | sed s/"_hit5"//g     > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb
done

# Start to create master table

for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family

for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
sed -i "1s/^/${allele2} \n/"  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt 
sed -i "1s/^/${allele2} \n/"  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo
sed -i "1s/^/${allele2} \n/"  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb
uniq /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt2
uniq /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo2
uniq /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb2

done
done


paste -d ',' /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/*/besthit/alleles/*/out/*.txt | column -s $'\t' -tn   > effectors

sed 's/^,/NA,/g' effectors  > effectors2
sed 's/,$/,NA/g' effectors2  > effectors3
sed s/",,"/",NA,"/g effectors3 > effectors4
sed s/",,"/",NA,"/g effectors4 > effectors5





# Create list of genomes tested
for GENOME in /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/epiphytes/*.fa ; do
     GENOME_FILE=$(basename $GENOME)
     GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
     echo $GENOME_SHORT
	echo $GENOME_SHORT | cut -f1,2 -d "_"  | sed s/"GCA_"//g | cut -f1 -d "." >> genome_list
done

# Create presence file (3 for full length, 2 for pseudogene, 1 for contig break) 
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do
echo $family

for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_effector_dict2.py /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".txt2 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".pseudo2 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".cb2 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/genome_list > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".presence
done 
done



# Create file with just result number per genome 
for family in $(cat /projects/oldhome/hulinm/pseudomonas_data/pseudomonas/analysis/effector2016/new/families2 ); do

for allele in $(cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/*_alleles) ; do 
allele2=$( echo $allele | cut -f1 -d "_" |  sed s/"-1"//g | sed s/"-2"//g ) 
echo $allele2
cut -f2 /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".presence >  /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/"$family"/besthit/alleles/"$allele2"/out/"$allele2".presence2
done 

# Paste all effector results together with the genome name to create presence/absence table 
paste -d "," genome_list /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/SG/new/effector_families/*/besthit/alleles/*/out/*.presence2   > effector_list_full

# Get effector list


head -1  ./*/besthit/alleles/*/out/*.txt2 | grep -v "=" | sed '/^$/d' > t

awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' t > effectors

sed s/" "/","/g effectors > effectors2
cat effectors2  effector_list_full > effector_list_full2

# Filter to the exact genomes used in phylogeny 

 python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_data_dict_comma.py effector_list_full strains > effector_table_full






 

