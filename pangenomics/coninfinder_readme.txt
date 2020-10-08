
#################################################################

# Coinfinder set up January 2020
# https://www.biorxiv.org/content/10.1101/859371v1
# https://github.com/fwhelan/coinfinder

#################################################################

# Create conda env
conda create --name coinfinder
conda activate coinfinder

# Install 
conda install -c conda-forge -c bioconda -c defaults coinfinder

# Run program in /projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/coinfinder 
# Usage: coinfinder -i <gene information> -p <phylogeny> -o <output prefix> [--associate|--dissociate]


# Newick phylogeny is built from presence-absence data using iqtree. Rooted to outgroup 001238485 in geneious and exported. 

# Create effector table in format for coinfinder
R
x<-read.table("/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/coinfinder/effectors2.txt", header=TRUE)
maxLen <- max(colSums(x))

combine <- lapply(x, function(.col){
     sp <- row.names(x)[.col == 1]
     c(sp, rep("", 234 - length(sp)))
 })
 
 x2<-do.call(cbind, combine)
 write.table(x2,"/projects/cherry_canker/pseudomonas_data/pseudomonas/analysis/coinfinder/table3",row.names = F)
 
 sed s/\"1\"/000007805/g table3 |  sed s/\"2\"/000012205/g | sed s/\"3\"/001294035/g | sed s/\"4\"/001294105/g |sed s/\"5\"/001294025/g | sed s/\"6\"/001400605/g | sed s/\"7\"/001294065/g | sed s/\"8\"/001294185/g | sed s/\"9\"/000187045/g | sed s/\"10\"/001294195/g | sed s/\"11\"/001294275/g | sed s/\"12\"/001294265/g | sed s/\"13\"/000187065/g | sed s/\"14\"/001294115/g | sed s/\"15\"/001401265/g | sed s/\"16\"/001538205/g | sed s/\"17\"/000145685/g | sed s/\"18\"/000163275/g | sed s/\"19\"/001538085/g | sed s/\"20\"/001401165/g | sed s/\"21\"/001535915/g | sed s/\"22\"/002700065/g | sed s/\"23\"/900289135/g | sed s/\"24\"/001293985/g | sed s/\"25\"/001535805/g | sed s/\"26\"/001535835/g | sed s/\"27\"/001538145/g | sed s/\"28\"/001538055/g | sed s/\"29\"/001535735/g | sed s/\"30\"/002905685/g | sed s/\"31\"/900235815/g | sed s/\"32\"/002736925/g | sed s/\"33\"/900289125/g | sed s/\"34\"/002905755/g | sed s/\"35\"/002905875/g | sed s/\"36\"/000164015/g | sed s/\"37\"/002115545/g | sed s/\"38\"/002270015/g | sed s/\"39\"/000732035/g | sed s/\"40\"/000935695/g | sed s/\"41\"/001293725/g | sed s/\"42\"/001535815/g | sed s/\"43\"/002269885/g | sed s/\"44\"/001538155/g | sed s/\"45\"/002269785/g | sed s/\"46\"/001538245/g | sed s/\"47\"/001538255/g | sed s/\"48\"/000275945/g | sed s/\"49\"/001401095/g | sed s/\"50\"/000934645/g | sed s/\"51\"/001006455/g | sed s/\"52\"/001400395/g | sed s/\"53\"/001006445/g | sed s/\"54\"/002068135/g | sed s/\"55\"/001400875/g | sed s/\"56\"/001466905/g | sed s/\"57\"/001467105/g | sed s/\"58\"/001467115/g | sed s/\"59\"/001400735/g | sed s/\"60\"/001400835/g | sed s/\"61\"/001401315/g | sed s/\"62\"/000012245/g | sed s/\"63\"/000452465/g | sed s/\"64\"/002917155/g | sed s/\"65\"/002917195/g | sed s/\"66\"/002905815/g | sed s/\"67\"/002905835/g | sed s/\"68\"/000452525/g | sed s/\"69\"/001270465/g | sed s/\"70\"/001466875/g | sed s/\"71\"/001535725/g | sed s/\"72\"/002939285/g | sed s/\"73\"/003253455/g | sed s/\"74\"/900235825/g | sed s/\"75\"/001535855/g | sed s/\"76\"/001535945/g | sed s/\"77\"/001466945/g | sed s/\"78\"/002318725/g | sed s/\"79\"/003201385/g | sed s/\"80\"/002318665/g | sed s/\"81\"/000988485/g | sed s/\"82\"/002906015/g | sed s/\"83\"/002916275/g | sed s/\"84\"/900235865/g | sed s/\"85\"/002318815/g | sed s/\"86\"/000282735/g | sed s/\"87\"/003047185/g | sed s/\"88\"/000331385/g | sed s/\"89\"/001675375/g | sed s/\"90\"/001623415/g | sed s/\"91\"/000334055/g | sed s/\"92\"/000412165/g  | sed s/\"93\"/000452805/g | sed s/\"94\"/001675415/g | sed s/\"95\"/000452585/g | sed s/\"96\"/000988395/g | sed s/\"97\"/900115275/g | sed s/\"98\"/000452605/g | sed s/\"99\"/000738515/g  | sed s/\"100\"/001401335/g  | sed s/\"101\"/000972155/g  | sed s/\"102\"/002318825/g | sed s/\"103\"/002318875/g | sed s/\"104\"/000452445/g | sed s/\"105\"/003205935/g | sed s/\"106\"/003205965/g | sed s/\"107\"/000935775/g | sed s/\"108\"/002699845/g | sed s/\"109\"/001467285/g | sed s/\"110\"/900113625/g | sed s/\"111\"/002905935/g | sed s/\"112\"/002905975/g | sed s/\"113\"/001482725/g | sed s/\"114\"/002916225/g | sed s/\"115\"/900113535/g | sed s/\"116\"/000507185/g | sed s/\"117\"/000177515/g | sed s/\"118\"/000737225/g | sed s/\"119\"/900103225/g | sed s/\"120\"/002318645/g | sed s/\"121\"/002318745/g | sed s/\"122\"/002323035/g | sed s/\"123\"/002318885/g | sed s/\"124\"/000302795/g | sed s/\"125\"/000302815/g | sed s/\"126\"/002916335/g | sed s/\"127\"/002916375/g | sed s/\"128\"/000972175/g | sed s/\"129\"/000972195/g  | sed s/\"130\"/002916255/g | sed s/\"131\"/000333995/g | sed s/\"132\"/001293665/g | sed s/\"133\"/002917175/g | sed s/\"134\"/900099665/g | sed s/\"135\"/001466845/g | sed s/\"136\"/002699965/g | sed s/\"137\"/002318805/g | sed s/\"138\"/002318735/g | sed s/\"139\"/900105295/g | sed s/\"140\"/001281365/g | sed s/\"141\"/001467335/g | sed s/\"142\"/002318895/g | sed s/\"143\"/900119195/g | sed s/\"144\"/001401005/g | sed s/\"145\"/001535905/g | sed s/\"146\"/900074915/g | sed s/\"147\"/000452645/g | sed s/\"148\"/001275725/g | sed s/\"149\"/001275735/g | sed s/\"150\"/000452765/g | sed s/\"151\"/001401155/g | sed s/\"152\"/001293935/g | sed s/\"153\"/001400345/g | sed s/\"154\"/001401235/g | sed s/\"155\"/001400695/g | sed s/\"156\"/002093745/g | sed s/\"157\"/000452705/g | sed s/\"158\"/000452785/g | sed s/\"159\"/001466965/g | sed s/\"160\"/001466975/g | sed s/\"161\"/000416235/g | sed s/\"162\"/000737235/g | sed s/\"163\"/001698815/g | sed s/\"164\"/001238485/g | sed s/\"165\"/000737245/g | sed s/\"166\"/002158995/g | sed s/\"167\"/002699985/g | sed s/\"168\"/900187575/g | sed s/\"169\"/000517305/g | sed s/\"170\"/900187465/g | sed s/\"171\"/000452745/g | sed s/\"172\"/000452825/g | sed s/\"173\"/900143095/g | sed s/\"174\"/000452485/g | sed s/\"175\"/001467325/g | sed s/\"176\"/002406485/g | sed s/\"177\"/900184295/g | sed s/\"178\"/001642795/g | sed s/\"179\"/001716855/g | sed s/\"180\"/000452505/g | sed s/\"181\"/000834695/g | sed s/\"182\"/002723575/g | sed s/\"183\"/002087235/g | sed s/\"184\"/001293575/g | sed s/\"185\"/900100365/g | sed s/\"186\"/001293775/g | sed s/\"187\"/900114665/g | sed s/\"188\"/000302915/g | sed s/\"189\"/000344355/g | sed s/\"190\"/002024285/g | sed s/\"191\"/002174875/g | sed s/\"192\"/002890485/g | sed s/\"193\"/002890475/g | sed s/\"194\"/002175005/g | sed s/\"195\"/002174905/g | sed s/\"196\"/002174995/g | sed s/\"197\"/000658965/g | sed s/\"198\"/000416885/g | sed s/\"199\"/002111835/g | sed s/\"200\"/002261495/g | sed s/\"201\"/002763655/g | sed s/\"202\"/002762615/g | sed s/\"203\"/000416465/g | sed s/\"204\"/000344535/g | sed s/\"205\"/001497495/g | sed s/\"206\"/001497595/g | sed s/\"207\"/000416545/g | sed s/\"208\"/000416805/g | sed s/\"209\"/001467225/g | sed s/\"210\"/002003545/g | sed s/\"211\"/002699825/g | sed s/\"212\"/002905795/g | sed s/\"213\"/900289095/g | sed s/\"214\"/900235905/g | sed s/\"215\"/000935765/g | sed s/\"216\"/002906055/g | sed s/\"217\"/002699885/g | sed s/\"218\"/900235855/g | sed s/\"219\"/900235835/g | sed s/\"220\"/001400595/g | sed s/\"221\"/001401405/g | sed s/\"222\"/000177475/g | sed s/\"223\"/000765305/g | sed s/\"224\"/002966555/g | sed s/\"225\"/000177495/g | sed s/\"226\"/001294305/g | sed s/\"227\"/001401385/g | sed s/\"228\"/000452625/g | sed s/\"229\"/001467365/g | sed s/\"230\"/002906035/g | sed s/\"231\"/002906135/g | sed s/\"232\"/900107345/g | sed s/\"233\"/000935725/g | sed s/\"234\"/001293835/g > table4 


