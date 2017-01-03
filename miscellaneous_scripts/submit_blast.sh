#!/bin/bash

QUERY=$1
IS=$2
OUT=$3

/home/hulinm/git_repos/tools/pathogen/blast/blast2csve5.pl  $QUERY blastp $IS 1  > $OUT

