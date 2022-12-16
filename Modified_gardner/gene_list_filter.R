# Kelsey McNeely
# 3.3.2021
# filter ExomeDepth output labeled with hgnc IDs by gene list
# input: 1 patient csv file
# modify output path (line 43) and gene list (beginning line 18) as desired
# R version 4.0.3
# tidyr   1.1.2 

library(tidyverse)

args = commandArgs(trailingOnly=TRUE)

if(length(args)!=1){
  stop("Wrong number of file inputs. Need 1 patient csv file.")
}else {
  
  patient <- read_csv(args[1], col_types = cols(chromosome = col_character()))
  gene_list <- c("ACD",  "ACTN1", "ADA", "ADAMTS13", "AIRE", "AK2", "ALAS2", "AP3B1", 
                 "ATG2B", "BAP1", "BARD1", "BRAF", "BRIP1", "C15ORF41", "CARD11", "CASP10", "CD27", 
                 "CD40LG", "CDAN1", "CDKN2A", "CECR1", "CLPB", "CTC1", "CTLA4", "CXCR2", "CXCR4", "CYCS", 
                 "DHX34", "DNAH9", "DNAJC21", "DOCK8", "EFL1", "ELANE", "EPCAM", "EPOR", "ERCC1", "ERCC4", "ERCC6L2", 
                 "EZH2", "FAM111B", "FAS", "FASLG", "FBXW7", "FLI1", "FYB1", "G6PC3", "GALE", "GATA1", 
                 "GFI1", "GFI1B", "GP1BA", "GP1BB", "GP6", "GP9", "GSKIP", "HAX1", "HCLS1", 
                 "HOXA11", "HRAS", "IL17RA", "IL2RG", "IRF8", "ITGA2B", "ITGB3", "ITK", "JAGN1", "JAK2", "KIF23", "KIT", 
                 "KLF1", "KLHDC8B", "KRAS", "LAPTM5", "LIG4", "LYST", "LZTR1", "MAD2L2", "MAGT1", "MAP2K1",   
                 "MAP2K2",  "MAP3K14", "MASTL", "MBD4", "MECOM",  "MPL", "MRE11A",  "MYD88", "MYH9", "MYSM1", 
                 "NAF1", "NAPRT1", "NBEAL2", "NF2", "NHP2", "NOP10", "NPAT", "NRAS", "PALB2", "PARN", "PHF6",
                 "PIK3CD", "POLD1", "POLE", "POT1", "PRDM9", "PRF1", "PRKACG", "PTEN", "PTPRJ", "RAB27A",
                 "RAD50", "RAD51", "RAD51C", "RAD51D", "RAF1", "RBBP6", "RBM8A", "RECQL", "RECQL4", "RFWD3", 
                 "RIF1", "RIT1", "RNF168", "RPL11", "RPL15", "RPL18", "RPL23", "RPL26", "RPL27", "RPL31", "RPL35", 
                 "RPL35A", "RPL36", "RPL5", "RPS10", "RPS15A", "RPS17", "RPS19", "RPS20", "RPS24", "RPS26", 
                 "RPS27", "RPS28", "RPS29", "RPS7", "SBDS", "SDHB", "SDHC", "SDHD", "SEC23B", "SH2B3", "SH2D1A", 
                 "SHOC2", "SLC37A4", "SLFN14", "SLX4", "SOS1", "SRC", "SRP54", "STAT3", "STIM1", "STK11", "STN1",
                 "STXBP2", "TAZ", "TCIRG1", "TERF2IP", "THPO", "TINF2", "TNFRSF13B",  "TSR2", "TUBB1", "TYK2", "UBE2T", "UROS", 
                 "USB1", "VPS13B",  "VPS45", "WAS",  "WIPF1", "WRAP53", "XRCC2", "ZCCHC8", "TPP1", "TNFSF5", "ADA2", 
                 "MEK1", "MEK2", "EVI1", "MRE11", "TACI", "COH", "WASP", "ANKRD26", "ATM", "BLM", "BRCA1", "BRCA2", "CBL", 
                 "CEBPA", "CHEK2", "CSF3R", "DDX41", "DKC1", "ETV6", "FANCA", "FANCB", "FANCC", "FANCD2", "FANCE", "FANCF", 
                 "FANCG", "FANCI","FANCL", "FANCM", "GATA2", "IKZF1", "MLH1", "MSH2", "MSH6", "NBN", "NF1", "PAX5", "PMS2", "PTPN11", "RTEL1",
                 "RUNX1", "SAMD9", "SAMD9L", "SRP72", "TERC", "TERT", "TP53", "FBXW7", "ADH5", "ALDH2","RPA1")
  
  filtered_patient <- subset(patient, hgnc_symbol %in% gene_list)
  
  setwd("output directory") #directory for output file
  write.csv(filtered_patient, file=paste0(paste(substr(args[1], 1, 5), 'top200',  sep="_"), '.csv'), row.names = FALSE)
  
  print("filtered")
}
