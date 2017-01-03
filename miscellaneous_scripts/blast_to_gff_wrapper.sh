!#/bin/bash

HELP ="""
Wrapper for the blast_to_gff.py script. Use this to ensure that your gff file makes sense.
By: Alvar Almstedt (alvar.almstedt@gmail.com)
Usage: blast_to_gff_wrapper.sh -q <query file> -d <database file> -p <blast program>
Options:
	-h	:	Help. What you are reading now.
	-q	:	Query. Put the path to your query fasta here.
	-d	:	Database. Put the path to your blast database here.
	-o	:	Output. Put the name or path and name to your output location here.
	-p	:	Program. Currently only confirmed to work with tblastn 
			but others should work too.
	-t	:	Threads. Number of threads/processors you want the blast analysis to 
			run on. (Default: 1)
	-l	:	Long. Puts additional information like stop, start
			and name of query, frame, bitscore; in the notes field
			of the gff file. 
			This will increase the result file size significantly.
    -k  :   Keep. This will keep the intermediate blast output. Otherwise
            it will be deleted, only saving the gff.
"""
OUTPUT=0
LONG=false
THREADS=1
KEEP=false

while getopts :q:d:o:p:t:lkh: opt; do
  case $opt in
	q)
		echo "-q (query) was input as $OPTARG" >&2
		QUERY=$OPTARG
	;;
	d)
		echo "-d (database) was input as $OPTARG" >&2
		DATABASE=$OPTARG
	;;
	o)
		echo "-o (output) was input as $OPTARG" >&2
		OUTPUT=$OPTARG
	;;
	p)
		echo "-p (program) was input as $OPTARG" >&2
		PROGRAM=$OPTARG
	;;
	t)
		echo "-t (threads) was input as $OPTARG" >&2
		THREADS=$OPTARG
	;;
	l)
		echo "-l (long) was triggered, long output triggered" >&2
		LONG=true
	;;
    k)
        echo "-k (keep) was triggered, blast output will be kept" >&2
        KEEP=true
    ;;
	h)
		echo "$HELP"
		exit 1
	;;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		echo "Type $0 -h for usage"
		exit 1
	;;
  esac
done

if [ $PROGRAM = "tblastn" ] || [ $PROGRAM = "TBLASTN" ] && [ $LONG = false ] ; then
	tblastn -query $QUERY -db $DATABASE -outfmt '6 sseqid sstart send' -out $OUTPUT -num_threads $THREADS

elif [ $PROGRAM = tblastn ] || [ $PROGRAM = "TBLASTN" ] && [ $LONG = true ] ; then
	tblastn -query $QUERY -db $DATABASE -outfmt '6 sseqid sstart send qseqid qlen qstart qend sframe bitscore' -out $OUTPUT -num_threads $THREADS

elif [ $PROGRAM = "blastx" ] || [ $PROGRAM = "BLASTX" ] && [ $LONG = false ] ; then
	blastx -query $QUERY -db $DATABASE -outmft '6 sseqid sstart send' -out $OUTPUT -num_threads $THREADS

elif [ $PROGRAM = "blastx" ] || [ $PROGRAM = "BLASTX" ] && [ $LONG = true ] ; then
        blastx -query $QUERY -db $DATABASE -outmft '6 sseqid sstart send qseqid qlen qstart qend sframe bitscore' -out $OUTPUT -num_threads $THREADS

elif [ $PROGRAM = "blastn" ] || [ $PROGRAM = "BLASTN" ] && [ $LONG = false ] ; then
        blastn -query $QUERY -db $DATABASE -outmft '6 sseqid sstart send' -out $OUTPUT -num_threads $THREADS

elif [ $PROGRAM = "blastn" ] || [ $PROGRAM = "BLASTN" ] && [ $LONG = true ] ; then
        blastn -query $QUERY -db $DATABASE -outmft '6 sseqid sstart send qseqid qlen qstart qend sframe bitscore' -out $OUTPUT -num_threads $THREADS

else
    echo "Program input incorrectly formatted. Please input blastn/BLASTN, tblastn/TBLASTN or blastx/BLASTX" 
fi

if [ $OUTPUT != 0 ] ; then
	/home/hulinm/git_repos/tools/analysis/python_effector_scripts/blast_to_gff.py ${OUTPUT} ${OUTPUT}.gff
else
    echo "No blast output detected. Something went wrong."
    echo "Your blast output looks like this: "
    echo $OUTPUT
    wait
    rm $OUTPUT
fi

if [ $KEEP != true ] ; then
    wait
    rm $OUTPUT
fi

echo "Exited at: " ; date
exit
