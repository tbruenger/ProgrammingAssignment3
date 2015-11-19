# ProgrammingAssignment3
Getting and Cleaning Data Course Project

There are 2 skripts:
load_data.R and run_analysis.R

## load_data.R
download the zipped data file & extract the data files

## run_analysis.R
uses Library data.table

1. Merges the training and the test sets to create one dt set
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the dt set
4. Appropriately labels the dt set with descriptive variable names. 
5. From the dt set in step 4, creates a second, independent tidy dt set with the average of each variable for each activity and each subject.
6. Saves the second dataset in the file har_mean.txt

You must execute load_data.R first and then run run_analysis.R
