# R phylogenetic tree visualisation circular tree with effectors 

library(ape)
library(ggplot2)
library(ggtree)
library(phangorn)

tree2 <- read.nexus("/Users/hulinm/fasttree_gen.tre")
mydata <- read.csv("/Users/hulinm/Documents/pseudomonas_traits4.csv", stringsAsFactors=FALSE, colClasses='character')
mydata4 <- read.csv("/Users/hulinm/Documents/pseudomonas_traits4.csv", stringsAsFactors=FALSE, colClasses='character', row.names = 1)

rownames(mydata) <- mydata$Assembly


p1<-c("000007805","000177475","000177495","000302915","000344355","000344535","000416465","000416545","000416805","000416885","000452625","000658965","000765305","000935725","000935765","001293835","001294305","001400595","001401385","001401405","001467225","001467365","001497495","001497595","002003545","002024285","002111835","002174875","002174905","002174995","002175005","002261495","002699825","002699885","002762615","002763655","002890475","002890485","002905795","002906035","002906055","002906135","002966555","900107345","900235835","900235855","900235905","900289095")
p2<-c("000012205","000145685","000163275","000164015","000187045","000187065","000275945","000732035","000934645","000935695","001006445","001006455","001293725","001293985","001294025","001294035","001294065","001294105","001294115","001294185","001294195","001294265","001294275","001400395","001400605","001400875","001401095","001401165","001401265","001466905","001467105","001467115","001535735","001535805","001535815","001535835","001535915","001538055","001538085","001538145","001538155","001538205","001538245","001538255","002068135","002115545","002269785","002269885","002270015","002700065","002736925","002905685","002905755","002905875","900235815","900289125","900289135")
p3<-c("001293575","001293775","900100365","900114665")
p4<-c("000452485","000452505","000834695","001467325","001642795","001716855","002406485","900184295")
p5<-c("000737245")
p6<-c("000012245","000282735","000302795","000302815","000331385","000334055","000412165","000452445","000452465","000452525","000452585","000452605","000452805","000507185","000738515","000935775","000972155","000972175","000972195","000988395","000988485","001270465","001401335","001466875","001466945","001467285","001482725","001535725","001535855","001535945","001623415","001675375","001675415","002318665","002318725","002318815","002318825","002318875","002699845","002905815","002905835","002905935","002905975","002906015","002916225","002916255","002916275","002916335","002916375","002917155","002917195","002939285","003047185","003201385","003205935","003205965","003253455","900113535","900113625","900115275","900235825","900235865")
p7<-c("900187575")
p8<-c("000177515","000737225","002318645","002318745","002318885","002323035","900103225")
p9<-c("002093745")
p10<-c("000416235","000737235")
p11<-c("000333995","001281365","001293665","001401005","001466845","001467335","001535905","002318735","002318805","002318895","002699965","002917175","900074915","900099665","900105295","900119195")
p12<-c("000517305","900187465")
p13<-c("001238485")
p15<-c("000452645","000452765","001275725","001275735","001293935","001400345","001400695","001401155","001401235")
p16<-c("002699985")
p17<-c("001466965","001466975")
p18<-c("900143095")
p19<-c("001400735","001400835","001401315")
p21<-c("000452705","000452785")
p22<-c("002723575")
p23<-c("001698815")
p24<-c("000452745","000452825")
p25<-c("002087235")
p27<-c("002158995")


getMRCA(tree,p1)
getMRCA(tree,p2)
getMRCA(tree,p3)
getMRCA(tree,p4)
getMRCA(tree,p6)
getMRCA(tree,p8)
getMRCA(tree,p10)
getMRCA(tree,p11)
getMRCA(tree,p12)
getMRCA(tree,p15)
getMRCA(tree,p17)
getMRCA(tree,p19)
getMRCA(tree,p21)
getMRCA(tree,p24)

# Adding in phylogroups
tree4 <- groupClade(tree, .node=c(617, 559, 667,397,427,552,713,537,710,415,671,615,709,407))
# Add bootstraps less than 100

q<-ggtree(tree4, aes(color=group), layout="circular")
d <- q$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- d[d$label < 0.9,]

cherry<-mydata4[c(4)]