awk '{for(i=1;i<=102;i++){name=FILENAME"_"i;print $i> name}}' table4

# Split table into each effector and then add effector name to start of each line
for file in table4* ; do
effector=$(head -n 1 $file )
effector2=$(echo $effector | sed s/'"'//g)
sed s/'""'//g $file | sed '/^$/d' | sed  -e "s/^/$effector/"  | sed s/'"'/"\t"/g | sed 1d | sed -e 's/^[ \t]*//' > ./effectors/"$effector2"
done

# Create final table
cat * > effector_table

# Run coinfinder
coinfinder -i effector_family_table -p treeg -o ef_nocor --associate  --nocorrection
coinfinder -i effector_family_table -p treeg  -o efd_nocor --dissociate  --nocorrection

# No correction - get all possible associations for comparison
coinfinder -i effector_table -p treeg -o nocor --associate --nocorrection
coinfinder -i effector_table -p treeg -o d_nocor  --dissociate --nocorrection


# Create network using R 

# Generating network in R of linked genes from bayestraits analysis 

install.packages("statnet", dependencies = TRUE) 
library(statnet)
set.seed(12345)

LRs<-read.table("/Users/hulinm/Documents/coinfinder_run1.txt", col.names=,1)

attach(LRs)
library(ggplot2)
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

a<-ggnet2(m2, size= "degree",  edge.col="color", label = TRUE, label.size = 2)
ggsave("coinfinder.pdf", plot = a, width = 20, height = 20)
dev.off()