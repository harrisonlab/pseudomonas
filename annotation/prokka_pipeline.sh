#### Prokka genome annotation #### 
 
# 12.03.18 Downloaded all Pseudomonas syringae group complete genome NCBI accession numbers to build database for Prokka annotation
# This included complete chromosomes and plasmids (102 total)
# Accession list was used to find all records on genbank and download as one file 

# Split by "//" into separate files and then remove any files that have blank space in their first line  

awk -v n=1 '/^\/\//{close("out"n);n++;next} {print > "out"n}' complete_genomes.gb 

find -type f | xargs sed -i -e '2,$b' -e '/^$/d' 


# rename each file as its accession number 

for file in out* ; do
accession=$(head -1 $file | tr -s ' ' | cut  -d " " -f2)
echo $accession
mv $file "$accession".gbk
done


# Create a database for prokka 
prokka-genbank_to_fasta_db *gbk > ps.faa
cd-hit -i ps.faa -o ps -T 0 -M 0 -g 1 -s 0.8 -c 0.9
rm -fv ps.faa ps.bak.clstr ps.clstr
makeblastdb -dbtype prot -in ps
mv ps.p* /home/hulinm/local/src/prokka/db/genus/


# Run Prokka 

prokka  --usegenus --genus ps /home/hulinm/pseudomonas_data/pseudomonas/assembly/111_genomes/5244.fasta
