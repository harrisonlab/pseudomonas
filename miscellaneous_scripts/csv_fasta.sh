#!/bin/bash
# A script to convert .csv files to .fasta files to allow the use of blast2csv.pl script for effector detection
# The files are all saved into a folder named fastafiles within family_effectors



for file in 2675_avrPto1-1 ; do
    line=$(head -n 1 $file)
    strand=$(echo $line | cut -d " " -f10)
    echo $strand
    if [ $strand = "-1" ] ; then
    echo $line
done 
