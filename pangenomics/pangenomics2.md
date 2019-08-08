# Pseudomonas pangenomics
# Pipeline (adapted Levy 2018) > get all genomes with <1000 contigs (428) > N50 > 40,000 (348) > checkM completeness score >95% complete, <5% contamination 
# All 428 genomes belonging to Ps. species complex Gomila et al. 2017 from the ftp website Sept 2018
# Generated spreadsheet from ftp website 

# Downloaded all onto cluster using wget. Only for those genomes with <1000 contigs 

# Then make prokka database

prokka-genbank_to_fasta_db *gbff > ps.faa
cd-hit -i ps.faa -o ps -T 0 -M 0 -g 1 -s 0.8 -c 0.9
rm -fv ps.faa ps.bak.clstr ps.clstr
makeblastdb -dbtype prot -in ps
mv ps.p* /home/hulinm/local/src/prokka/db/genus/

# Run annotation and gzip file 
for file in ./*.fna ; do 
file_short=$(basename $file | sed s/".fna"//g) 
prokka  --usegenus --genus ps $file --outdir $file_short
gzip $file 
done 


## Filtering of genomes based on GWAS paper (Levy et al. 2018)

# Only keep those with N50 >=40000bp (348 genomes) 50000 as in paper was only 260 genomes. Will need to compare results see if taking down to 40000 is detrimental 
# First run quast.py on all genomes to get report


python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_N50filtered_genomes.py transposed_report.tsv > report2.txt 


for genome in *.fasta ; do
strain=$(basename $genome | sed s/".fasta"//g)
echo $strain
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/rename.py -i $genome -o "$strain".fa
gzip $genome

for file in $(cat /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/quast_results/results_2018_11_05_14_16_39/report2.txt) ; do 
cp "$file".fa ./filtered/
done


# CheckM to check for contamination and completeness of genomes  

for file in ./*.fna ; do
    file_short=$(basename $file | sed s/".fna"//g)
    echo $file_short
   # mkdir -p ./checkm/"$file_short"
   # cp $file ./checkm/"$file_short"
    Jobs=$(qstat | grep 'checkm' | wc -l)
    while [ $Jobs -gt 7 ]
    do
        sleep 7
        printf "."
        Jobs=$(qstat | grep 'checkm' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/sub_checkm.sh ./checkm/"$file_short" ./"$file_short"/checkm
done


# Run report 

for file in ./*fa ; do 
    file_short=$(basename $file | sed s/".fa"//g)
    
 checkm qa /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/checkm/"$file_short"/checkm/lineage.ms /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/checkm/"$file_short"/checkm > /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/checkm/"$file_short"/checkm/report

done


# Remove contaminated genomes 

rm 	GCA_002318025.1_ASM231802v1_genomic.fa
rm 	GCA_000156995.1_ASM15699v1_genomic.fa
rm 	GCA_900103765.1_IMG-taxon_2687453696_annotated_assembly_genomic.fa
rm 	GCA_900103395.1_IMG-taxon_2687453721_annotated_assembly_genomic.fa
rm 	GCA_002318655.1_ASM231865v1_genomic.fa
rm 	GCA_002318015.1_ASM231801v1_genomic.fa
rm 	GCA_001293825.1_Pla107_genomic.fa
rm 	GCA_002318715.1_ASM231871v1_genomic.fa


# Run annotation and gzip file 
for file in ./*.fa ; do 
file_short=$(basename $file | sed s/".fa"//g) 
prokka  --usegenus --genus ps $file --outdir $file_short
done 

prokka  --usegenus --genus ps GCA_000007805.1_ASM780v1_genomic.fa --outdir GCA_000007805.1_ASM780v1_genomic
prokka  --usegenus --genus ps GCA_000012205.1_ASM1220v1_genomic.fa --outdir GCA_000012205.1_ASM1220v1_genomic



# Filtering strains for using in comparative genomics
# Started with 394 strains classified as Pseudomonas syringae 
# Used pyani to filter based on a distance of 0.0005 to remove identical strains from analysis 
# Removed additional duplicate/erroneous genomes 

# Starting strains are those that have been checked with checkm and filtered based on N50. Can be found in 

/home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/fa 


# pyani command to go ANI for each pairwise comparison of strains
python3 /home/hulinm/local/src/pyani/bin/average_nucleotide_identity.py  -i /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/fa -o /data2/scratch2/hulinm/pyani/output -m ANIm -g
python3 /home/hulinm/local/src/pyani/bin/average_nucleotide_identity.py  -i /data2/scratch2/hulinm/realphy/new/ -o /data2/scratch2/hulinm/pyani/234 -m ANIm -g

# Removal of erroneous 2254 genome  GCA_000980905.1_ASM98090v1_genomic.fa 
# Removal of duplicate B301D genome GCA_000585725.1_B301D-Rv1.0_genomic.fa
# Removal of duplicate GCA_000145945.1 
# Removal of duplicate  GCA_003205905.1_ASM320590v1_genomic.fa 
# Removal of duplicate GCA_000935795.1 
# Removal of duplicate GCA_000935735.1 


# Filtering based on pyani results to remove identical genomes 

# Make file with contig no. 
ls *.fa > strain_list
for file in *.fa ; do  contigs=$(grep ">" $file | wc -l) ; echo $contigs >> contigs; done
paste strain_list contigs > strain.info

# Take strains0.0005 data from R and make 246 directories in pyani_filtering directory to copy each genome into its own group. 
# Will then copy only the one with the least contigs into a new folder 

while read line; do
strain=$(echo $line | cut -f1 -d " " ) 
group=$(echo $line |cut -f2 -d " " )
echo $strain
echo $group
cp "$strain".fa ./pyani_filtering/"$group"
done < strains0.0005 

# paste together results from strain.info and strains0.0005 into file called strain.information. 
 
 
awk '{print >> $3; close($3)}' strain.information2  
 
# Remove resulting files to group folder 
mv 1* groups/
mv 2* groups/
mv 3* groups/
mv 4* groups/
mv 5* groups/
mv 6* groups/
mv 7* groups/
mv 8* groups/
mv 9* groups/

for file in * ; do
file_name=$(basename $file)
sort -nk2 $file | head -n1 > "$file_name"_ref
done

cat *ref > reference_strains 

# Manually added in R2leaf as this is our representative strain 
# Ended with 246 genomes in analysis 
# Copy to orthofinder folder for orthology analysis 

# Analysis done in /pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/fa/groups

for file in $(cat strains_to_keep) ; do  cp /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/"$file"/"$file".faa /data2/scratch2/hulinm/orthofinder/formatted; done
for file in $(cat strains_to_keep) ; do  cp /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/additional_genomes/"$file"/"$file".faa /data2/scratch2/hulinm/orthofinder/formatted; done


# Modify all fasta files to remove description and get into correct format for OrthMCL
# Each fasta item must be in format of strain|peg.number

for file in *.faa ; do  
echo $file
file_short=$(basename $file | sed s/".faa"//g | cut -f1 -d ".") 
echo $file_short
sed -e 's/^\(>[^[:space:]]*\).*/\1/' $file | sed s/"_"/"|peg."/g  > "$file_short".fa
done

