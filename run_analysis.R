## Course: Project for Getting and Cleaning Data
## User: dhivyar
## GitHub: https://github.com/dhivyar
 
## This script will perform the following:
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive activity names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Include 'reshape2' library
library(reshape2)
library(xlsx)
## URL for the input data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Download the data
download.file(url, "sgetdata_projectfiles_UCI HAR Dataset.zip")
## Unzip the file to a local directory
unzip("sgetdata_projectfiles_UCI HAR Dataset.zip", exdir= "UCI HAR Dataset")
## List of files contained in the zip file
files_full <- list.files("UCI HAR Dataset", full.names=TRUE)

##******************************************************************************************
## Create an empty data frame
data1 <- data.frame()
## Read the test data obtained from 30% of the test volunteers
data1 <- rbind (data1, read.table("UCI HAR Dataset/test/X_test.txt"))
## Add the training data to the same data frame (obtained from 70% of the test volunteers)
data2 <- rbind (data1, read.table("UCI HAR Dataset/train/X_train.txt"))
## Read the 'features' file which contains the corresponding column names for the 'test' and 'train' data sets
features <- read.table("UCI HAR Dataset/features.txt")
## Tidy up the features file (column names) using gsub
features$V3<-gsub("[(),-]","",features$V2)
## Assign the data frame with its column names
names(data2) <- features$V3

##******************************************************************************************
## Create an empty data frame
data3 <- data.frame()
## Read the test and train data of the activities performed by the test volunteers
data3 <- rbind (data3, read.table("UCI HAR Dataset/test/y_test.txt"))
data4 <- rbind (data3, read.table("UCI HAR Dataset/train/y_train.txt"))
## Since this data is in numeric format, we want to change this into descriptive format, which is easier
## if this data frame is temporarily converted to a matrix
## Make a matrix out of the data frame
m1 <- as.matrix(data4)
## Assign descriptive text to the numeric values as given in the activity_labels file
m1[m1==1] <- "Walking"
m1[m1==2] <- "Walking_Upstairs"
m1[m1==3] <- "Walking_Downstairs"
m1[m1==4] <- "Sitting"
m1[m1==5] <- "Standing"
m1[m1==6] <- "Laying"
## Convert back the matrix to a data frame
data4 <- as.data.frame(m1)

##*****************************************************************************************
## Create an empty data frame
data5 <- data.frame()
## Read the test and train volunteers who are represented as numbers
data5 <- rbind (data5, read.table("UCI HAR Dataset/test/subject_test.txt"))
data6 <- rbind (data5, read.table("UCI HAR Dataset/train/subject_train.txt"))

##*****************************************************************************************
## Create an empty data frame with 10299 rows since that is the number of rows in the previous 
## data sets we have created thus far
result1 <-data.frame(row.names=1:10299)
## Bind the data sets which have the subject and activityPerformed data into one data frame 
result1 <- cbind (result1, data6)
result1 <- cbind (result1, data4)
## Add column names for this data for better readability
names(result1) <- c("subject", "activityPerformed")
## Bind the test and train data sets to this data to form one data set
result1 <- cbind (result1, data2)

##********************************************************************************************
## Assign a variable which stores all the tidied up names of the columns of the test and train data sets
meanStdVariables <- features$V3
## Filter out the measurements relating to mean or standard deviation using grep
good<- grep("std|mean",meanStdVariables)
## Create a new data frame with only the mean and standard deviation measurements
result2 <- result1[,good]
## Melt the data frame to stack the columns 'subject' and 'activityPerformed' into a single column of data
## using melt (Needs package 'reshape2') installed
mresult2 <- melt(result2, id=c("subject","activityPerformed"))
## Dcast the melted data drame into the end product on the basis of the average of each variable 
## for each activity and each subject
dcastmean <- dcast(mresult2, subject+activityPerformed~variable, mean)
## Export the data into a excel spreadsheet which will be stored in the location as given
## by the "getwd()" command
## Can also export to a text format, the code for which is not presented here but can be done
## using the following command: write.table(dcastmean, "tidydatadhivyar.txt", sep="\t")
write.xlsx(dcastmean, "tidydatadhivyar.xlsx")


