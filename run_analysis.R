# Author: Kehinde Rilwan Salau
#         kehinde.salau@gmail.com
#         krsalau@email.arizona.edu
# Created: Mar 20th, 2015
#
#The purpose of this project is to demonstrate my ability to collect, work with,
#and clean a data set. The goal is to prepare a tidy data that can be used 
#for later analysis. The task can be broken into 5 main parts (numbered below). 
#For now, I start with some tasks involving downloading the data and setting 
#directing R to the right directory.
################################################################################

#####Create a data directory and unzip the UCI HAR components
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
  download.file(fileUrl, destfile="UCI_HAR.zip", method="curl")
  unzip("UCI_HAR.zip")
  file.remove("UCI_HAR.zip")
}
################################################################################

##### 1. Merge the training and the test sets to create one data set.###########
# First we merge the training data 
train_sub <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                        col.names=c("subject"))
train_y <- read.table("UCI HAR Dataset/train/y_train.txt",
                      col.names=c("activity"))
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_data <- cbind(train_sub, train_y, train_x)

# Then we merge the test data
test_sub <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                       col.names=c("subject"))
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names=c("activity"))
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_data <- cbind(test_sub, test_y, test_x)

# Finally we merge both train and test data
data <- rbind(train_data, test_data)
################################################################################

##### 2. Extract only the measurements on the mean and standard deviation for 
##### each measurement. 
# Read feature names (careful of order)
feature_list <- read.table("UCI HAR Dataset/features.txt", 
                           col.names = c("id", "name"))
features <- c("subject", "activity",as.vector(feature_list[, "name"]))

# Extract only features that contain 'mean' or 'std' in the name
specific_features <- 
  grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
specific_data <- data[, specific_features]
################################################################################

##### 3. Use descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names=c("id", "name"))
for (i in 1:nrow(activities)) {
  specific_data$activity[specific_data$activity == activities[i, "id"]] <- 
    as.character(activities[i, "name"])
}
################################################################################

##### 4. Appropriately label the data set with descriptive variable names. 
specific_feature_names <- features[specific_features]
specific_feature_names <- gsub("Acc", "-Acceleration", specific_feature_names)
specific_feature_names <- gsub("Mag", "-Magnitude", specific_feature_names)

names(specific_data) <- specific_feature_names #assign names to features
################################################################################

##### 5. From the data set in step 4, create a second, independent tidy data set 
##### with the average of each variable for each activity and each subject.
specific_data_avg <- tbl_df(specific_data) %>%
  group_by(subject, activity) %>% 
  summarise_each(funs(mean)) 
################################################################################

##### Save the data into the file
if (!file.exists("TidyDataAvg.txt")){
  write.table(specific_data_avg, file="TidyDataAvg.txt", row.name=FALSE)
}
################################################################################

##### Finally remove the directory stealing all my dropbox space
unlink("UCI HAR Dataset/",recursive=TRUE)
################################################################################