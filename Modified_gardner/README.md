# CNV calling pipeline

CNV calling pipeline based on package "ExomeDepth"

**Make sure you know what genome build your sequences were aligned to and use the appropriate references and data frames. ExomeDepth comes with data frames for hg19 and this folder has an "exons_hg38.Rda" data frame for hg38-aligned sequences.**

### "ExomeDepth_ind.sh"

Example script to run ExomeDepth on HPC cluster for one sample. Edit: 

* logfile and error file paths in PBS header
* cd containing bam and bai files
* names of bam and bai files