q2<- q +  geom_text2(data=d, aes(label=label), size=1, hjust=-.4)
q3 <- q2 %<+% mydata + geom_tiplab(aes(angle=angle), align=TRUE, size=1, color="black", hjust=-0.05) + scale_color_manual(values=c("black", "orange", "deepskyblue", "pink", "salmon", "darkred", "grey", "lightblue", "seagreen","blue", "purple", "forestgreen", "green", "brown", "red"))
q4 <- gheatmap(q3, cherry, width=0.05, font.size=0.5 , color = "black",  offset=0.03) + scale_fill_manual(breaks=c("0","1", "2", "3") , values=c("white","plum1", "purple", "red"))
pdf(file = "/Users/hulinm/Documents/core_tree5.pdf",width=7.2,height=10)
q4+theme(legend.position="bottom", legend.title=element_blank()) + guides(colour=FALSE) 
dev.off()



## Presence-absence tree

# R phylogenetic tree visualisation circular tree with effectors 

library(ape)
library(ggplot2)
library(ggtree)
library(phangorn)


tree3 <- read.nexus("/Users/hulinm/Documents/iqtree_new_pa_geneious.tre")

mydata <- read.csv("/Users/hulinm/Documents/pseudomonas_traits4.csv", stringsAsFactors=FALSE, colClasses='character')
mydata4 <- read.csv("/Users/hulinm/Documents/pseudomonas_traits4.csv", stringsAsFactors=FALSE, colClasses='character', row.names = 1)
mydata9 <- read.csv("/Users/hulinm/pseudomonas_effectors_SG_full.csv", stringsAsFactors=FALSE, colClasses='character',  row.names = 1)

rownames(mydata) <- mydata$Assembly




p1<-c("000007805","000177475","000177495","000302915","000344355","000344535","000416465","000416545","000416805","000416885","000452625","000658965","000765305","000935725","000935765","001293835","001294305","001400595","001401385","001401405","001467225","001467365","001497495","001497595","002003545","002024285","002111835","002174875","002174905","002174995","002175005","002261495","002699825","002699885","002762615","002763655","002890475","002890485","002905795","002906035","002906055","002906135","002966555","900107345","900235835","900235855","900235905","900289095")
p2<-c("000012205","000145685","000163275","000164015","000187045","000187065","000275945","000732035","000934645","000935695","001006445","001006455","001293725","001293985","001294025","001294035","001294065","001294105","001294115","001294185","001294195","001294265","001294275","001400395","001400605","001400875","001401095","001401165","001401265","001466905","001467105","001467115","001535735","001535805","001535815","001535835","001535915","001538055","001538085","001538145","001538155","001538205","001538245","001538255","002068135","002115545","002269785","002269885","002270015","002700065","002736925","002905685","002905755","002905875","900235815","900289125","900289135")
p3<-c("001293575","001293775","900100365","900114665")
p4<-c("000452485","000452505","000834695","001467325","001642795","001716855","002406485","900184295")
p5<-c("000737245")
p6<-c("000012245","000282735","000302795","000302815","000331385","000334055","000412165","000452445","000452465","000452525","000452585","000452605","000452805","000507185","000738515","000935775","000972155","000972175","000972195","000988395","000988485","001270465","001401335","001466875","001466945","001467285","001482725","001535725","001535855","001535945","001623415","001675375","001675415","002318665","002318725","002318815","002318825","002318875","002699845","002905815","002905835","002905935","002905975","002906015","002916225","002916255","002916275","002916335","002916375","002917155","002917195","002939285","003047185","003201385","003205935","003205965","003253455","900113535","900113625","900115275","900235825","900235865")
p7<-c("900187575")
p8<-c("000177515","000737225","002318645","002318745","002318885","002323035","900103225")
p9<-c("002093745")
p10<-c("000416235","000737235")
p11<-c("000333995","001281365","001293665","001401005","001466845","001467335","001535905","002318735","002318805","002318895","002699965","002917175","900074915","900099665","900105295","900119195")
p12<-c("000517305","900187465")
p13<-c("001238485")
p15<-c("000452645","000452765","001275725","001275735","001293935","001400345","001400695","001401155","001401235")
p16<-c("002699985")
p17<-c("001466965","001466975")
p18<-c("900143095")
p19<-c("001400735","001400835","001401315")
p21<-c("000452705","000452785")
p22<-c("002723575")
p23<-c("001698815")
p24<-c("000452745","000452825")
p25<-c("002087235")
p27<-c("002158995")


getMRCA(tree3,p1)
getMRCA(tree3,p2)
getMRCA(tree3,p3)
getMRCA(tree3,p4)
getMRCA(tree3,p6)
getMRCA(tree3,p8)
getMRCA(tree3,p10)
getMRCA(tree3,p11)
getMRCA(tree3,p12)
getMRCA(tree3,p15)
getMRCA(tree3,p17)
getMRCA(tree3,p19)
getMRCA(tree3,p21)
getMRCA(tree3,p24)