for file in *.fa ; do  
id=$(less $file | grep ">" | cut -f1 -d "|" | sed s/">"//g | uniq) 
file_short=$(basename $file | sed s/".fa"//g) 
echo $id 
echo $file_short
sed s/"$id"/"$file_short"/g $file > $file_short.fasta

for file in *.fasta ; do  
file_short=$(basename $file | sed s/".fasta"//g) 
mv "$file_short".fasta "$file_short".faa
rm "$file_short".fa
rm *genomic.faa


# OrthoFinder 

/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f reduced -t 16 -S diamond 
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f copy -t 16 -S diamond 
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f SG -t 16 -S diamond 
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f withoutgroup -t 16 -S diamond 
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f withoutP2 -t 16 -S diamond 
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f reduced -t 16 -S diamond 

# Creating matrix of presence and absence 

WorkDir=/data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/withoutP2/Results_May13
perl /home/hulinm/local/src/Phylogenomic/OrthoFinder-NumberOfGenesPerOrthogroupsPerSpecies.pl $WorkDir/Orthogroups.csv > $WorkDir/out_matrix

# Manually add character to first line at the start to make transpose work properly. Then delete after process: 

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
}' $WorkDir/Orthogroups.GeneCount.csv > $WorkDir/Orthogroups.GeneCount.transposed.txt



# Convert all numbers >1 to a 1 in the out matrix 
head -n 1 Orthogroups.GeneCount.transposed.txt > out_matrix_header
awk '{$1=""}1' Orthogroups.GeneCount.transposed.txt | tail -n +2 | nawk '{for(i=1; i<=NF; i++)  $i=($i>=1) ? 1 : $i}1'  > t
printf '%s\n' '0r !head -n 1 out_matrix_header' x | ex t
cut -f1 -d " " Orthogroups.GeneCount.transposed.txt > out_matrix_strains
 # Then manually remove first word (first genome) from t file
 # Manually add strains to first line of out_matrix_strains
paste out_matrix_strains t > out_matrix_pa

# Create a fasta file of this matrix 


sed s/"\t"/" "/g out_matrix_pa > out_matrix_pa2

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/convert_tabfasta.py out_matrix_pa2 > t #Edit python file to no. of genomes
sed s/"', '"//g t | sed s/"\['"//g | sed s/"'\]"//g | sed s/"\""//g > matrix.fasta

perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i matrix.fasta -o matrix.phy -f phylip -g fasta

qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_pa.sh matrix.phy  GTR2 001238485 
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_pa.sh matrix.phy  GTR2+I 001238485 
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_pa.sh  matrix.phy.varsites.phy GTR2+FO+ASC+R5 001238485 

# Try with removal of invariant sites and also removal of orphan sites (present in only 1 genome)
awk '{for(i=1;i<=NF;i++)$i=(a[i]+=$i)}END{print}' out_matrix_pa2 > 2
cat out_matrix_pa2 2 > 3

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
}' 3 > 3.txt

# Find number of columns
head -n1 3.txt |  sed 's/\s/\n/g' | wc -l
# 236 columns 

head -1  3.txt > header
awk '{if ($236 < 234) print }' 3.txt > 4.txt
awk '{if ($236 > 1) print }' 4.txt > 5.txt
cat header 5.txt > 5
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
}' 5 > 6.txt

