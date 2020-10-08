#################################################################

# Epiphyte assembly pipeline 

#################################################################

# Assembly of 92 genomes from cherry 
# Analysis performed in /projects/cherry_canker/pseudomonas_data/pseudomonas/raw_dna/paired/Pseudomonas_syringae/2018
# Move all the fastq files to the working directory

# Get list of genomes 

cut -f3 -d "," SampleSheet.csv > genomes

# Filtering of adapters and bad quality reads with fastp (as in Chen 2018)

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/raw_dna/paired/Pseudomonas_syringae/2018
for genome in $(cat "$WorkDir"/run4_genomes) ; do 
echo $genome
fastp -i "$WorkDir"/F/run4/"$genome"* -I "$WorkDir"/R/run4/"$genome"* -o "$WorkDir"/filtered/run4/"$genome"_F_cor.fastq  -O  "$WorkDir"/filtered/run4/"$genome"_R_cor.fastq



# Run count_nucl.pl to estimate genome coverage 

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/raw_dna/paired/Pseudomonas_syringae/2018
for genome in $(cat "$WorkDir"/run4_genomes) ; do 
echo $genome
count_nucl.pl -i "$WorkDir"/filtered/run4/"$genome"_F_cor.fastq -i "$WorkDir"/filtered/run4/"$genome"_R_cor.fastq -g 6 > "$WorkDir"/filtered/run4/"$genome"_coverage

# Coverage report
grep "estimated genome coverage" * >> coverage_report
sed s/"_coverage: This equates to an estimated genome coverage of"//g coverage_report  | sed s/" "/"\t"/g | cut -f1,2 > coverage_report2


#################################################################

# SPAdes assembly

################################################################# 

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/raw_dna/paired/Pseudomonas_syringae/2018
for genome in $(cat "$WorkDir"/run4_genomes) ; do 
echo $genome
/home/hulinm/local/src/SPAdes-3.13.0-Linux/bin/spades.py -1 "$WorkDir"/filtered/run4/"$genome"_F_cor.fastq  -2 "$WorkDir"/filtered/run4/"$genome"_R_cor.fastq   -o  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/2018/run4/"$genome"

# Run Quast report on all assemblies 

WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/2018/run4
for genome in $(cat "$WorkDir"/run4_genomes) ; do 
echo $genome
cp "$WorkDir"/"$genome"/contigs.fasta "$WorkDir"/"$genome".fasta 


quast.py "$WorkDir"/*.fasta


#################################################################

# CheckM assembly QC

################################################################# 

# CheckM to check for contamination and completeness of genomes  
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/2018/run4
# Note this was done on old cluster, new slurm commands can be found in reference mapping pipeline mojgan code 
for file in $WorkDir/*.fasta ; do
    file_short=$(basename $file | sed s/".fasta"//g)
    echo $file_short
    mkdir -p ./checkm/"$file_short"/checkm
    cp $file ./checkm/"$file_short"/"$file_short".fa
    Jobs=$(qstat | grep 'checkm' | wc -l)
    while [ $Jobs -gt 5 ]
    do
        sleep 7
        printf "."
        Jobs=$(qstat | grep 'checkm' | wc -l)
    done
    qsub /projects/oldhome/hulinm/git_repos/pseudomonas/sub_checkm.sh $WorkDir/checkm/"$file_short" $WorkDir/checkm/"$file_short"/checkm
done


# Run report to get stats from checkM runs
WorkDir=/projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/2018/run4

for file in $WorkDir/*fasta ; do 
    file_short=$(basename $file | sed s/".fasta"//g)
    
 checkm qa $WorkDir/checkm/"$file_short"/checkm/lineage.ms $WorkDir/checkm/"$file_short"/checkm > $WorkDir/checkm/"$file_short"/checkm/report

done


