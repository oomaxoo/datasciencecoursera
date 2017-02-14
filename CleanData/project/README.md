Getting and Cleaning Data Course Project
========================================

The project to get the data from Human Activity Recognition Using Smartphones Data Set by UCI and produce a single clean dataset with all the training and testing data. Only mean and standard deviation feature data is required.  

Project Files
-------------

### Code Files

run_analysis.R - code for getting the tidied up data
codebook.txt - code book for variables in run_analysis.R
tidy_mean_dataset.txt - output data file

### Source Data Files - UCI HAR Dataset folder

activity_labels.txt - contains activity label id and description
features.txt - contains feature id and description
features_info.txt - not used for the project
README.txt - Dataset detailed description

train folder - training data

subject_train.txt - subject id for each measurement
y_train.txt - activity id for each measurement
X_train.txt - measurement data. Each row is for 1 subject and 1 activity and contains 561 feature values
Inertial Signals - not used for the project

test folder - testing data

subject_test.txt - subject id for each measurement
y_test.txt - activity id for each measurement
X_test.txt - measurement data. Each row is for 1 subject and 1 activity and contains 561 feature values
Inertial Signals - not used for the project


How does it work - run_analysis.R
---------------------------------

## run_analysis.R is designed to clean up the data as required by the course project. Apart from the base packages, it requires two extra packages - dplyr and reshape2.

1. Load in dplyr and reshape2 packages
2. Load in data from the source files including activity label definition, measurement feature definition, training data set and testing data set. There are 3 components for the training and testing data, volunteers/subject id, activity id and 561 measured features. The sensor readings in Inertial Signals folder are not relevant to this project work. 
3. Merge the trainging and testing data set into one. the data was recorded for 30 volunteers/subjects. The measurements of the same subject group were splited into training data set(collected from 70% volunteers) and testing data set(collected from 30% volunteers). There are 561 features in total for one record. It is found the data read in is not well formated. The excessive blank values produced by the extras whitespaces are removed by the code.
4. Filter out the merged data from Step 3 to have only meean and standard deviation features rather than including all 561 features. feature data was loaded and filtered out in Step 2 which is used to filter the merged data.
5. Assign the feature descriptions to the filtered data as column names. The descriptions are loaded form the definition file in Step 2.
6. Put subject id (sid), activity id (aid), activtiy description and filtered data from Step 5 into one data frame. Now we have our first tidy data set. The activity name is referenced from the label data loaded in Step 2 and linked by the activity id. 
7. Calculate the mean value of the features for each subjects and activities. Used melt function to define the ids and variables and then used dcast function to group the data and calculate the mean. 