rev 6.txt | cut -d " " -f 2- | rev > 7.txt


python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/convert_tabfasta.py 7.txt > 7  #Edit python file to no. of genomes
sed s/"', '"//g 7 | sed s/"\['"//g | sed s/"'\]"//g | sed s/"\""//g > red_matrix.fasta
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i red_matrix.fasta -o red_matrix.phy -f phylip -g fasta

qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_pa.sh  red_matrix.phy GTR2+FO+ASC+R5 001238485 
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_pa2.sh  red_matrix1.phy GTR2+FO+ASC+R5  


# Build a phylogeny using raxml from concatenated single copy protein sequences 

# Extract fasta sequences for each orthogroup
# 571 single copy orthogroups
WorkDir=/data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/SG/Results_Apr20

sed s/"OG"/"orthogroup"/g Orthogroups.txt > Orthogroups.txt2
python /home/hulinm/git_repos/tools/pathogen/orthology/orthoMCL/orthoMCLgroups2fasta.py --orthogroups Orthogroups.txt2  --fasta /data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/SG/proteins.fa  --out_dir ./fasta/


for file in $(cat $WorkDir/SingleCopyOrthogroups.txt2) ; do 
echo $file
cp "$file".fa ./single_copy

# Alignment of proteins sequences of each OG 
WorkDir=/data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/Results_Apr09
for fasta in $WorkDir/fasta/single_copy/*.fa  ; do
    file_short=$(basename $fasta | sed s/".fa"//g)
    Jobs=$(qstat | grep 'sub_clustal' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_clustal' | wc -l)
    done
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_clustal.sh $fasta
done



# GBLOCKS to correct alignments 

rm *dnd
rm *fa
rm sub*


for file in *.fasta ; do
Gblocks $file -t=p -d=y #Change -t to p or d for protein/dna
echo $file
done

# rename sequences to make them shorter and compatible with phylogenetic programs 
for fasta in *fasta-gb  ; do
name=$(basename $fasta | sed s/".fasta-gb"//g)
sed 's/peg\.[0-9]*//g' $fasta | sed s/GCA_//g   > ./align/"$name"
done

