# coursera-cleaning-data-course-project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1) Load the activity and feature/variable details.
2) Load both the training and test datasets, and keeps only the columns with 'mean' or 'std' (standard deviation).
3) Loads the activity and subject data for training and test datasets, and merges them with the columns of the datasets.
4) Merges the two datasets.
5) Converts the activity and subject columns into factors.
6) Creates a new dataset consisting of the average (mean) of each variable for each subject and activity.
7) The end result is shown in the file tidy.txt.
