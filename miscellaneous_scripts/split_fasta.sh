#!/bin/sh

while read line
do
    if [[ ${line:0:1} == '>' ]]
    then
        outfile=${line#>}.fa
        echo $line > $outfile
    else
        echo $line >> $outfile
    fi
done < /home/hulinm/pseudomonas_data/pseudomonas/analysis/new_ortho/july16/analysis/orthology/orthomcl/july16/fasta/consensus/orthogroups_consensus.fasta

