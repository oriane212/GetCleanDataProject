
# read files

features <- read.table("features.txt", header=FALSE)

subject_train <- read.table("subject_train.txt", header=FALSE)
y_train <- read.table("y_train.txt", header=FALSE)
X_train <- read.table("X_train.txt", header=FALSE)

subject_test <- read.table("subject_test.txt", header=FALSE)
y_test <- read.table("y_test.txt", header=FALSE)
X_test <- read.table("X_test.txt", header=FALSE)

# make them into dataframes

subject_train_DF = data.frame(subject_train)
y_train_DF = data.frame(y_train)
X_train_DF = data.frame(X_train)

subject_test_DF = data.frame(subject_test)
y_test_DF = data.frame(y_test)
X_test_DF = data.frame(X_test)


1. Merge the training and the test sets to create one data set.

# name columns in training and test sets by features
names(X_test_DF) <- features$V2[1:561]
names(X_train_DF) <- features$V2[1:561]

# name columns in subject and activity files
names(y_test_DF) <- c("activity")
names(y_train_DF) <- c("activity")

names(subject_test_DF) <- c("subject")
names(subject_train_DF) <- c("subject")

# bind test set data frames
test_cBind <- cbind(subject_test_DF,y_test_DF, X_test_DF)

# bind training set data frames
train_cBind <- cbind(subject_train_DF,y_train_DF, X_train_DF)

# merge to create larger data set 
boundSubjects <- rbind(subject_test_DF, subject_train_DF)
boundActivities <- rbind(y_test_DF, y_train_DF)
boundFeatures <- rbind(X_test_DF, X_train_DF)
largeData <- cbind(boundFeatures, boundActivities, boundSubjects)


2. Extract only the measurements on the mean and standard deviation for each measurement. 

# use partial match search to locate feature columns that include the words "mean", "Mean", and "std" and store in a list. 

MeanList <- grep("Mean", features$V2); 
meanList <- grep("mean", features$V2); 
stdList <- grep("std", features$V2); 

mean_lists = append(MeanList, meanList)
combined_lists = append(mean_lists, stdList)

# subset the merged train/test set using the list of variables to extract

mean_std_SUBSET <- largeData[,combined_lists]

# add back the activity and subject columns to the new subset

mean_std_SUBSET$activity <- largeData$activity
mean_std_SUBSET$subject <- largeData$subject



3. Use descriptive activity names to name the activities in the data set

# replace all #s with more descriptive activity names

mean_std_SUBSET$activity <- gsub("1", "WALKING", mean_std_SUBSET$activity)

mean_std_SUBSET$activity <- gsub("2", "WALKING_UPSTAIRS", mean_std_SUBSET$activity)

mean_std_SUBSET$activity <- gsub("3", "WALKING_DOWNSTAIRS", mean_std_SUBSET$activity)

mean_std_SUBSET$activity <- gsub("4", "SITTING", mean_std_SUBSET$activity)

mean_std_SUBSET$activity <- gsub("5", "STANDING", mean_std_SUBSET$activity)

mean_std_SUBSET$activity <- gsub("6", "LAYING", mean_std_SUBSET$activity)


4. Appropriately label the data set with descriptive variable names. 

#remove dashes and parantheses 
names(mean_std_SUBSET) <- gsub("-", ".", names(mean_std_SUBSET))

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# aggregate a subset of the first 10 variables to create new data set

tidyData <- aggregate(cbind(mean_std_SUBSET[,1], mean_std_SUBSET[,2], mean_std_SUBSET[,3], mean_std_SUBSET[,4], mean_std_SUBSET[,5], mean_std_SUBSET[,6], mean_std_SUBSET[,7], mean_std_SUBSET[,8], mean_std_SUBSET[,9], mean_std_SUBSET[,10])~subject + activity, data = mean_std_SUBSET, mean, na.rm=TRUE)

# use write.table to create a new txt file, with rownames set to FALSE

write.table(tidyData, file="tidyData.txt", sep=" ", col.names = FALSE, row.names = FALSE)
