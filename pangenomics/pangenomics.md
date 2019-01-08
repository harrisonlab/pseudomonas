# Pseudomonas pangenomics
# Pipeline (adapted Levy 2018) > get all genomes with <1000 contigs (428) > N50 > 40,000 (348) > checkM completeness score >95% complete, <5% contamination 
# All 428 genomes belonging to Ps. species complex Gomila et al. 2017 from the ftp website Sept 2018
# Generated spreadsheet from ftp website 

# Downloaded all onto cluster using wget. Only for those genomes with <1000 contigs 

wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/012/245/GCA_000012245.1_ASM1224v1/GCA_000012245.1_ASM1224v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/988/485/GCA_000988485.1_ASM98848v1/GCA_000988485.1_ASM98848v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/482/725/GCA_001482725.1_ASM148272v1/GCA_001482725.1_ASM148272v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/815/GCA_002905815.2_ASM290581v2/GCA_002905815.2_ASM290581v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/047/185/GCA_003047185.1_ASM304718v1/GCA_003047185.1_ASM304718v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/235/825/GCA_900235825.1_CFBP4215/GCA_900235825.1_CFBP4215_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/235/865/GCA_900235865.1_CFBP2118/GCA_900235865.1_CFBP2118_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/105/295/GCA_900105295.1_IMG-taxon_2687453698_annotated_assembly/GCA_900105295.1_IMG-taxon_2687453698_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/331/385/GCA_000331385.1_PSSB64v1.0/GCA_000331385.1_PSSB64v1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/164/015/GCA_000164015.3_ASM16401v3/GCA_000164015.3_ASM16401v3_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/068/135/GCA_002068135.1_ASM206813v1/GCA_002068135.1_ASM206813v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/184/295/GCA_900184295.1_Chr_1/GCA_900184295.1_Chr_1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/517/305/GCA_000517305.1_ASM51730v1/GCA_000517305.1_ASM51730v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/355/GCA_000344355.2_ASM34435v2/GCA_000344355.2_ASM34435v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/705/GCA_000452705.3_ASM45270v3/GCA_000452705.3_ASM45270v3_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/648/735/GCA_000648735.3_ASM64873v3/GCA_000648735.3_ASM64873v3_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/988/395/GCA_000988395.1_ASM98839v1/GCA_000988395.1_ASM98839v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/281/365/GCA_001281365.1_ASM128136v1/GCA_001281365.1_ASM128136v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/913/215/GCA_001913215.1_ASM191321v1/GCA_001913215.1_ASM191321v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/024/285/GCA_002024285.1_ASM202428v1/GCA_002024285.1_ASM202428v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/024/305/GCA_002024305.1_ASM202430v1/GCA_002024305.1_ASM202430v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/412/165/GCA_000412165.1_PSSSMv1.0/GCA_000412165.1_PSSSMv1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/658/965/GCA_000658965.1_ASM65896v1/GCA_000658965.1_ASM65896v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/507/185/GCA_000507185.2_PSs_v03/GCA_000507185.2_PSs_v03_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/065/GCA_002112065.1_ASM211206v1/GCA_002112065.1_ASM211206v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/289/135/GCA_900289135.1_CFBP6110chr/GCA_900289135.1_CFBP6110chr_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/335/GCA_000344335.2_ASM34433v2/GCA_000344335.2_ASM34433v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/913/235/GCA_001913235.1_ASM191323v1/GCA_001913235.1_ASM191323v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/763/655/GCA_002763655.1_ASM276365v1/GCA_002763655.1_ASM276365v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/012/205/GCA_000012205.1_ASM1220v1/GCA_000012205.1_ASM1220v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/235/885/GCA_900235885.1_CFBP6109/GCA_900235885.1_CFBP6109_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/289/125/GCA_900289125.1_CFBP2116_finsihed_replicons/GCA_900289125.1_CFBP2116_finsihed_replicons_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/235/815/GCA_900235815.1_CFBP3840/GCA_900235815.1_CFBP3840_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/685/GCA_002905685.2_ASM290568v2/GCA_002905685.2_ASM290568v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/235/835/GCA_900235835.1_CFBP3846/GCA_900235835.1_CFBP3846_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/875/GCA_002905875.2_ASM290587v2/GCA_002905875.2_ASM290587v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/795/GCA_002905795.2_ASM290579v2/GCA_002905795.2_ASM290579v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/074/915/GCA_900074915.1_PCPL58T/GCA_900074915.1_PCPL58T_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/235/895/GCA_900235895.1_PL963/GCA_900235895.1_PL963_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/935/GCA_001293935.1_Por36_1/GCA_001293935.1_Por36_1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/006/455/GCA_001006455.1_PSt_v01/GCA_001006455.1_PSt_v01_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/917/175/GCA_002917175.1_psy100/GCA_002917175.1_psy100_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/665/GCA_001293665.1_PsA2/GCA_001293665.1_PsA2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/103/225/GCA_900103225.1_IMG-taxon_2663762773_annotated_assembly/GCA_900103225.1_IMG-taxon_2663762773_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/775/GCA_000935775.1_PSS41A-G1/GCA_000935775.1_PSS41A-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/103/765/GCA_900103765.1_IMG-taxon_2687453696_annotated_assembly/GCA_900103765.1_IMG-taxon_2687453696_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/113/625/GCA_900113625.1_IMG-taxon_2693429915_annotated_assembly/GCA_900113625.1_IMG-taxon_2693429915_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/738/515/GCA_000738515.1_Alf3_v1/GCA_000738515.1_Alf3_v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/333/995/GCA_000333995.1_BRIP39023v2.0/GCA_000333995.1_BRIP39023v2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/837/595/GCA_002837595.1_ASM283759v1/GCA_002837595.1_ASM283759v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/302/795/GCA_000302795.1_Pav013_1.0/GCA_000302795.1_Pav013_1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/113/535/GCA_900113535.1_IMG-taxon_2687453722_annotated_assembly/GCA_900113535.1_IMG-taxon_2687453722_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/716/855/GCA_001716855.1_ASM171685v1/GCA_001716855.1_ASM171685v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/302/815/GCA_000302815.1_Pav037_1.0/GCA_000302815.1_Pav037_1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/800/685/GCA_000800685.1_ASM80068v1/GCA_000800685.1_ASM80068v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/975/GCA_002905975.1_ASM290597v1/GCA_002905975.1_ASM290597v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/845/GCA_002699845.1_ASM269984v1/GCA_002699845.1_ASM269984v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/906/135/GCA_002906135.1_ASM290613v1/GCA_002906135.1_ASM290613v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/723/575/GCA_002723575.1_ASM272357v1/GCA_002723575.1_ASM272357v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/143/095/GCA_900143095.1_IMG-taxon_2663762795_annotated_assembly/GCA_900143095.1_IMG-taxon_2663762795_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/035/GCA_001294035.1_PphHB10Y/GCA_001294035.1_PphHB10Y_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/107/345/GCA_900107345.1_IMG-taxon_2687453749_annotated_assembly/GCA_900107345.1_IMG-taxon_2687453749_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/642/795/GCA_001642795.1_ASM164279v1/GCA_001642795.1_ASM164279v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/157/375/GCA_002157375.1_ASM215737v1/GCA_002157375.1_ASM215737v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/906/015/GCA_002906015.1_ASM290601v1/GCA_002906015.1_ASM290601v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/158/995/GCA_002158995.1_ASM215899v1/GCA_002158995.1_ASM215899v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/065/GCA_001294065.1_PphY5_2/GCA_001294065.1_PphY5_2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/375/GCA_002916375.1_7928C/GCA_002916375.1_7928C_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/104/015/GCA_900104015.1_IMG-taxon_2667527209_annotated_assembly/GCA_900104015.1_IMG-taxon_2667527209_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/770/765/GCA_002770765.1_ASM277076v1/GCA_002770765.1_ASM277076v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/995/GCA_002905995.1_ASM290599v1/GCA_002905995.1_ASM290599v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/225/GCA_002916225.1_5264/GCA_002916225.1_5264_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/255/GCA_002916255.1_7928A/GCA_002916255.1_7928A_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/466/845/GCA_001466845.1_ASM146684v1/GCA_001466845.1_ASM146684v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/855/GCA_002905855.1_ASM290585v1/GCA_002905855.1_ASM290585v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/985/GCA_001293985.1_PmyAZ84488/GCA_001293985.1_PmyAZ84488_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/785/GCA_002699785.1_ASM269978v1/GCA_002699785.1_ASM269978v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/275/GCA_002916275.1_5275/GCA_002916275.1_5275_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/917/195/GCA_002917195.1_pss2675/GCA_002917195.1_pss2675_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/905/GCA_002699905.1_ASM269990v1/GCA_002699905.1_ASM269990v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/855/GCA_001535855.1_ASM153585v1/GCA_001535855.1_ASM153585v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/114/665/GCA_900114665.1_IMG-taxon_2687453748_annotated_assembly/GCA_900114665.1_IMG-taxon_2687453748_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/006/445/GCA_001006445.1_PSl_v01/GCA_001006445.1_PSl_v01_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/467/365/GCA_001467365.1_ASM146736v1/GCA_001467365.1_ASM146736v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/025/GCA_002318025.1_ASM231802v1/GCA_002318025.1_ASM231802v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/106/705/GCA_900106705.1_IMG-taxon_2687453747_annotated_assembly/GCA_900106705.1_IMG-taxon_2687453747_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/105/GCA_001294105.1_PphNPS3121/GCA_001294105.1_PphNPS3121_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/985/GCA_002699985.1_ASM269998v1/GCA_002699985.1_ASM269998v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/355/GCA_002916355.1_8094A/GCA_002916355.1_8094A_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/935/GCA_002905935.1_ASM290593v1/GCA_002905935.1_ASM290593v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/834/695/GCA_000834695.1_ASM83469v1/GCA_000834695.1_ASM83469v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/698/815/GCA_001698815.1_ASM169881v1/GCA_001698815.1_ASM169881v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/835/GCA_002905835.1_ASM290583v1/GCA_002905835.1_ASM290583v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/115/275/GCA_900115275.1_IMG-taxon_2687453695_annotated_assembly/GCA_900115275.1_IMG-taxon_2687453695_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/825/GCA_001293825.1_Pla107/GCA_001293825.1_Pla107_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/623/415/GCA_001623415.1_ASM162341v1/GCA_001623415.1_ASM162341v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/965/GCA_002699965.1_ASM269996v1/GCA_002699965.1_ASM269996v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/163/315/GCA_000163315.1_ASM16331v1/GCA_000163315.1_ASM16331v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/737/225/GCA_000737225.1_UB0390_1.0_131105/GCA_000737225.1_UB0390_1.0_131105_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/406/485/GCA_002406485.1_ASM240648v1/GCA_002406485.1_ASM240648v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/585/725/GCA_000585725.1_B301D-Rv1.0/GCA_000585725.1_B301D-Rv1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/736/945/GCA_002736945.1_ASM273694v1/GCA_002736945.1_ASM273694v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/597/765/GCA_000597765.1_PSSRIMT-15J14/GCA_000597765.1_PSSRIMT-15J14_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/775/GCA_001400775.1_PcoICMP19117/GCA_001400775.1_PcoICMP19117_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/895/GCA_001400895.1_PorICMP9088/GCA_001400895.1_PorICMP9088_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/917/155/GCA_002917155.1_pss2676/GCA_002917155.1_pss2676_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/675/415/GCA_001675415.1_1845/GCA_001675415.1_1845_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/335/GCA_002916335.1_7969/GCA_002916335.1_7969_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/723/595/GCA_002723595.1_ASM272359v1/GCA_002723595.1_ASM272359v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/115/405/GCA_900115405.1_IMG-taxon_2693429914_annotated_assembly/GCA_900115405.1_IMG-taxon_2693429914_annotated_assembly_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/736/965/GCA_002736965.1_ASM273696v1/GCA_002736965.1_ASM273696v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/845/GCA_001293845.1_PlaYM7902/GCA_001293845.1_PlaYM7902_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/334/055/GCA_000334055.1_34881_v2.0/GCA_000334055.1_34881_v2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/725/GCA_001535725.1_ASM153572v1/GCA_001535725.1_ASM153572v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/025/GCA_001294025.1_Pph1302A/GCA_001294025.1_Pph1302A_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/675/375/GCA_001675375.1_2507/GCA_001675375.1_2507_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/467/285/GCA_001467285.1_ASM146728v1/GCA_001467285.1_ASM146728v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/334/035/GCA_000334035.1_34876_v2.0/GCA_000334035.1_34876_v2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/775/GCA_001293775.1_Pci0788_9/GCA_001293775.1_Pci0788_9_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/467/115/GCA_001467115.1_ASM146711v1/GCA_001467115.1_ASM146711v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/187/045/GCA_000187045.2_ASM18704v2/GCA_000187045.2_ASM18704v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/466/965/GCA_001466965.1_ASM146696v1/GCA_001466965.1_ASM146696v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/875/GCA_001535875.1_ASM153587v1/GCA_001535875.1_ASM153587v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/934/645/GCA_000934645.1_ASM93464v1/GCA_000934645.1_ASM93464v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/187/065/GCA_000187065.2_ASM18706v2/GCA_000187065.2_ASM18706v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/737/245/GCA_000737245.1_GAW0119_1.0_311105/GCA_000737245.1_GAW0119_1.0_311105_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/345/GCA_001400345.1_PgcICMP4323/GCA_001400345.1_PgcICMP4323_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/003/545/GCA_002003545.1_ASM200354v1/GCA_002003545.1_ASM200354v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/495/GCA_001400495.1_PlpICMP3947/GCA_001400495.1_PlpICMP3947_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/725/GCA_001293725.1_Psv4352/GCA_001293725.1_Psv4352_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/015/GCA_002318015.1_ASM231801v1/GCA_002318015.1_ASM231801v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/939/285/GCA_002939285.1_ASM293928v1/GCA_002939285.1_ASM293928v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/895/GCA_002318895.1_ASM231889v1/GCA_002318895.1_ASM231889v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/975/GCA_001293975.1_PmeN6801/GCA_001293975.1_PmeN6801_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/265/GCA_001294265.1_Pseudomonas_syringae_pv._glycinea_BR1/GCA_001294265.1_Pseudomonas_syringae_pv._glycinea_BR1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/765/GCA_001293765.1_PgyLN10/GCA_001293765.1_PgyLN10_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/055/GCA_001538055.1_ASM153805v1/GCA_001538055.1_ASM153805v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/835/GCA_001293835.1_Pla3988/GCA_001293835.1_Pla3988_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/945/GCA_001535945.1_ASM153594v1/GCA_001535945.1_ASM153594v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/238/485/GCA_001238485.1_ASM123848v1/GCA_001238485.1_ASM123848v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/805/GCA_002318805.1_ASM231880v1/GCA_002318805.1_ASM231880v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/825/GCA_002318825.1_ASM231882v1/GCA_002318825.1_ASM231882v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/275/GCA_001294275.1_PgyUnB647/GCA_001294275.1_PgyUnB647_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/535/GCA_000344535.1_ICMP18807v1.0/GCA_000344535.1_ICMP18807v1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/282/735/GCA_000282735.1_ASM28273v1/GCA_000282735.1_ASM28273v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/335/GCA_001401335.1_PttICMP459/GCA_001401335.1_PttICMP459_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/235/GCA_001401235.1_PziICMP8921/GCA_001401235.1_PziICMP8921_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/395/GCA_001400395.1_PhiICMP9623/GCA_001400395.1_PhiICMP9623_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/293/705/GCA_001293705.1_PsB48/GCA_001293705.1_PsB48_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/785/GCA_001535785.1_ASM153578v1/GCA_001535785.1_ASM153578v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/885/GCA_002318885.1_ASM231888v1/GCA_002318885.1_ASM231888v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/466/945/GCA_001466945.1_ASM146694v1/GCA_001466945.1_ASM146694v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/655/GCA_002318655.1_ASM231865v1/GCA_002318655.1_ASM231865v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/735/GCA_002318735.1_ASM231873v1/GCA_002318735.1_ASM231873v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/467/105/GCA_001467105.1_ASM146710v1/GCA_001467105.1_ASM146710v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/765/GCA_000452765.2_CC1513_092313_2.0/GCA_000452765.2_CC1513_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/645/GCA_002318645.1_ASM231864v1/GCA_002318645.1_ASM231864v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/695/GCA_001400695.1_ParICMP4457/GCA_001400695.1_ParICMP4457_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/095/GCA_001401095.1_PtaICMP2835/GCA_001401095.1_PtaICMP2835_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/735/GCA_002905735.1_ASM290573v1/GCA_002905735.1_ASM290573v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/875/GCA_002318875.1_ASM231887v1/GCA_002318875.1_ASM231887v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/905/GCA_001535905.1_ASM153590v1/GCA_001535905.1_ASM153590v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/735/GCA_001535735.1_ASM153573v1/GCA_001535735.1_ASM153573v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/497/495/GCA_001497495.1_ASM149749v1/GCA_001497495.1_ASM149749v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/915/GCA_002699915.1_ASM269991v1/GCA_002699915.1_ASM269991v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/972/155/GCA_000972155.1_ASM97215v1/GCA_000972155.1_ASM97215v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/075/GCA_001401075.1_PsyICMP3023/GCA_001401075.1_PsyICMP3023_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/466/875/GCA_001466875.1_ASM146687v1/GCA_001466875.1_ASM146687v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/795/GCA_000935795.1_PSPCFBP1754-G1/GCA_000935795.1_PSPCFBP1754-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/737/235/GCA_000737235.1_CEB003_1.0_131105/GCA_000737235.1_CEB003_1.0_131105_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/917/215/GCA_002917215.1_pss2682/GCA_002917215.1_pss2682_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/395/GCA_002916395.1_5270/GCA_002916395.1_5270_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/305/955/GCA_001305955.1_ASM130595v1/GCA_001305955.1_ASM130595v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/755/GCA_002905755.1_ASM290575v1/GCA_002905755.1_ASM290575v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/735/GCA_001400735.1_PcaICMP2855/GCA_001400735.1_PcaICMP2855_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/270/465/GCA_001270465.1_PacA10853/GCA_001270465.1_PacA10853_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/525/GCA_000452525.3_USA011_091113_2.0/GCA_000452525.3_USA011_091113_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/115/GCA_001294115.1_PseHC_1/GCA_001294115.1_PseHC_1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/307/715/GCA_000307715.1_PseVir1.0/GCA_000307715.1_PseVir1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/805/GCA_001535805.1_ASM153580v1/GCA_001535805.1_ASM153580v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/955/GCA_002905955.1_ASM290595v1/GCA_002905955.1_ASM290595v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/497/595/GCA_001497595.1_ASM149759v1/GCA_001497595.1_ASM149759v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/466/975/GCA_001466975.1_ASM146697v1/GCA_001466975.1_ASM146697v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/497/455/GCA_001497455.1_ASM149745v1/GCA_001497455.1_ASM149745v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/695/GCA_002905695.1_ASM290569v1/GCA_002905695.1_ASM290569v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/725/GCA_002318725.1_ASM231872v1/GCA_002318725.1_ASM231872v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/315/GCA_001401315.1_PtgICMP4091/GCA_001401315.1_PtgICMP4091_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/825/GCA_000452825.2_CC1417_092313_2.0/GCA_000452825.2_CC1417_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/505/GCA_000452505.1_CC1582_042011_1.0/GCA_000452505.1_CC1582_042011_1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/195/GCA_001294195.1_PgyKN44/GCA_001294195.1_PgyKN44_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/245/395/GCA_000245395.1_ASM24539v1/GCA_000245395.1_ASM24539v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/915/GCA_002905915.1_ASM290591v1/GCA_002905915.1_ASM290591v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/245/GCA_001538245.1_ASM153824v1/GCA_001538245.1_ASM153824v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/269/885/GCA_002269885.1_ASM226988v1/GCA_002269885.1_ASM226988v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/145/GCA_001538145.1_ASM153814v1/GCA_001538145.1_ASM153814v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/485/GCA_000452485.1_TA043_042011_1.0/GCA_000452485.1_TA043_042011_1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/497/555/GCA_001497555.1_ASM149755v1/GCA_001497555.1_ASM149755v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/745/GCA_002318745.1_ASM231874v1/GCA_002318745.1_ASM231874v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/269/785/GCA_002269785.1_ASM226978v1/GCA_002269785.1_ASM226978v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/115/GCA_001400115.1_PamICMP3918/GCA_001400115.1_PamICMP3918_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/775/GCA_002905775.1_ASM290577v1/GCA_002905775.1_ASM290577v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/665/GCA_002318665.1_ASM231866v1/GCA_002318665.1_ASM231866v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/917/245/GCA_002917245.1_pss3023/GCA_002917245.1_pss3023_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/270/015/GCA_002270015.1_ASM227001v1/GCA_002270015.1_ASM227001v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/467/225/GCA_001467225.1_ASM146722v1/GCA_001467225.1_ASM146722v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/495/GCA_002750495.1_ASM275049v1/GCA_002750495.1_ASM275049v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/815/GCA_001535815.1_ASM153581v1/GCA_001535815.1_ASM153581v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/815/GCA_002318815.1_ASM231881v1/GCA_002318815.1_ASM231881v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/525/GCA_002750525.1_ASM275052v1/GCA_002750525.1_ASM275052v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/805/GCA_002111805.1_ASM211180v1/GCA_002111805.1_ASM211180v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/972/195/GCA_000972195.1_ASM97219v1/GCA_000972195.1_ASM97219v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/505/GCA_002750505.1_ASM275050v1/GCA_002750505.1_ASM275050v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/695/GCA_000935695.1_PSAVPseNe107-G1/GCA_000935695.1_PSAVPseNe107-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/735/GCA_000935735.1_PSDCFBP3226-G1/GCA_000935735.1_PSDCFBP3226-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/125/GCA_001400125.1_PafICMP4394/GCA_001400125.1_PafICMP4394_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/515/GCA_002750515.1_ASM275051v1/GCA_002750515.1_ASM275051v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/215/GCA_001401215.1_PvrICMP2848/GCA_001401215.1_PvrICMP2848_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/445/GCA_000452445.2_PpiPP1_130925_2.0/GCA_000452445.2_PpiPP1_130925_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/497/465/GCA_001497465.1_ASM149746v1/GCA_001497465.1_ASM149746v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/835/GCA_002111835.1_ASM211183v1/GCA_002111835.1_ASM211183v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/875/GCA_001400875.1_PmeICMP5711/GCA_001400875.1_PmeICMP5711_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/645/GCA_000452645.2_CC1629_092313_2.0/GCA_000452645.2_CC1629_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/762/615/GCA_002762615.1_ASM276261v1/GCA_002762615.1_ASM276261v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/395/GCA_000344395.1_ICMP18804v1.0/GCA_000344395.1_ICMP18804v1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/755/GCA_001535755.1_ASM153575v1/GCA_001535755.1_ASM153575v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/745/GCA_000452745.2_CC1524_092313_2.0/GCA_000452745.2_CC1524_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/890/485/GCA_002890485.1_ASM289048v1/GCA_002890485.1_ASM289048v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/736/925/GCA_002736925.1_ASM273692v1/GCA_002736925.1_ASM273692v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/905/895/GCA_002905895.1_ASM290589v1/GCA_002905895.1_ASM290589v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/865/GCA_002111865.1_ASM211186v1/GCA_002111865.1_ASM211186v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/275/725/GCA_001275725.1_ASM127572v1/GCA_001275725.1_ASM127572v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/835/GCA_001400835.1_PheICMP4531/GCA_001400835.1_PheICMP4531_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/305/GCA_002916305.1_7968A/GCA_002916305.1_7968A_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/625/GCA_000452625.2_CC1630_092313_2.0/GCA_000452625.2_CC1630_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/275/945/GCA_000275945.1_ASM27594v1/GCA_000275945.1_ASM27594v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/085/GCA_001538085.1_ASM153808v1/GCA_001538085.1_ASM153808v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/415/GCA_000344415.1_ICMP18806v1.0/GCA_000344415.1_ICMP18806v1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/537/985/GCA_001537985.1_ASM153798v1/GCA_001537985.1_ASM153798v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/605/GCA_001400605.1_PphICMP2740/GCA_001400605.1_PphICMP2740_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/185/GCA_001538185.1_ASM153818v1/GCA_001538185.1_ASM153818v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/885/GCA_000416885.1_ASM41688v1/GCA_000416885.1_ASM41688v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/835/GCA_001535835.1_ASM153583v1/GCA_001535835.1_ASM153583v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/270/005/GCA_001270005.1_ASM127000v1/GCA_001270005.1_ASM127000v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/890/475/GCA_002890475.1_ASM289047v1/GCA_002890475.1_ASM289047v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/785/GCA_000452785.2_CC1466_092313_2.0/GCA_000452785.2_CC1466_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/177/515/GCA_000177515.1_ASM17751v1/GCA_000177515.1_ASM17751v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/435/GCA_002750435.1_ASM275043v1/GCA_002750435.1_ASM275043v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/445/GCA_002750445.1_ASM275044v1/GCA_002750445.1_ASM275044v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/302/915/GCA_000302915.1_Pav631_1.0/GCA_000302915.1_Pav631_1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/005/GCA_001401005.1_PppICMP4048/GCA_001401005.1_PppICMP4048_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/611/605/GCA_002611605.1_ASM261160v1/GCA_002611605.1_ASM261160v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/738/525/GCA_002738525.1_ClPS15/GCA_002738525.1_ClPS15_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/185/GCA_002175185.1_ASM217518v1/GCA_002175185.1_ASM217518v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/611/615/GCA_002611615.1_ASM261161v1/GCA_002611615.1_ASM261161v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/145/885/GCA_000145885.1_ASM14588v1/GCA_000145885.1_ASM14588v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/917/235/GCA_002917235.1_psm9095/GCA_002917235.1_psm9095_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/745/GCA_002111745.1_ASM211174v1/GCA_002111745.1_ASM211174v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/665/GCA_000452665.2_CC1583_092313_2.0/GCA_000452665.2_CC1583_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/750/455/GCA_002750455.1_ASM275045v1/GCA_002750455.1_ASM275045v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/665/GCA_002111665.1_ASM211166v1/GCA_002111665.1_ASM211166v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/825/GCA_002699825.1_ASM269982v1/GCA_002699825.1_ASM269982v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/537/955/GCA_001537955.1_ASM153795v1/GCA_001537955.1_ASM153795v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/875/GCA_002111875.1_ASM211187v1/GCA_002111875.1_ASM211187v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/165/GCA_002112165.1_ASM211216v1/GCA_002112165.1_ASM211216v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/545/GCA_000416545.1_ASM41654v1/GCA_000416545.1_ASM41654v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/113/905/GCA_002113905.1_ASM211390v1/GCA_002113905.1_ASM211390v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/115/545/GCA_002115545.1_ASM211554v1/GCA_002115545.1_ASM211554v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/945/GCA_002111945.1_ASM211194v1/GCA_002111945.1_ASM211194v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/742/145/GCA_002742145.1_ASM274214v1/GCA_002742145.1_ASM274214v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/875/GCA_002174875.1_ASM217487v1/GCA_002174875.1_ASM217487v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/535/915/GCA_001535915.1_ASM153591v1/GCA_001535915.1_ASM153591v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/045/GCA_001538045.1_ASM153804v1/GCA_001538045.1_ASM153804v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/095/GCA_002112095.1_ASM211209v1/GCA_002112095.1_ASM211209v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/125/GCA_002112125.1_ASM211212v1/GCA_002112125.1_ASM211212v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/915/GCA_001400915.1_PpoICMP8961/GCA_001400915.1_PpoICMP8961_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/095/GCA_001538095.1_ASM153809v1/GCA_001538095.1_ASM153809v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/175/GCA_002175175.1_ASM217517v1/GCA_002175175.1_ASM217517v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/285/GCA_001401285.1_PsvICMP4352/GCA_001401285.1_PsvICMP4352_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/955/GCA_002111955.1_ASM211195v1/GCA_002111955.1_ASM211195v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/985/GCA_002111985.1_ASM211198v1/GCA_002111985.1_ASM211198v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/005/GCA_002112005.1_ASM211200v1/GCA_002112005.1_ASM211200v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/045/GCA_002112045.1_ASM211204v1/GCA_002112045.1_ASM211204v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/995/GCA_002111995.1_ASM211199v1/GCA_002111995.1_ASM211199v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/113/925/GCA_002113925.1_ASM211392v1/GCA_002113925.1_ASM211392v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/537/965/GCA_001537965.1_ASM153796v1/GCA_001537965.1_ASM153796v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/135/GCA_002112135.1_ASM211213v1/GCA_002112135.1_ASM211213v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/905/GCA_002174905.1_ASM217490v1/GCA_002174905.1_ASM217490v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/065/GCA_002175065.1_ASM217506v1/GCA_002175065.1_ASM217506v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/112/085/GCA_002112085.1_ASM211208v1/GCA_002112085.1_ASM211208v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/934/225/GCA_002934225.1_ASM293422v1/GCA_002934225.1_ASM293422v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/925/GCA_002174925.1_ASM217492v1/GCA_002174925.1_ASM217492v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/985/GCA_002174985.1_ASM217498v1/GCA_002174985.1_ASM217498v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/785/GCA_002111785.1_ASM211178v1/GCA_002111785.1_ASM211178v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/975/GCA_002174975.1_ASM217497v1/GCA_002174975.1_ASM217497v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/695/GCA_002111695.1_ASM211169v1/GCA_002111695.1_ASM211169v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/245/GCA_002175245.1_ASM217524v1/GCA_002175245.1_ASM217524v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/885/GCA_002111885.1_ASM211188v1/GCA_002111885.1_ASM211188v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/925/GCA_002111925.1_ASM211192v1/GCA_002111925.1_ASM211192v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/145/GCA_002175145.1_ASM217514v1/GCA_002175145.1_ASM217514v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/155/GCA_001538155.1_ASM153815v1/GCA_001538155.1_ASM153815v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/855/GCA_002699855.1_ASM269985v1/GCA_002699855.1_ASM269985v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/675/GCA_002111675.1_ASM211167v1/GCA_002111675.1_ASM211167v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/890/365/GCA_002890365.1_ASM289036v1/GCA_002890365.1_ASM289036v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/795/GCA_002111795.1_ASM211179v1/GCA_002111795.1_ASM211179v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/935/GCA_002174935.1_ASM217493v1/GCA_002174935.1_ASM217493v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/310/965/GCA_002310965.1_ASM231096v1/GCA_002310965.1_ASM231096v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/323/035/GCA_002323035.1_ASM232303v1/GCA_002323035.1_ASM232303v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/845/GCA_000452845.2_CC1416_092313_2.0/GCA_000452845.2_CC1416_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/895/GCA_002174895.1_ASM217489v1/GCA_002174895.1_ASM217489v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/465/GCA_000452465.2_Psy1212_130925_2.0/GCA_000452465.2_Psy1212_130925_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/537/945/GCA_001537945.1_ASM153794v1/GCA_001537945.1_ASM153794v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/085/GCA_002175085.1_ASM217508v1/GCA_002175085.1_ASM217508v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/055/GCA_002175055.1_ASM217505v1/GCA_002175055.1_ASM217505v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/575/GCA_001400575.1_PneICMP16943/GCA_001400575.1_PneICMP16943_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/245/475/GCA_000245475.1_ASM24547v1/GCA_000245475.1_ASM24547v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/805/GCA_000416805.1_ASM41680v1/GCA_000416805.1_ASM41680v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/135/GCA_002175135.1_ASM217513v1/GCA_002175135.1_ASM217513v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/645/GCA_000935645.1_PSAVPseNe107-G1/GCA_000935645.1_PSAVPseNe107-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/215/GCA_002175215.1_ASM217521v1/GCA_002175215.1_ASM217521v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/685/GCA_002111685.1_ASM211168v1/GCA_002111685.1_ASM211168v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/310/955/GCA_002310955.1_ASM231095v1/GCA_002310955.1_ASM231095v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/245/415/GCA_000245415.1_ASM24541v1/GCA_000245415.1_ASM24541v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/910/485/GCA_001910485.1_ASM191048v1/GCA_001910485.1_ASM191048v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/916/295/GCA_002916295.1_5271/GCA_002916295.1_5271_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/605/GCA_000452605.2_CC440_0923_2.0/GCA_000452605.2_CC440_0923_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/255/GCA_001538255.1_ASM153825v1/GCA_001538255.1_ASM153825v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/585/GCA_000452585.2_CC457_092313_2.0/GCA_000452585.2_CC457_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/538/205/GCA_001538205.1_ASM153820v1/GCA_001538205.1_ASM153820v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/225/GCA_002175225.1_ASM217522v1/GCA_002175225.1_ASM217522v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/675/GCA_000935675.1_PMCFBP3225-G1/GCA_000935675.1_PMCFBP3225-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/805/GCA_000452805.2_CC1458_092313_2.0/GCA_000452805.2_CC1458_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/075/GCA_002175075.1_ASM217507v1/GCA_002175075.1_ASM217507v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/163/275/GCA_000163275.1_ASM16327v1/GCA_000163275.1_ASM16327v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/685/GCA_000452685.2_CC1559_092313_2.0/GCA_000452685.2_CC1559_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/111/755/GCA_002111755.1_ASM211175v1/GCA_002111755.1_ASM211175v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/175/005/GCA_002175005.1_ASM217500v1/GCA_002175005.1_ASM217500v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/910/555/GCA_001910555.1_ASM191055v1/GCA_001910555.1_ASM191055v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/945/GCA_002699945.1_ASM269994v1/GCA_002699945.1_ASM269994v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/545/GCA_000452545.2_USA_092313_2.0/GCA_000452545.2_USA_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/255/GCA_001401255.1_PthICMP3923/GCA_001401255.1_PthICMP3923_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/275/735/GCA_001275735.1_ASM127573v1/GCA_001275735.1_ASM127573v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/202/995/GCA_003202995.1_ASM320299v1/GCA_003202995.1_ASM320299v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/146/005/GCA_000146005.1_ASM14600v1/GCA_000146005.1_ASM14600v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/910/465/GCA_001910465.1_ASM191046v1/GCA_001910465.1_ASM191046v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/435/GCA_001400435.1_PdeICMP9150/GCA_001400435.1_PdeICMP9150_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/465/GCA_000416465.2_ASM41646v2/GCA_000416465.2_ASM41646v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/665/GCA_000416665.1_ASM41666v1/GCA_000416665.1_ASM41666v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/905/GCA_000452905.2_CC1544_092313_2.0/GCA_000452905.2_CC1544_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/665/GCA_000935665.1_PDCFBP4219-G1/GCA_000935665.1_PDCFBP4219-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/715/GCA_002318715.1_ASM231871v1/GCA_002318715.1_ASM231871v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/055/GCA_001401055.1_PsoICMP16925/GCA_001401055.1_PsoICMP16925_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/700/065/GCA_002700065.1_ASM270006v1/GCA_002700065.1_ASM270006v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/174/995/GCA_002174995.1_ASM217499v1/GCA_002174995.1_ASM217499v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/205/905/GCA_003205905.1_ASM320590v1/GCA_003205905.1_ASM320590v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/795/GCA_001400795.1_PcuICMP11894/GCA_001400795.1_PcuICMP11894_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/245/455/GCA_000245455.1_ASM24545v1/GCA_000245455.1_ASM24545v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/485/GCA_000416485.1_ASM41648v1/GCA_000416485.1_ASM41648v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/910/545/GCA_001910545.1_ASM191054v1/GCA_001910545.1_ASM191054v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/375/GCA_001401375.1_PalICMP15200/GCA_001401375.1_PalICMP15200_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/555/GCA_001400555.1_PmyICMP7118/GCA_001400555.1_PmyICMP7118_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/865/GCA_000452865.1_UB246_042011_1.0/GCA_000452865.1_UB246_042011_1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/515/GCA_000344515.2_ICMP19455PSA1.0/GCA_000344515.2_ICMP19455PSA1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/732/035/GCA_000732035.1_PSV1.0/GCA_000732035.1_PSV1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/751/155/GCA_000751155.1_PSV1.0/GCA_000751155.1_PSV1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/145/865/GCA_000145865.1_ASM14586v1/GCA_000145865.1_ASM14586v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/785/GCA_000416785.2_ASM41678v2/GCA_000416785.2_ASM41678v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/205/965/GCA_003205965.1_ASM320596v1/GCA_003205965.1_ASM320596v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/475/GCA_000344475.2_Pseudomonas_syringae_pv._actinidiae_str._Shaanxi_M228_V02/GCA_000344475.2_Pseudomonas_syringae_pv._actinidiae_str._Shaanxi_M228_V02_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/699/885/GCA_002699885.1_ASM269988v1/GCA_002699885.1_ASM269988v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/185/GCA_001400185.1_PcdICMP12471/GCA_001400185.1_PcdICMP12471_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/245/435/GCA_000245435.1_ASM24543v1/GCA_000245435.1_ASM24543v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/375/GCA_001400375.1_PgyICMP2189/GCA_001400375.1_PgyICMP2189_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/865/GCA_000416865.1_ASM41686v1/GCA_000416865.1_ASM41686v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/455/GCA_001400455.1_PerICMP4455/GCA_001400455.1_PerICMP4455_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/725/GCA_000452725.2_CC1543_092313_2.0/GCA_000452725.2_CC1543_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/342/185/GCA_000342185.1_ICMP18744PSA1.0/GCA_000342185.1_ICMP18744PSA1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/525/GCA_000416525.1_ASM41652v1/GCA_000416525.1_ASM41652v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/145/745/GCA_000145745.1_ASM14574v1/GCA_000145745.1_ASM14574v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/995/GCA_001400995.1_PrhICMP9756/GCA_001400995.1_PrhICMP9756_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/294/215/GCA_001294215.1_PmpFTRS_U7805/GCA_001294215.1_PmpFTRS_U7805_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/165/GCA_001401165.1_PumICMP3962/GCA_001401165.1_PumICMP3962_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/935/825/GCA_000935825.1_PAVEPAVT10-G1/GCA_000935825.1_PAVEPAVT10-G1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/233/795/GCA_000233795.2_ASM23379v2/GCA_000233795.2_ASM23379v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/265/GCA_001401265.1_PseICMP763/GCA_001401265.1_PseICMP763_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/375/GCA_000344375.1_ICMP18800PSA1.0/GCA_000344375.1_ICMP18800PSA1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/202/975/GCA_003202975.1_ASM320297v1/GCA_003202975.1_ASM320297v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/145/685/GCA_000145685.1_ASM14568v1/GCA_000145685.1_ASM14568v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/845/GCA_000416845.2_ASM41684v2/GCA_000416845.2_ASM41684v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/435/GCA_000344435.1_TP1_PSA1.0/GCA_000344435.1_TP1_PSA1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/555/GCA_000344555.1_ICMP19439PSA1.0/GCA_000344555.1_ICMP19439PSA1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/565/GCA_000452565.2_UB303_092313_2.0/GCA_000452565.2_UB303_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/635/GCA_002318635.1_ASM231863v1/GCA_002318635.1_ASM231863v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/483/545/GCA_001483545.1_PfrICMP7711/GCA_001483545.1_PfrICMP7711_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/344/455/GCA_000344455.1_TP6-1_PSA1.0/GCA_000344455.1_TP6-1_PSA1.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/755/GCA_001400755.1_PccICMP5710/GCA_001400755.1_PccICMP5710_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/745/GCA_000416745.1_ASM41674v1/GCA_000416745.1_ASM41674v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/910/495/GCA_001910495.1_ASM191049v1/GCA_001910495.1_ASM191049v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/515/GCA_001400515.1_PmlICMP6289/GCA_001400515.1_PmlICMP6289_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/978/625/GCA_000978625.2_ASM97862v2/GCA_000978625.2_ASM97862v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/935/GCA_001400935.1_PreICMP16945/GCA_001400935.1_PreICMP16945_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/401/155/GCA_001401155.1_PtrICMP9151/GCA_001401155.1_PtrICMP9151_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/145/925/GCA_000145925.1_ASM14592v1/GCA_000145925.1_ASM14592v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/475/GCA_001400475.1_PlaICMP3507/GCA_001400475.1_PlaICMP3507_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/978/635/GCA_000978635.2_ASM97863v2/GCA_000978635.2_ASM97863v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/275/GCA_001400275.1_PdaICMP9757/GCA_001400275.1_PdaICMP9757_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/444/115/GCA_000444115.1_CLC6_0_3/GCA_000444115.1_CLC6_0_3_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/825/GCA_000416825.2_ASM41682v2/GCA_000416825.2_ASM41682v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/939/245/GCA_002939245.1_ASM293924v1/GCA_002939245.1_ASM293924v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/441/975/GCA_000441975.1_CLC6_0_3/GCA_000441975.1_CLC6_0_3_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/939/225/GCA_002939225.1_ASM293922v1/GCA_002939225.1_ASM293922v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/318/795/GCA_002318795.1_ASM231879v1/GCA_002318795.1_ASM231879v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/939/205/GCA_002939205.1_ASM293920v1/GCA_002939205.1_ASM293920v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/163/255/GCA_000163255.1_ASM16325v1/GCA_000163255.1_ASM16325v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/205/935/GCA_003205935.1_ASM320593v1/GCA_003205935.1_ASM320593v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/452/925/GCA_000452925.2_CC94_092313_2.0/GCA_000452925.2_CC94_092313_2.0_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/233/815/GCA_000233815.2_ASM23381v2/GCA_000233815.2_ASM23381v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/444/135/GCA_000444135.1_CLC6_0_3/GCA_000444135.1_CLC6_0_3_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/285/GCA_001400285.1_PcsICMP9419/GCA_001400285.1_PcsICMP9419_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/525/GCA_001400525.1_PmoICMP4331/GCA_001400525.1_PmoICMP4331_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/715/GCA_001400715.1_PbrICMP13650/GCA_001400715.1_PbrICMP13650_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/415/GCA_001400415.1_PhoICMP7840/GCA_001400415.1_PhoICMP7840_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/815/GCA_001400815.1_PfiICMP7848/GCA_001400815.1_PfiICMP7848_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/945/GCA_000416945.1_ASM41694v1/GCA_000416945.1_ASM41694v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/705/GCA_000416705.1_ASM41670v1/GCA_000416705.1_ASM41670v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/205/895/GCA_003205895.1_ASM320589v1/GCA_003205895.1_ASM320589v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/675/GCA_001400675.1_PaeICMP8947/GCA_001400675.1_PaeICMP8947_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/498/595/GCA_000498595.1_AtroDSM50255_2.0_130911/GCA_000498595.1_AtroDSM50255_2.0_130911_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/725/GCA_000416725.1_ASM41672v1/GCA_000416725.1_ASM41672v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/655/GCA_001400655.1_PacICMP2802/GCA_001400655.1_PacICMP2802_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/261/495/GCA_002261495.1_ASM226149v1/GCA_002261495.1_ASM226149v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/765/GCA_000416765.1_ASM41676v1/GCA_000416765.1_ASM41676v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/416/505/GCA_000416505.1_ASM41650v1/GCA_000416505.1_ASM41650v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/205/945/GCA_003205945.1_ASM320594v1/GCA_003205945.1_ASM320594v1_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/233/835/GCA_000233835.2_ASM23383v2/GCA_000233835.2_ASM23383v2_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/400/215/GCA_001400215.1_PceICMP17524/GCA_001400215.1_PceICMP17524_genomic.fna.gz  .
wget    ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/225/805/GCA_000225805.1_ASM22580v1/GCA_000225805.1_ASM22580v1_genomic.fna.gz  .




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
# Transpose the report in excel to flip columns/rows


