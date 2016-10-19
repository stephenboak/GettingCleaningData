## 1. Merges the 'training' and the 'test' data sets to create one data set.
## Download and Read in data files.

##  if(!file.exists("./data")) {dir.create("./data")}
##  fileUrl <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
##  download.file(fileUrl, destfile = "./data/smartphoneData.zip")
##  unzip(zipfile="./data/smartphoneData.zip",exdir="./data/smartphone")
    
## Read "test" data files    
    testData <- read.table("./data/smartphone/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
    actTestData <- read.table("./data/smartphone/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
    names(actTestData) <- "Activity"
    subTestData <- read.table("./data/smartphone/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
    names(subTestData) <- "Subject"
    
## Read "train" data files
    trainData <- read.table("./data/smartphone/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
    actTrainData <- read.table("./data/smartphone/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
    names(actTrainData) <- "Activity"
    subTrainData <- read.table("./data/smartphone/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
    names(subTrainData) <- "Subject"

    ## Column-bind activity (y-train/test.txt data), subject
    ## (subject_train/test.txt data) and measurements (X_train/test.txt data).
    
        ## column-bind "test" data
        test <- cbind(actTestData, subTestData, testData)
    
        ## column-bind "train" data
        train <- cbind(actTrainData, subTrainData, trainData)

        ## Row-bind resulting "test" and "train" data.
        mergedPhone <- rbind(train, test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## This has been restricted to 66 measurements that form mean and standard deviation pairs.
    ## 2.a. Isolate mean & std pair variables
        
        library(dplyr)
        library(plyr)
        measuresList <- read.table("./data/smartphone/UCI HAR Dataset/features.txt", sep="", header=FALSE, stringsAsFactors = FALSE)
        names(measuresList) <- c("mesIndex", "mesText")
        
        measuresMean <- measuresList[grepl("-mean()", measuresList$mesText, fixed = TRUE), ]
        measuresStd <- measuresList[grepl("-std()", measuresList$mesText, fixed = TRUE), ]

        measuresMandS <- rbind(measuresMean, measuresStd, stringsAsFactors = FALSE)
        measuresMandS <- measuresMandS[order(measuresMandS$mesIndex), ]

        phoneMeasures <- mergedPhone[ ,measuresMandS$mesIndex+2]
        Activity <- mergedPhone$Activity
        Subject <- mergedPhone$Subject
        phoneMeasures <- cbind(Activity, Subject, phoneMeasures)
        
## 3. Use descriptive activity names to name the 6 activities
## (e.g. 1:WALKING, 2:WALKING_UPSTAIRS, etc ) in the data set.

        ## Read activity label file
        actLabels <- read.table("./data/smartphone/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
        actLabels$actSmart <- c("Walking", "Walk_up", "Walk_down", "Sitting", "Standing", "Laying")
        names(actLabels) <- c("actIndex", "actName", "actSmart")
        phoneMeasures$Activity <- actLabels$actSmart[match(phoneMeasures$Activity, actLabels$actIndex)]
        
## 4. Appropriately label the data set with descriptive variable names
## (e.g. tBodyAccMeanX, tBodyAccStdX).
        
        measuresMandS$VInd <- paste("V", measuresMandS$mesIndex, sep = "")
        measuresMandS$mesSmart <- gsub("[[:punct:]]", "", measuresMandS$mesText)
        measuresMandS$mesSmart <- gsub("std", "Std", measuresMandS$mesSmart)
        measuresMandS$mesSmart <- gsub("mean", "Mean", measuresMandS$mesSmart)
        measuresMandS$mesSmart <- gsub("Gravity", "Gty", measuresMandS$mesSmart)

        names(phoneMeasures) <- measuresMandS$mesSmart[match(names(phoneMeasures), measuresMandS$VInd)]
        names(phoneMeasures)[1] <- "Activity"
        names(phoneMeasures)[2] <- "Subject"

## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
## The data has been arranged to give 'activity' primacy as is suggested by the context of the experiment.
        
        library(reshape2)
        phoneMelt <- melt(phoneMeasures, id = c("Activity", "Subject"))
        tidyData <- dcast(phoneMelt, Activity + Subject ~ variable, mean)
        
        write.table(tidyData, file = "tidyData.txt", quote = FALSE, sep="\t", row.names=FALSE)
        
        
        