# UCI_HAR_Project
Repository of the course project for the Coursera course 'Getting and Cleaning Data'

This repo contains the script [run_analysis.R](run_analysis.R), which is used to convert and summarize the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) with an independent, tidier data set.

## Tasks (5)

I created one R script called [run_analysis.R](run_analysis.R) that does the following

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The R Script

The R script used for converting and summarizing is available in the [run_analysis.R](run_analysis.R) file.

If necessary, you can download the script from this repository (open to public), source the script in R (or RStudio) using the command below and it will automatically download the dataset from the web (to a zip file), convert and summarize the data, save it in the file `TidyDataAvg.txt`, and delete the downloaded zip file.

```R
source("run_analysis.R")
```

The tidier, summarized data set can be loaded into R using the following command

```R
TidyDataAvg <- read.table(“TidyDataAvg.txt")
```

## CodeBook for UCI HAR and R script

The [codebook](CodeBook.md) in this repo describes the variables, the data, and all transformations I performed to clean up the data—as requested by the course professors.
