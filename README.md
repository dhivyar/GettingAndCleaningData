GettingAndCleaningData
======================

Coursera Course Getting and Cleaning Data

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The Github repository GettingAndCleaning Data contains the following files:

'README.md'- Explains how all of the scripts work and how they are connected.
'CodeBook.md'- A code book which describes the variables, the data, and any transformations or work that have been performed to clean up the data
'run_analysis.R' - The script which performs the following operations:
		Merges the training and the test sets to create one data set.
		Extracts only the measurements on the mean and standard deviation for each measurement. 
		Uses descriptive activity names to name the activities in the data set
		Appropriately labels the data set with descriptive activity names. 
		Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
'tidydatadhivyar.xlsx' - The output after running the script in R which is a tidy data set

==================================================================

Steps:

Open RStudio and install R packages 'xlsx' and 'reshape2' if you don't have them already using the commands install.packages("xlsx") and install.packages("reshape2").
Save the run_analysis.R script in your local drive.
Make the RStudio look in the same directory as in step 2 using the setwd("..") command.
In the console window of RStudio, type source("run_analysis.R").
The script will run and will take some time to execute since it has to download and perform analysis over a ~57MB data set.
Once the script is run, the control will return back to the user in the console window.
The output of the script will be stored in the same directory as a 'xlsx' file (Excel Spreadsheet).
The output will have 180 rows of average values of measurements with mean or standard deviation of the test and training data and 79 different measurements for each subject and activity performed.


 
