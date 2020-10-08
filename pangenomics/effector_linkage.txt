#################################################################

# Effector genomic linkage analysis 

#################################################################

# This analysis aimed to pull out t3 effector genes within 10kb of each other on each genome to look into those that may be acquired together
# This analysis was done on 234 genomes (not including the epiphyte set used in later analysis) 
# There were some slight issues with misidentification in this preliminary analysis 
   # E.g. hopAE and hopW being incorrectly assigned (same gene) and therefore show linkage
   # This should not be a problem in the later analysis as these families were brought together correctly 
# Therefore, this analysis has not been done on the final dataset and should be repeated !
# Work was done in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/pergenome/
# Results were subsequently moved to /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector_linkage for tidiness 

# Create list of effectors in each genome 
for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT
cat /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/"$GENOME_SHORT"* /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/*/besthit/alleles/*/out/pseudo/"$GENOME_SHORT"* | cut -f1,5,11,12 | sort -n -k2,2n -k3,3n > /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/pergenome/"$GENOME_SHORT"


# Find effectors that are within 10K of each other 
for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT
    python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/get_linked_effectors.py ./pergenome/"$GENOME_SHORT" ./pergenome/"$GENOME_SHORT" > ./pergenome/"$GENOME_SHORT"_linked
done

for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT
    sort ./pergenome/"$GENOME_SHORT"_linked | uniq > ./pergenome/"$GENOME_SHORT"_linked2
    
 # Transpose columns and rows   
 for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT 
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
}' ./pergenome/"$GENOME_SHORT"_linked2 > ./pergenome/"$GENOME_SHORT"_linked3

# Sort each column in alphabetical order. Currently 58 maximum, would need to automate this

for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT    
    paste <(awk '{print $1}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $2}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $3}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $4}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $5}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $6}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $7}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $8}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $9}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $10}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $11}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $12}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $13}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $14}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $15}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $16}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $17}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $18}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $19}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $20}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $21}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $22}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $23}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $24}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $25}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $26}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $27}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $28}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $29}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $30}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $31}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $32}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $33}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $34}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $35}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $36}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $37}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $38}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $39}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $40}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $41}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $42}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $43}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $44}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $45}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $46}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $47}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $48}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $49}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $50}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $51}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $52}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $53}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $54}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $55}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $56}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $57}'  "$GENOME_SHORT"_linked3 | sort ) <(awk '{print $58}'  "$GENOME_SHORT"_linked3 | sort ) > "$GENOME_SHORT"_linked4


 # Transpose  back 
 for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT 
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
}' ./pergenome/"$GENOME_SHORT"_linked4 > ./pergenome/"$GENOME_SHORT"_linked5



for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    echo $GENOME_SHORT
    sort -u "$GENOME_SHORT"_linked5 > "$GENOME_SHORT"_linked6


cat *linked6 | sed s/"-2"//g | sed s/"-1"//g | awk -F, 'sub("_",",",$1)' OFS=\t  | sed s/" "/","/g | cut -d "," -f1,3 | cut -f1 -d "_" | sed s/","/"\t"/g | sort | uniq -c | awk -v OFS="\t" '$1=$1' | sort -nk1 > interactions
  
# Add strain cluster number onto end of linkage file
 for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    cluster=$(grep "$GENOME_SHORT" strain_clusters | cut -d " " -f2)    
    sed 's/^/'$cluster' /' "$GENOME_SHORT"_linked6 > "$GENOME_SHORT"_linked7

cat *linked7 | sed s/"-2"//g | sed s/"-1"//g | awk -F, 'sub("_",",",$1)' OFS=\t | sed s/" "/","/g | cut -d "," -f1,2,4 | cut -f1 -d "_" | sed s/","/"\t"/g | sort -k1 | uniq | cut -f2,3 | sort | uniq -c  | awk -v OFS="\t" '$1=$1' | sort -nk1 > interactions3


#################################################################

# Phylogenetic weighting

#################################################################


# Next move onto weighting the results based on the topology (due to the biased sample structure). Getting interactions per unique clade rather than each strain. 
# Using the weighting will provide phylogenetic context to each interaction 
# E.g. currently many cherry and kiwifruit strains
# Use pyani to get the ANI and cluster strains that are very closely related. 
# Can then generate a unique clade ID and filter results per clade 

# Run pyani 
 
python3 /projects/oldhome/hulinm/local/src/pyani/bin/average_nucleotide_identity.py  -i /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/fa -o /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/pyani/output -m ANIm -g
 
