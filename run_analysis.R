##  Coursera Getting and Cleaning Data Week 4 Assingment Course PRoject

##   Files : /test
##          x-test.txt  Test data of 2947 observations of 561 variables
##          y-test.txt              2947 Activity ID number  
##          subject_test.txt        2947 subject


##  Files : /train
##          X_train.txt Traning data 7352 observations of 561 variables
##          y_train.txt              7352 observations of 561 variables

##***************************************************************************##


##libraries 
install.packages("reshape2")
install.packages("dplyr")
install.packages("plyr")
library(reshape2)
library(dplyr)
library(plyr)


##creating features & activity data frames 

variable_name<- read.table("features.txt")
activity_label <- read.table("activity_labels.txt")

##Training data  - Creating corresponding data frames
subject_train<- read.table("subject_train.txt")
y_train <- read.table("y_train.txt")
X_train <- read.table("X_train.txt")

##Test Data - Creating corresponding data frames
subject_test <- read.table("subject_test.txt")
y_test <- read.table("y_test.txt")
X_test <- read.table("X_test.txt")


## 1) Merge training and test data frames through rbind() function to create one data set.
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
colnames(subject_data) <- "subject"

## 2) Extracts only the measurements on the mean and standard deviation for each measurement. ***

extracted_data <- variable_name[grep("mean\\(\\)|std\\(\\)", variable_name[,2]),]
X_data <- X_data[,extracted_data[,1]]


## 3) Adding decriptive values for activity labels. ##

colnames(y_data) <- "activity"
y_data$activityLabel <- factor(y_data$activity, labels = as.character(activity_label[, 2]))
activityLabel <- y_data[ , -1]


## 4) Appropriately labels the data set with descriptive variable names.

colnames(X_data) <- variable_name[extracted_data[,1],2]


## 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
mean_total <- cbind(X_data, activityLabel, subject_data)
summary <- mean_total %>% group_by(activityLabel, subject) %>% summarise_each(funs(mean))
write.table(summary, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE)

## check
tidydata <- read.table("tidydata.txt")




