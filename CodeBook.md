# CodeBook for UCI_HAR_project

This codebook describes the variables, the data, and all transformations I performed to clean up the UCI HAR dataset. The output of the [run_analysis.R](run_analysis.R) script is a tidier, summarized text file that can be read into R (or Rstudio) using `read.table`.

```R
TidyDataAvg <- read.table(“TidyDataAvg.txt")
```

The R script prepares a tidy data set from the University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR) using smartphones. 

The original UCI HAR Dataset can be found [here](see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The next two paragraphs contain a summary of how the data was collected (NOTE: the next 2 paragraphs are taken directly from the previously cited url).

The original data comes from experiments that were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking_upstairs, walking_downstairs, sitting, standing, and laying) wearing a Samsung Galaxy S II smartphone on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force was assumed to have only low frequency components, so a filter with a 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The script first combines the training and test datasets together, then generates a subset of this data by specifically extracting the mean and standard deviation features for each of the 33 processed signals, for a total of 66 features (out of the 561 available features from the original feature vector). This combined subset contains 10299 observations of 68 variables, with activity and subject appended to the 66 features.

The combined subset of data is further reduced by calculating the mean of the observations by activity and subject pair to generate 180 observations (6 activities * 30 participants) of the same 68 variables. This dataset is saved as a text file in the current working directory with the name `TidyDataAvg.txt`

## Modification of Variable names

In order to add some clarity to the variable (column) names, I use the following transformations.

```R
filtered_feature_names <- gsub("Acc", “-Acceleration", filtered_feature_names)
filtered_feature_names <- gsub("Mag", "-Magnitude", filtered_feature_names)
```

## Description of the UCI HAR variables

The tidy dataset (‘TidyDataAvg.txt’) consists of 180 (30*6) observations summarized by activity (6 categories) and subject (30 participants) pairs. For each observation (row) in the tidy dataset, the following 68 columns are provided:

- Subject
- Activity
- Mean measurement (there are 66 columns of this type, they are described below)


### Subjects (30 participants)

A numeric identifier (1-30) denotes a subject participating in the UCI experiment.

### Activities (6 categories)

Here are the activity names with their numeric identifier (1-6) .

- WALKING (1)
- WALKING_UPSTAIRS (2)
- WALKING_DOWNSTAIRS (3)
- SITTING (4)
- STANDING (5)
- LAYING (6)

### Measurements of interest

There are 66 measurements of interest (i.e. the variables for which the mean is calculated). Refer to the codebook from the original dataset titled ‘features_info.txt’ for more in-depth definitions of the variables given below.

- tBody-Acceleration-mean()-X                
- tBody-Acceleration-mean()-Y                
- tBody-Acceleration-mean()-Z                
- tBody-Acceleration-std()-X                 
- tBody-Acceleration-std()-Y                 
- tBody-Acceleration-std()-Z                 
- tGravity-Acceleration-mean()-X             
- tGravity-Acceleration-mean()-Y             
- tGravity-Acceleration-mean()-Z             
- tGravity-Acceleration-std()-X              
- tGravity-Acceleration-std()-Y              
- tGravity-Acceleration-std()-Z              
- tBody-AccelerationJerk-mean()-X            
- tBody-AccelerationJerk-mean()-Y            
- tBody-AccelerationJerk-mean()-Z            
- tBody-AccelerationJerk-std()-X             
- tBody-AccelerationJerk-std()-Y             
- tBody-AccelerationJerk-std()-Z             
- tBodyGyro-mean()-X                         
- tBodyGyro-mean()-Y                         
- tBodyGyro-mean()-Z                         
- tBodyGyro-std()-X                          
- tBodyGyro-std()-Y                          
- tBodyGyro-std()-Z                          
- tBodyGyroJerk-mean()-X                     
- tBodyGyroJerk-mean()-Y                     
- tBodyGyroJerk-mean()-Z                     
- tBodyGyroJerk-std()-X                      
- tBodyGyroJerk-std()-Y                      
- tBodyGyroJerk-std()-Z                      
- tBody-Acceleration-Magnitude-mean()        
- tBody-Acceleration-Magnitude-std()         
- tGravity-Acceleration-Magnitude-mean()     
- tGravity-Acceleration-Magnitude-std()      
- tBody-AccelerationJerk-Magnitude-mean()    
- tBody-AccelerationJerk-Magnitude-std()     
- tBodyGyro-Magnitude-mean()                 
- tBodyGyro-Magnitude-std()                  
- tBodyGyroJerk-Magnitude-mean()             
- tBodyGyroJerk-Magnitude-std()              
- fBody-Acceleration-mean()-X                
- fBody-Acceleration-mean()-Y                
- fBody-Acceleration-mean()-Z                
- fBody-Acceleration-std()-X                 
- fBody-Acceleration-std()-Y                 
- fBody-Acceleration-std()-Z                 
- fBody-AccelerationJerk-mean()-X            
- fBody-AccelerationJerk-mean()-Y            
- fBody-AccelerationJerk-mean()-Z            
- fBody-AccelerationJerk-std()-X             
- fBody-AccelerationJerk-std()-Y             
- fBody-AccelerationJerk-std()-Z             
- fBodyGyro-mean()-X                         
- fBodyGyro-mean()-Y                         
- fBodyGyro-mean()-Z                         
- fBodyGyro-std()-X                          
- fBodyGyro-std()-Y                          
- fBodyGyro-std()-Z                          
- fBody-Acceleration-Magnitude-mean()        
- fBody-Acceleration-Magnitude-std()         
- fBodyBody-AccelerationJerk-Magnitude-mean()
- fBodyBody-AccelerationJerk-Magnitude-std() 
- fBodyBodyGyro-Magnitude-mean()             
- fBodyBodyGyro-Magnitude-std()              
- fBodyBodyGyroJerk-Magnitude-mean()         
- fBodyBodyGyroJerk-Magnitude-std() 

### Summarizing with mean

Finally we take the mean of each measurement per individual per activity, this is how the dataset is summarized.