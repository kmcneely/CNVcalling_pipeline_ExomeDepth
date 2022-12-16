#get total number of paired CNV calls

import os
import csv

CNVcounter = 0

# get list of paired files
pairedCNVs_dir = "directory with files"
os.chdir(pairedCNVs_dir)
files_list = os.listdir(pairedCNVs_dir)

#if "YES" increment
fileLines = []
for fileName in files_list:
    with open(fileName) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            if row[0] == "YES":
                CNVcounter +=1

#print total number of paired CNV calls
print("Number of CNVs: " + str(CNVcounter))
