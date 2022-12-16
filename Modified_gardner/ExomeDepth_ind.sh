#!/bin/bash

#PBS -N ExomeDepth
#PBS -S /bin/bash
#PBS -l mem=40gb
#PBS -l walltime=10:00:00 
#PBS -l nodes=1:ppn=4
#PBS -o /logfile_directory/ExomeDepth.out
#PBS -e /error_file_directory/ExomeDepth.err


module load gcc/4.9.4
module load java-jdk/1.7.0_80
module load zlib/1.2.8
module load bzip2/1.0.6
module load xz/5.2.2
module load curl/7.51.0
module load pcre/8.39
module load R/3.1.2


cd "/directory_with_bam_and_bai_files"

Rscript ind_exomeDepth.R "_step5d.bam" "_step5d.bai"
