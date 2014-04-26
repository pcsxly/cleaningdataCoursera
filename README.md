README.md
===========
The R script in this repo demonstrates how to collect and clean a data set. The data set that is used comes from the UCI HAR Dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The R code is contained in the file "run_analysis.R" located in this repo. This script will work properly as long as the Samsung data is in your working directory. The output is a cleaned data set as described in "CodeBook.md". The output filename is "dfTidy.txt"

After setting the R working directory (using setwd() function) the R code can be run with the source command (e.g. source("run_analysis.R") if the R code is also located in the working directory). The output data set will be the filename "dfTidy.txt" in the working directory. 