python /home/hulinm/git_repos/tools/analysis/python_effector_scripts/extract_N50filtered_genomes.py report_modified.txt > report2.txt 

for file in $(cat /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/quast_results/results_2018_09_13_08_30_27/report2.txt) ; do 
cp "$file".fa ./filtered/
done


# CheckM to check for contamination and completeness of genomes  

for file in ./*.fa ; do
    file_short=$(basename $file | sed s/".fa"//g)
    echo $file_short
    #mkdir -p ./checkm/"$file_short"
    #cp $file ./checkm/"$file_short"
    Jobs=$(qstat | grep 'checkm' | wc -l)
    while [ $Jobs -gt 7 ]
    do
        sleep 10
        printf "."
        Jobs=$(qstat | grep 'checkm' | wc -l)
    done
    qsub /home/hulinm/git_repos/pseudomonas/sub_checkm.sh /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/filtered/checkm/"$file_short" /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/filtered/checkm/"$file_short"/checkm
done

for file in ./*fa ; do 
    file_short=$(basename $file | sed s/".fa"//g)
    
 checkm qa /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/filtered/checkm/"$file_short"/checkm/lineage.ms /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/filtered/checkm/"$file_short"/checkm > /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/filtered/checkm/"$file_short"/checkm/report

done








# OrthoMCL 

# Rename ffn file to contain genome name not PROKKA output 
for file in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*.fna.gz ; do 
file_short=$(basename $file | sed s/".fna.gz"//g) 
echo $file_short
cp /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$file_short"/*.faa /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/"$file_short"/"$file_short".faa 


# Move all faa files to orthomcl directory within /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/orthomcl

cp /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/genomes/*/*.faa .

# Modify all fasta files to remove description and get into correct format for OrthMCL
# Each fasta item must be in format of strain|peg.number

for file in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/orthomcl/*.faa ; do  
file_short=$(basename $file | sed s/".faa"//g | cut -f1 -d ".") 
echo $file_short
sed -e 's/^\(>[^[:space:]]*\).*/\1/' $file | sed s/"_"/"|peg."/g  > "$file_short".fa
done

for file in /home/hulinm/pseudomonas_data/pseudomonas/assembly/pangenomics/orthomcl/*.fa ; do 
id=$(less $file | grep ">" | cut -f1 -d "|" | sed s/">"//g | uniq) 
file_short=$(basename $file | sed s/".fa"//g) 
echo $id 
echo $file_short
sed s/"$id"/"$file_short"/g $file > $file_short.fasta



# OrthoFinder 

/home/hulinm/local/src/OrthoFinder-2.2.7_source/orthofinder/orthofinder.py  -f formatted -t 16 -S diamond -M msa 