phylo3<-extract.clade(tree3, 260, root.edge = 0, collapse.singles = TRUE,
              interactive = FALSE)

phylo2<-extract.clade(tree3, 322, root.edge = 0, collapse.singles = TRUE,
              interactive = FALSE)
# Adding in phylogroups
tree4 <- groupClade(tree3, .node=c(421,260,418,250,322,383,238,389,244,406,416,314,415,247))
# Add bootstraps less than 100

q<-ggtree(tree4, aes(color=group), layout="circular")
d <- q$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- d[d$label < 100,]

cherry<-mydata4[c(4)]
all<-mydata9[c(2:108)]


q2<- q +  geom_text2(data=d, aes(label=label), size=1, hjust=-.4)
q3 <- q2 %<+% mydata + geom_tiplab(aes(angle=angle), align=TRUE, size=1, color="black", hjust=-0.05) + scale_color_manual(values=c("black", "orange", "deepskyblue", "pink", "salmon", "darkred", "grey", "lightblue", "seagreen","blue", "purple", "forestgreen", "green", "brown", "red"))
q4 <- gheatmap(q3, cherry, width=0.05, font.size=0.5 , color = "black",  offset=0.03) + scale_fill_manual(breaks=c("0","1", "2", "3") , values=c("white","plum1", "purple", "red"))
pdf(file = "/Users/hulinm/Documents/pa_tree5.pdf",width=7.2,height=10)
q4+theme(legend.position="bottom", legend.title=element_blank()) + guides(colour=FALSE) 
dev.off()

# Phylogroup 3


q<-ggtree(phylo3)
d <- q$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- d[d$label < 100,]

phylo3_tree<- q +  geom_text2(data=d, aes(label=label), size=1, hjust=-.4)
q3 <- phylo3_tree %<+% mydata + geom_tiplab(align=TRUE, size=1, color="black", hjust=-0.05) + scale_color_manual(values=c("black", "orange", "deepskyblue", "pink", "salmon", "darkred", "grey", "lightblue", "seagreen","blue", "purple", "forestgreen", "green", "brown", "red"))
q4 <- gheatmap(q3, cherry, width=0.05, font.size=0.5 , color = "black",  offset=0.03) + scale_fill_manual(breaks=c("0","1", "2", "3") , values=c("white","plum1", "purple", "red"))
pdf(file = "/Users/hulinm/Documents/phylogroup3-2.pdf",width=7.2,height=10)
q4+theme(legend.position="bottom", legend.title=element_blank()) + guides(colour=FALSE) + geom_treescale(offset=2)
dev.off()

# Phylogroup 3


q<-ggtree(phylo2)
d <- q$data
d <- d[!d$isTip,]
d$label <- as.numeric(d$label)
d <- d[d$label < 100,]

phylo2_tree<- q +  geom_text2(data=d, aes(label=label), size=1, hjust=-.4)
q3 <- phylo2_tree %<+% mydata + geom_tiplab(align=TRUE, size=1, color="black", hjust=-0.05) + scale_color_manual(values=c("black", "orange", "deepskyblue", "pink", "salmon", "darkred", "grey", "lightblue", "seagreen","blue", "purple", "forestgreen", "green", "brown", "red"))
q4 <- gheatmap(q3, cherry, width=0.05, font.size=0.5 , color = "black",  offset=0.03) + scale_fill_manual(breaks=c("0","1", "2", "3") , values=c("white","plum1", "purple", "red"))
pdf(file = "/Users/hulinm/Documents/phylogroup2.pdf",width=7.2,height=10)
q4+theme(legend.position="bottom", legend.title=element_blank()) + guides(colour=FALSE) + geom_treescale(offset=2)
dev.off()


#effectors
q4 <- gheatmap(q3, all, width=2, font.size=0.5 , color = "black",  offset=0.04) + scale_fill_manual(breaks=c("0","1", "2", "3") , values=c("white",	"yellow", "lightgreen", "darkblue","darkblue","darkblue", "darkgreen", "plum1", "red","grey"))
pdf(file = "/Users/hulinm/Documents/pa_tree5_all.pdf",width=20,height=20)
q4+theme(legend.position="bottom", legend.title=element_blank()) + guides(colour=FALSE) 
dev.off()


