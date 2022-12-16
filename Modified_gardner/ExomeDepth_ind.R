# ExomeDepth RScript modified from ExomeDepth Vignette
# 01/21/2021
# Kelsey McNeely 
# University of Chicago

# gcc/4.9.4 java-jdk/1.7.0_80 zlib/1.2.8 bzip2/1.0.6 xz/5.2.2 curl/7.51.0 pcre/8.39 R/3.1.2

# Need 1 bam and bai file for each individual, exons.hg38 file if using hg38 aligned files (ExomeDepth has built in exons.hg19 data frame)
# Assumes reference set already created by user
# Input is 1 bam and 1 bai file for an individual 
# Lines 27, 36, & 60 need to be modified

# Load ExomeDepth
library(ExomeDepth)

args = commandArgs(trailingOnly=TRUE)


if(length(args)!=2){
  stop("Wrong number of file inputs. Need 2 files.")
}else {
  
  bamFile <- args[1]
  baiFile <- args[2]
  
  # load relevant build reference (exons.hg38 or exons.hg19)
  # will need to provide bed file if using hg38
  exons.hg38 <- readRDS("filepath for appropriate build bed file")
  
  
  # Obtain counts for individual
  # Enter reference fasta path (if applicable)
  ExomeCount  <- getBamCounts(bed.frame = exons.hg38, bam.files = bamFile, index.files = baiFile, include.chr=FALSE,)  
  ExomeCount.dafr <- as(ExomeCount [,colnames(ExomeCount)],'data.frame')
  
  # Load user-created reference set 
  my.ref <- readRDS('filepath for reference set')
  
  # Select test sample
  # Number below needs to be modified depending on total number of control + test samples
  my.test <- ExomeCount.dafr [,6]
  
  # Select control samples
  # Number below needs to be modified depending on total number of control + test samples
  # Only use columns with bam counts
  my.reference.set <- as.matrix(my.ref [,c(6:34)])
  
  # Identify best controls
  my.choice <- select.reference.set (test.counts = my.test, reference.counts = my.reference.set, bin.length = (ExomeCount.dafr$end - ExomeCount.dafr$start)/1000, n.bins.reduced=10000)
  
  # Construct the optimized reference set
  my.matrix <- as.matrix(my.reference.set[,my.choice$reference.choice], drop=FALSE)
  my.reference.selected <- apply(X= my.matrix, MAR=1, FUN=sum)
  
  # Call CNVs
  all.exons <- new ('ExomeDepth', test=my.test, reference= my.reference.selected, formula = 'cbind(test,reference) ~ 1')
  all.exons <- CallCNVs (x= all.exons,transition.probability= 10^-4, chromosome= ExomeCount.dafr$space, start =ExomeCount.dafr$start, end= ExomeCount.dafr$end, name = ExomeCount.dafr$names)
  
  print(head(all.exons@CNV.calls))
  
  output.file <- paste0('directory for output file', substr(bamFile, 1, 5), '_unlabeledCNVs', '.csv')
  
  write.csv(file = output.file, x = all.exons@CNV.calls, row.names = FALSE)
}