# Manually edit in excel to convert ANI matrix into a distance matrix (complement of 1)  
# Cluster strains in R based on distance 
matrix<-read.table("/Users/hulinm/Documents/ani_matrix3.txt", col.names=,1, row.names=1)
ma<-as.matrix(matrix)
di<-dist(ma)
d<-hclust(di, method = "average")
distances<-cophenetic(d)
dend <- as.dendrogram(d)
d2<-as.matrix(distances)
d3<-melt(d2)
write.table(d3, file="distances")
groups<-cutree(d, h=0.05)
write.table(groups, file="g0.5")
groups<-cutree(d, h=0.04)
write.table(groups, file="g0.4")
groups<-cutree(d, h=0.03)
write.table(groups, file="g0.3")
groups<-cutree(d, h=0.02)
write.table(groups, file="g0.2")
groups<-cutree(d, h=0.01)
write.table(groups, file="g0.1")
groups<-cutree(d, h=0.005)
write.table(groups, file="g0.005")
groups<-cutree(d, h=0.001)
write.table(groups, file="g0.001")
groups<-cutree(d, h=0.0005)
write.table(groups, file="g0.0005")
groups<-cutree(d, h=0.0001)
write.table(groups, file="g0.0001")

# Dendrogram plot 
pdf(file = "/Users/hulinm/Documents/effector_dendrogram2.pdf",width=15,height=7)
par(cex=0.2)
plot(dend)
abline(h=0.01, col="red")
abline(h=0.02, col="blue")
abline(h=0.03, col="green")
abline(h=0.04, col="orange")
abline(h=0.05, col="purple")
abline(h=0.005, col="darkgreen")
abline(h=0.001, col="lightblue")
abline(h=0.0005, col="pink")
abline(h=0.0001, col="lightgreen")

dev.off()

# Add strain cluster onto end of linkage file
 for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g)
    cluster=$(grep "$GENOME_SHORT" g0.4 | cut -d " " -f2)    
    sed 's/^/'$cluster' /' ../"$GENOME_SHORT"_linked6 > "$GENOME_SHORT"_linked0.4

cat *linked0.4 | sed s/"-2"//g | sed s/"-1"//g | awk -F, 'sub("_",",",$1)' OFS=\t | sed s/" "/","/g | cut -d "," -f1,2,4 | cut -f1 -d "_" | sed s/","/"\t"/g | sort -k1 | uniq | cut -f2,3 | sort | uniq -c  | awk -v OFS="\t" '$1=$1' | sort -nk1 > interactions0.4





# Weight based on pairwise distance of strains with each interaction

# For each interaction get the list of genomes this is occurring in 

# Analysis done in /pseudomonas_data/pseudomonas/analysis/effector2016/pangenomics/effector_families/60-60/pergenome/weighting

cut -f2,3 interactions3 > interactions4
split -l 1 interactions4
mv x* weighting
sed -i s/"\t"/_/g x* 

for file in x* ; do 
file_short=$(basename $file)
echo $file

for combination in $(cat $file) ; do 
first=$(echo $combination | cut -f1 -d "_") 
second=$(echo $combination | cut -f2 -d "_") 
echo $first
echo $second

