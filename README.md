The course project for the Getting and Cleaning Data. 

The script, run_analysis.R, does the following steps:

1.Download the dataset 
2.Load the activity and feature infomation
3.Loads both the training and test datasets, keeping only the columns relevent to mean or standard deviation
4.Loads the activity and subject data and merges those columns with training and testing datasets
5.Merges the training and testing datasets
6.Converts the activity and subject columns into factors
7.Creates the final  dataset that wich includes the mean of each variable for each subject and activity.
8.Writing the final table into a text file called tidy.txt.

