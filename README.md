pseudomonas
===========

#Using Quake, SPAdes and Quast
##This protocol requires local installs of Quake and Quast. I had problems installing them globally on the cluster

First error correct your raw data with Quake:
This requires making a text file of your input data where paired end reads are on the same line and whitespace 
separated. 

quake.py -f quake.aq -k 16 -p 4

~/git_stuff/seq_tools/assemblers/SPAdes_assemble_part1.sh AQUILEGIA_S3_L001_R1_001.cor.fastq AQUILEGIA_S3_L001_R2_001.cor.fastq /home/harrir/projects/SPAdes_test/
