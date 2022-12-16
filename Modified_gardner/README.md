# CNV calling pipeline

CNV calling pipeline based on package "ExomeDepth"

**Make sure you know what genome build your sequences were aligned to and use the appropriate references and data frames. ExomeDepth comes with data frames for hg19 and this folder has an "exons_hg38.Rda" data frame for hg38-aligned sequences.**

### "ExomeDepth_ind.sh"

Example script to run ExomeDepth on HPC cluster for one sample. Edit: 

* logfile and error file paths in PBS header
* cd containing bam and bai files
* names of bam and bai files

### "gene_list_filter.R"

Filters ExomeDepth output labeled with gene IDs (HGNC) by list within script. 

### "merge_geneIDs.R"

Merges two files together based on HGNC ID. Merges based on gene ID instead of actual variant so each variant in from a particular gene in individual "X" will be paired with each variant in that same gene from individual "Y". Merged by gene rather than the exact variant to avoid filtering out variants of interest if there are differences due to sequencing or variant calling. 

### "paired_CNVcounts.py"

Used for the donor recipient project to get the total number of CNVs called for related donor-recipient pairs. Analyzes all files inside the folder containing the script. 

