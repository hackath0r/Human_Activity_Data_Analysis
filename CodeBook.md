Data
----

* For original source of data [click here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

* For more description [click here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Data Transformation
-------------------

* Train and Test data in train and test folder respectivly, are merged to form single data set X(obeservation for different variables), y(activity IDs) and subject (subject IDs)
* From features.txt file indices for only the measurement on mean and standard deviation for each mesurement is extracted.
This results in 66 indicies, which is then used to subset X dataset to have only 66 columns to contain only mean and standard deviation variables.
* From activity_labels.txt activity names are used to replace the activity IDs in y by descriptive activity names.
* Lables for dataset y and subject is set to ActivityNames and SubjectID respectively.
* Dataset X, y and subject are combined to form a combined table as combined dataset.
* At last independent tidy data set with average of each measurement for each activity and each subject is created as tidy.txt.
Resulting tidy dataset is 180 * 68; First column is **SubjectID(1..30)**, second column is **ActivtyName(6 possible names)** and rest of the columns are variables including 3D acceleration readings(only mean and standard deviation) 
