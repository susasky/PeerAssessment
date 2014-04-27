The run_analysis.R script is designed to clean up some of the data contained in the file that can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It assumes that in the working directory contains the files:
* activity_labels.txt
* features.txt
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt

It loads the package reshape2

The script performs the following:
a. reads the files:
	* test/subject_test.txt
	* test/X_test.txt
	* test/y_test.txt
	* train/subject_train.txt
	* train/X_train.txt
	* train/y_train.txt
b. Merges the training and the test sets to create one data set. (the merged dataset is called dataMerge) adding the subject_id and the activity_id columns to the dataset
c. Reads the features.txt file
d. extracts only the features that contain the "mean" or "std" pattern using a pattern matching function
e. saves the features names and the index in separate vectors
f. Extracts from the dataset dataMerge only the measurements on the mean and standard deviation for each measurement. (the dataset where data of interest have been extracted is called dataSet.
g. Renames the columns in the data set using the descriptive features names. 
h. Appropriately labels the data set with descriptive activity names.
i. writes the dataset dataSet to a file named "tidy_data_4.txt" 
l. Starting from the dataMerge dataset the script melts the data using the columns "subject_id", "activity_id" and "activity" as identifiers
m. Creates a second, independent tidy data set with the average of each variable for each activity and each subject (byactsubj)
n. writes the dataset byactsubj to a file named "tidy_data_5.txt"  
