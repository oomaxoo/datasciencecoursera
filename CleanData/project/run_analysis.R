# Load packages

## pipe operator needs package magrittr which is refed by package dplyr
library(dplyr)
library(reshape2)


# Load the raw data from file system

## get activity label definition
raw_labels <- readLines("UCI HAR Dataset/activity_labels.txt") %>% strsplit(" ")
labels <- data.frame(id = sapply(raw_labels, "[[", 1), activity = sapply(raw_labels, "[[", 2))

## get feature definition with only mean and standard deviation measurements
raw_features <- readLines("UCI HAR Dataset/features.txt") 
tmp_features <- raw_features[grep("(mean)|(std)", raw_features)] %>% strsplit(" ")
features <- data.frame(id = sapply(tmp_features, "[[", 1), activity = sapply(tmp_features, "[[", 2))

## get training data
raw_train_subject <- readLines("UCI HAR Dataset/train/subject_train.txt")
raw_train_data <- readLines("UCI HAR Dataset/train/X_train.txt") %>% strsplit(" ") %>% 
  sapply(as.numeric) %>%  sapply(function(x) { x[!is.na(x)] }) %>% t
raw_train_activity <- readLines("UCI HAR Dataset/train/y_train.txt")

## get test data
raw_test_subject <- readLines("UCI HAR Dataset/test/subject_test.txt")
raw_test_data <- readLines("UCI HAR Dataset/test/X_test.txt") %>% strsplit(" ") %>% 
  sapply(as.numeric) %>%  sapply(function(x) { x[!is.na(x)] }) %>% t
raw_test_activity <- readLines("UCI HAR Dataset/test/y_test.txt")


# Merges the training and the test sets to create one data set.

merged_data <- rbind(raw_train_data, raw_test_data)


# Extracts only the measurements on the mean and standard deviation for each measurement. 

## filter out the data to have only mean and standard deviation measurements
filtered_data <- data.frame(merged_data[, features$id])


# Uses descriptive activity names to name the activities in the data set

## assign feature name to the data columns
colnames(filtered_data) <- features$activity


# Appropriately labels the data set with descriptive variable names. 

## generate the final data
final_data <- data.frame(sid = c(raw_train_subject, raw_test_subject), 
                     aid = c(raw_train_activity, raw_test_activity), 
                     activity = c(raw_train_activity, raw_test_activity),  
                     filtered_data, check.names = FALSE) %>% mutate(activity = labels[aid, 2])


# From the data set in step 4, creates a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.

mean_data <- melt(final_data, id = c("sid", "aid", "activity"), measure.vars = features$activity) %>%
  dcast(sid + aid + activity ~ variable, mean)

# Output

## write.table(mean_data, "tidied_data.txt", row.names = FALSE)
mean_data