# Convert to nexus format from fasta
for file in $(cat /data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/Results_Apr09/SingleCopyOrthogroups.txt2) ; do 
echo $file
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i "$file" -o "$file".nxs -f nexus -g fasta

for file in $(cat /data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/Results_Apr09/SingleCopyOrthogroups.txt2) ; do 
echo $file
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i "$file" -o "$file".phy -f phylip -g fasta


# Concatenate single copy orthogroup alignments  
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/concatenate2.py



# Make partition model file 
grep charset combined.nex | sed s/charset//g | sed s/".nxs"//g | sed s/"-gb"//g | sed s/" o"/"o"/g | sed s/";"//g > positions

# Get list of genes in order 
cut -f1 -d " " positions > list 


# Test protein models for each OG

for file in *.phy ; do
    file_short=$(basename $file | sed s/".phy"//g )
    echo $file_short
        Jobs=$(qstat | grep 'sub_protte' | wc -l)
    while [ $Jobs -gt 50 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_protte' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/sub_prottest.sh $file "$file_short"_model
done


# Get best model name into its own file 
for file in *_model 
do
    file_short=$(basename $file | sed s/"_model"//g)
	grep "Best model according to LnL" $file | cut -d " " -f6  >  model_"$file_short"
done

#Edit 
for file in model_* ; do 
file_short=$(basename $file | sed s/"model_"//g)
mv $file ./model/"$file_short"
done

# Remove model files
rm *_model 


# Proteins
for file in $(cat ../list) ; do
cat "$file" >> models
done
# Add in sequence evolution model 

# Make the final partition file 
mkfifo pipe1
mkfifo pipe2
cut -f1 ./model/models > pipe1 & # In order to add orthogroup names in first column
cut -f1,2,3 positions > pipe2 &
paste pipe1 pipe2  > partition
rm pipe1 pipe2

sed s/"\t"/", "/g partition > partition_file

# 561 orthogroups
# Manually edit the nexus concatenated alignment file to change data type from none to protein

perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i combined.nex -o combined.phy -f phylip -g nexus
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i combined2.nex -o combined2.phy -f phylip -g nexus


# Run phylogenetic programs using partition file 

#qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_raxml_partition_aa.sh combined.phy out partition_file
# With outgroup
#qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_raxml_partition_aa_og.sh combined.phy output partition_file 001238485
#qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_raxml_partition_aa_og.sh combined.phy output partition_file 002723595

# IQTREE

# Partitioned mode 
# Use sed to remove the pipe "|"

#  outgroup is 002723595
#awk '{print $0 "+I" }' partition_file > p

qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots2.sh combined.phy  partition_file 001238485 
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots3.sh combined.phy  partition_file  001238485
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_new.sh combined.phy  partition_file  001238485


/home/hulinm/local/src/iqtree-1.6.8-Linux/bin/iqtree -s combined.phy  -bb 1000 -spp partition_file -o 001238485 -wbtl -safe
-s matrix.phy  -bb 1000 -m GTR2 -o 001238485 -wbtl -alrt 1000


# Reducing alignment to only those orthogroups with more than 100 aa as these small partitions may be crashing analysis 


for file in $(cat /data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/Results_Apr09/fasta/single_copy/align/reduced/orthogroups100.txt) ; do
cp ../"$file".nxs . 
done
 

python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/concatenate2.py


# Make partition model file 
grep charset combined.nex | sed s/charset//g | sed s/".nxs"//g | sed s/"-gb"//g | sed s/" o"/"o"/g | sed s/";"//g > positions

# Get list of genes in order 
cut -f1 -d " " positions > list 

# Proteins
for file in $(cat list) ; do
cat ../model/"$file" >> models
done
# Add in sequence evolution model 

# Make the final partition file 
mkfifo pipe1
mkfifo pipe2
cut -f1 models > pipe1 & # In order to add orthogroup names in first column
cut -f1,2,3 positions > pipe2 &
paste pipe1 pipe2  > partition
rm pipe1 pipe2

sed s/"\t"/", "/g partition > partition_file


perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i combined.nex -o combined.phy -f phylip -g nexus
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_new.sh combined.phy  partition_file  001238485
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots_new2.sh combined.phy  001238485




# Running analysis without phylogroup 2 due to toxins 

# Got all names of genomes within P2 into file called P2_to_remove

for file in $(cat P2_to_remove) ; do 
rm GCA_"$file".faa 
done 





# Splitting genomes into phylogroups and re-doing orthology and phylogenetics 
# Analysis performed in /data2/scratch2/hulinm/genomes

for file in $(cat info); do 
echo $file

genome=$(echo $file | cut -d "+" -f1) 
phylogroup=$(echo $file | cut -d "+" -f2)
echo $genome
echo $phylogroup
cp "$genome"* ./phylogroups/"$phylogroup"/
echo $file
done

# Copy over protein aa files to each phylogroup orthofinder directory

for i in `seq 1 27` ; do 

for fasta in ./"$i"/*.fa ; do 
fasta_short=$(basename $fasta | sed s/".fa"//g | cut -f1 -d ".")
echo $fasta_short
cp /data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/"$fasta_short"* ./"$i"/orthofinder
done 

# Run Orthofinder on major phylogroups (1,3,6,11,15) 

# Cluster 1 (P1) with outgroup GCA_900114665 (cluster 3) 31422.pts-0.bio72
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f orthofinder -t 16 -S diamond 

# Cluster 2 (P3) with outgroup GCA_001400735 (cluster 19) 31444.pts-0.bio72
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f orthofinder -t 16 -S diamond 

# Cluster 6 (P2) with outgroup GCA_900105295 (Cluster 11) 31485.pts-0.bio72
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f orthofinder -t 16 -S diamond 

# Cluster 11 (P.cerasi phylogroup) with outgroup GCA_000012245 (Cluster 6) 31506.pts-0.bio72
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f orthofinder -t 16 -S diamond 

# Cluster 15 (Por phylogroup) with outgroup GCA_900235835 (Cluster 1) 31776.pts-0.bio72
/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f orthofinder -t 16 -S diamond 


# Generate phylogeny for each cluster
# Analysis in Results folder of each 
#/data2/scratch2/hulinm/genomes/phylogroups/$i/orthofinder/Results*

mkdir -p fasta/single_copy/align/model
mkdir -p fasta/single_copy/align/iqtree



# Build a phylogeny using raxml from concatenated single copy protein sequences 

# Extract fasta sequences for each orthogroup
WorkDir=/data2/scratch2/hulinm/genomes/phylogroups/15/orthofinder/Results_Apr08
WorkDir=/data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/withoutP2/Results_May13
sed s/"OG"/"orthogroup"/g Orthogroups.txt > Orthogroups.txt2
sed s/"OG"/"orthogroup"/g SingleCopyOrthogroups.txt > SingleCopyOrthogroups.txt2
python /home/hulinm/git_repos/tools/pathogen/orthology/orthoMCL/orthoMCLgroups2fasta.py --orthogroups Orthogroups.txt2  --fasta ../proteins.fa  --out_dir ./fasta/


for file in $(cat $WorkDir/SingleCopyOrthogroups.txt2) ; do 
echo $file
cp "$file".fa ./single_copy
done

# Alignment of proteins sequences of each OG 
WorkDir=/data2/scratch2/hulinm/orthofinder/formatted/reduced/one_outgroup/reduced/copy/withoutP2/Results_May13
for fasta in $WorkDir/fasta/single_copy/*.fa  ; do
    file_short=$(basename $fasta | sed s/".fa"//g)
    Jobs=$(qstat | grep 'sub_clustal' | wc -l)
    while [ $Jobs -gt 100 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_clustal' | wc -l)
    done
qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_clustal.sh $fasta
done


# GBLOCKS to correct alignments 

rm *dnd
rm *fa
rm sub*


for file in *.fasta ; do
Gblocks $file -t=p -d=y #Change -t to p or d for protein/dna
echo $file
done

# rename sequences to make them shorter and compatible with phylogenetic programs 
for fasta in *fasta-gb  ; do
name=$(basename $fasta | sed s/".fasta-gb"//g)
sed 's/peg\.[0-9]*//g' $fasta | sed s/GCA_//g   > ./align/"$name"
done

# Convert to nexus format from fasta
for file in $(cat /data2/scratch2/hulinm/genomes/phylogroups/2/orthofinder/Results_Apr08/SingleCopyOrthogroups.txt2) ; do 
echo $file
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i "$file" -o "$file".nxs -f nexus -g fasta
done

for file in $(cat /data2/scratch2/hulinm/genomes/phylogroups/2/orthofinder/Results_Apr08/SingleCopyOrthogroups.txt2) ; do 
echo $file
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i "$file" -o "$file".phy -f phylip -g fasta



# Concatenate single copy orthogroup alignments  
python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/concatenate.py



# Make partition model file 
grep charset combined.nex | sed s/charset//g | sed s/".nxs"//g | sed s/"-gb"//g | sed s/" o"/"o"/g | sed s/";"//g > positions

# Get list of genes in order 
cut -f1 -d " " positions > list 


# Test protein models for each OG

for file in *.phy ; do
    file_short=$(basename $file | sed s/".phy"//g )
    echo $file_short
        Jobs=$(qstat | grep 'sub_protte' | wc -l)
    while [ $Jobs -gt 50 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'sub_protte' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/sub_prottest.sh $file "$file_short"_model
done

# Get best model name into its own file 
for file in *_model 
do
    file_short=$(basename $file | sed s/"_model"//g)
	grep "Best model according to LnL" $file | cut -d " " -f6  >  model_"$file_short"
done

#Edit 
for file in model_* ; do 
file_short=$(basename $file | sed s/"model_"//g)
mv $file ./model/"$file_short"
done

# Remove model files
rm *_model 


# Proteins
for file in $(cat ../list) ; do
cat "$file" >> models
done
# Add in sequence evolution model 

# Make the final partition file 
mkfifo pipe1
mkfifo pipe2
cut -f1 ./model/models > pipe1 & # In order to add effector names in first column
cut -f1,2,3 positions > pipe2 &
paste pipe1 pipe2  > partition
rm pipe1 pipe2

sed s/"\t"/", "/g partition > partition_file

# 561 orthogroups
# Manually edit the nexus concatenated alignment file to change data type from none to protein

perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i combined.nex -o combined.phy -f phylip -g nexus
perl /home/hulinm/git_repos/tools/analysis/python_effector_scripts/alignment_convert.pl -i combined2.nex -o combined2.phy -f phylip -g nexus


# Run phylogenetic programs using partition file 
# IQTREE

# Partitioned mode 
# Use sed to remove the pipe "|"
sed -i s/"|"//g partition_file
#  outgroup is 002723595 (based on above)

qsub /home/hulinm/git_repos/pseudomonas/orthomcl/sub_iqtree_boots.sh combined.phy  partition_file 900114665 


