The script run_analysis.R gets data from the website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data are collected starting from the file that can be downloaded by the url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data are mesurements collected from an experiment where 30 volunteers where performing six different motion activities wearing a Samsung smartphone with embedded accelerometer.
The experiment was aimed at correlating the motion activities with the data collected by the accelerometers.

While unzipping the file a directory called "UCI HAR Dataset" is created.
Inside the main directory, two sub-directory are created: "test" and "train".
For the purpose of this analysis I have considered the files:
* activity_labels.txt
* features.txt
from the main directory, the files:
* subject_test.txt
* X_test.txt
* y_test.txt
from the test directory and the files:
* subject_train.txt
* X_train.txt
* y_train.txt

the training and test datasets (train/X_train.txt and test/X_test.txt) have been merged together in a single dataframe,
a column indicating the subject identifier, read from files train/subject_train.txt and test/subject_test.txt has been added with the name of "subject_id" and a column indicating the activity identifier read from files test/y_test.txt train/y_train.txt has been added as well ("activity_id"). The dataframe obtained has 10299 observations for 564 variables (including the descriptive ones).  [step x]

The dataframe obtained in [step x] has been filtered to show only the variables containing means or standard deviations values: to perform the filtering a pattern match has been performed on the features.txt file to extract only the features names that was containing the "mean" or "std" strings, those were the variables we wanted to keep in the final dataframe.
Using the grep expression, both the names and the identifiers of the columns have been extracted for filtering
The names have been used to expicitate the columns names while the indexes were used for the actual filtering.
A new column explicitating the activity according to the description provided in the file "activity_labels.txt" has been added as well; the three new columns have been moved to be the first three columns in the filtered dataframe.

The new dataframe has been saved with name "tidy_data_4.txt", it contains 10299 observations for 82 variables.

Another dataframe has been produced starting from the one produced in [step x]
Column names has been added reading the features.txt file
A column explicitating the activity name hase been added accroding to the description provided in the file activity_labels.txt.
The last three columns containing the subject_id, the activity_id and the activity description has been moved to be the three first columns of the dataframe and the dataframe has been melted considering this three columns as identifiers and the remaining 561 as variables.
The data has finally been summarized using the subject_id and the activity identifiers and getting the mean of variables for each combination of the two identifiers.
The final dataframe has been saved to a file named "tidy_data_5.txt" and it contains 180 rows by 563 columns
