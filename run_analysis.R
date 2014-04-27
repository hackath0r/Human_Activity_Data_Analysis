## This script process the raw data obtained from the source and
## cleans it, merges it, and produces a summay of data by calculating averages
## over each activitiy, each subject and each variable
## source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## 1. Merging the training and the test sets to create one data set
X_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
X_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
X <- rbind(X_train, X_test)

subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)

y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")
y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")
y <- rbind(y_train, y_test)

## 2. Extracting only the measurements on the mean and standard deviation
##    for each measurement.
features <- read.table("UCI_HAR_Dataset/features.txt")
mean_std_indicies <- grep(".*mean\\(\\)|.*std\\(\\)", features[,2])
X <- X[, mean_std_indicies]
names(X) <- features[mean_std_indicies,2]

## 3. Using descriptive activity names to name the activities in the data set
activities <- read.table("UCI_HAR_Dataset/activity_labels.txt")
y[,1] = activities[y[,1],2]

## 4. Appropriately labeling the data set with descriptive activity names. 
names(y) <- "ActivityName"
names(subject) <- "SubjectID"
combined <- cbind(subject, y, X)

## 5. Creating a second, independent tidy data set with the average of each 
##    variable for each activity and each subject. 
uniqueSubjects = unique(subject)[,1]
numSubjects = length(uniqueSubjects)
numActivities = length(activities[,1])
numCols = dim(combined)[2]
cleandata = combined[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                cleandata[row, 1] = uniqueSubjects[s]
                cleandata[row, 2] = activities[a, 2]
                tmp <- combined[combined$SubjectID==s & combined$ActivityName==activities[a, 2], ]
                cleandata[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}

## 6. Writing the result to a output file
write.table(cleandata, "../tidy_data.txt")