for GENOME in  /projects/cherry_canker/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/gbff/fna/filtered/*.fa ; do
    GENOME_FILE=$(basename $GENOME)
    GENOME_SHORT=$(echo $GENOME_FILE | sed s/.fa//g) 
    grep $first ../"$GENOME_SHORT"_linked6 | grep $second > "$GENOME_SHORT"_"$file_short"
done
done

# Remove empty files
find . -type f -size 0 | xargs rm

mkdir interactions
mv GCA* interactions

for file in ../x* ; do 
file_short=$(basename $file)
effectors=$(less $file)
echo $effectors
echo $file
ls *"$file_short" | cut -f1 -d "." >> "$effectors"_genomes


rm GCA*


# Generate a file with each pairwise combination of genomes then calculate the phylogenetic distances between them 

for file in *genomes ; do 
file_short=$(basename $file | sed s/"_genomes"//g )
echo $file_short

awk '
        {
                A[++c] = $1
        }
        END {
                for ( i = 1; i <= c; i++ )
                {
                        for ( j = 1; j <= c; j++ )
                        {
                                print A[j], A[i]
                        }
                }
        }
' $file |  perl -ane '$,=" "; print sort @F; print "\n";'  | awk '!seen[$0]++'   > "$file_short"_pairs



sed s/"\.3_"/"\.1_"/g distances.txt | sed s/"\.2_"/"\.1_"/g > distances2.txt

cut -f1 -d "." distances.txt > d1
cut -f2 distances.txt | cut -f1  -d "."  > d2
cut -f3 distances.txt > d3
paste d1 d2 d3 > d4

# Use grep to get genome pair distances 


for file in *pairs ; do 
effectors=$(basename $file | sed s/"_pairs"//g)
echo $effectors

python /projects/oldhome/hulinm/git_repos/tools/analysis/python_effector_scripts/filter_distances.py $file d4 > "$effectors"_genome_1.tmp

awk '!seen[$0]++' "$effectors"_genome_1.tmp | sed '/^$/d' > "$effectors"_genome_2.tmp
awk ' {split( $0, a, " " ); asort( a ); for( i = 1; i <= length(a); i++ ) printf( "%s ", a[i] ); printf( "\n" ); }' "$effectors"_genome_2.tmp > "$effectors"_genome_3.tmp
tr -d "\015" <"$effectors"_genome_3.tmp >"$effectors"_genome_4.tmp
awk '!seen[$0]++' "$effectors"_genome_4.tmp > "$effectors"_genome_5.tmp 
awk -F" |:" '
{$1=sprintf("%.10f", $1)}
1' "$effectors"_genome_5.tmp  > "$effectors"_genome_distances
rm *tmp
    
# Then need to add up all the distances to get a weighting for each effector gene interaction pair for the network 

for file in *pairs ; do 
effectors=$(basename $file | sed s/"_pairs"//g)
echo $effectors
awk '{ SUM += $1} END { print SUM }' "$effectors"_genome_distances > "$effectors"_genome_distances.tmp
awk -F" |:" '
{$1=sprintf("%.10f", $1)}
1'  "$effectors"_genome_distances.tmp >  "$effectors"_genome_distance
rm *tmp

# paste to get one file 

ls *distance > t
sed -i s/"_genome_distance"//g t  
sed -i s/"_"/"\t"/g t  
cat *distance > t2

paste t t2 > effector_interaction_distances
rm t*

# Get number of phylogroups each interaction happens in for figure 

cp /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/pyani/phylogroups/info  .
cut -f1 -d "." info > strains
cut -f2 -d "+" info > phylogroups
paste strains phylogroups > info2

# Get phylogroup number into output file 
for file in *genomes ; do 
file_short=$(basename $file | sed s/"_genomes"//g)
echo $file
for genome in $(cat $file) ; do 
grep $genome info2 >> "$file_short"_phylogroups.tmp 

for file in *_phylogroups.tmp ; do
file_short=$(basename $file | sed s/"_phylogroups.tmp"//g)
cut -f2 $file | sort | uniq | wc -l > "$file_short"_phylogroups

# Concatenate results 

cat *_phylogroups > phylogroup_info
ls *_phylogroups > t
sed -i s/"_phylogroups"//g t
 mv t interactions
 paste interactions phylogroup_info > interaction_phylogroup
 
# Add this imformation to the effector_interaction_distances txt file 


# Express each linkage as a percentage of the number of strains that possess both effectors (e.g. in only 50% of strains possessing hopC and hopH are they linked) 


# Generate a file with each pairwise combination of genomes then calculate the phylogenetic distances between them 

for file in *genomic ; do
file_short=$(basename $file | sed s/"_genomic"//g )
cut -f1 -d "_" $file | sed s/"-1"//g | sed s/"-2"//g > "$file_short"_effectors
done

for file in *effectors ; do 
file_short=$(basename $file | sed s/"_effectors"//g )
echo $file_short

awk '
        {
                A[++c] = $1
        }
        END {
                for ( i = 1; i <= c; i++ )
                {
                        for ( j = 1; j <= c; j++ )
                        {
                                print A[j], A[i]
                        }
                }
        }
' $file |  perl -ane '$,=" "; print sort @F; print "\n";'  | awk '!seen[$0]++'   > "$file_short"_effector_pairs

for file in *effector_pairs ; do 
file_short=$(basename $file | sed s/"_effector_pairs"//g )
echo $file_short
sed s/" "/"_"/g "$file_short"_effector_pairs | sort -k1 > "$file_short"_effector_pairs2

for file in $(cat ./weighting/interactions/interactions) ; do 
grep $file *_effector_pairs2 | wc -l >> numbers

# In interactions folder 
wc -l *_genomes > no_linked_genomes

paste ./weighting/interactions/no_linked_genomes numbers > linkage_vs_presence
 
# Generating network in R of linked genes weighted by pairwise distances on the phylogeny
# Took effector_interaction_distances.txt and manually checked in excel. 
# Took the log of each distance to allow a suitable range for network edge sizes
# Those that were < 0.2 (log(gdist)) were converted to 0.2 to allow visibility of edges 

install.packages("statnet", dependencies = TRUE) 
library(statnet)
set.seed(12345)
LRs<-read.table("/Users/hulinm/Desktop/effector_interaction_distances2.txt", col.names=,1)

attach(LRs)
library(ggplot2)
library(gplots)
library(reshape2)
library(plyr)
library(network)
matrix<-acast(LRs, e1~e2)
matrix[is.na(matrix)] <- 0

# Need to make matrix into a square

un1 <- unique(sort(c(colnames(matrix), rownames(matrix))))
m2 <- matrix(NA, length(un1), length(un1), dimnames = list(un1, un1))
m2[row.names(matrix), colnames(matrix)] <- matrix
m2[is.na(m2)] <- 0
diag(m2)<-0

m2 <- network(x = m2, # the network object
                  directed = FALSE, # specify whether the network is directed
                  loops = FALSE, # do we allow self ties (should not allow them)
                  matrix.type = "adjacency", # the type of input
                  ignore.eval = FALSE, 
                  names.eval = "weights")

# Plot network 
library(GGally)
set.edge.attribute(m2)

a<-ggnet2(m2, size= "degree",  edge.col="color", label = TRUE, label.size = 2)
ggsave("network_bayes.pdf", plot = a, width = 20, height = 20)
dev.off()

# Per different phylogroups

# Generating network in R of interactions weighted by the number of phylogroups they appear in 

install.packages("statnet", dependencies = TRUE) 
library(statnet)
set.seed(12345)
LRs<-read.table("/Users/hulinm/Desktop/effector_interaction_distances3.txt", col.names=,1)
attach(LRs)
library(ggplot2)
library(gplots)
library(reshape2)
library(plyr)
library(network)
matrix<-acast(LRs, e1~e2)
matrix[is.na(matrix)] <- 0

# Need to make matrix into a square

un1 <- unique(sort(c(colnames(matrix), rownames(matrix))))
m2 <- matrix(NA, length(un1), length(un1), dimnames = list(un1, un1))
m2[row.names(matrix), colnames(matrix)] <- matrix
m2[is.na(m2)] <- 0
diag(m2)<-0

m2 <- network(x = m2, # the network object
                  directed = FALSE, # specify whether the network is directed
                  loops = FALSE, # do we allow self ties (should not allow them)
                  matrix.type = "adjacency", # the type of input
                  ignore.eval = FALSE, 
                  names.eval = "weights")

# Plot network 
library(GGally)
set.edge.attribute(m2, "color", ifelse(m2 %e% "weights" >1, "firebrick", "grey"))

a<-ggnet2(m2, size= "degree", edge.size = "weights", edge.col="color", label = TRUE, label.size = 2)
ggsave("network_linkage_phylo.pdf", plot = a, width = 20, height = 20)
dev.off()



# Generating network in R of interactions based on the percentage of strains for which this interaction occurs of the total number that possess these two effectors

install.packages("statnet", dependencies = TRUE) 
library(statnet)
set.seed(12345)
LRs<-read.table("/Users/hulinm/Desktop/effector_interaction_distances4.txt", col.names=,1)
attach(LRs)
library(ggplot2)
library(gplots)
library(reshape2)
library(plyr)
library(network)
matrix<-acast(LRs, e1~e2)
matrix[is.na(matrix)] <- 0

# Need to make matrix into a square

un1 <- unique(sort(c(colnames(matrix), rownames(matrix))))
m2 <- matrix(NA, length(un1), length(un1), dimnames = list(un1, un1))
m2[row.names(matrix), colnames(matrix)] <- matrix
m2[is.na(m2)] <- 0
diag(m2)<-0

m2 <- network(x = m2, # the network object
                  directed = FALSE, # specify whether the network is directed
                  loops = FALSE, # do we allow self ties (should not allow them)
                  matrix.type = "adjacency", # the type of input
                  ignore.eval = FALSE, 
                  names.eval = "weights")

# Plot network 
library(GGally)
set.edge.attribute(m2, "color", ifelse(m2 %e% "weights" >0.98, "firebrick", "grey"))

a<-ggnet2(m2, size= "degree", edge.size = "weights", edge.col="color", label = TRUE, label.size = 2)
ggsave("network_linkage_percentage.pdf", plot = a, width = 20, height = 20)
dev.off()


 