GetCleanDataProject
===================

1. A subject, activity, and data set were combined for the training set and test set. These 2 complete sets were then combined into one larger data set. The list of features in features.txt was then used to name each appropriate column in the dataset. 

2. A subset of variables only pertaining to the mean and standard deviations wihtin the larger dataset was then taken by extracting only columns with names with a partial match of "mean", "Mean", or "std". This new dataset also included the subject and activitiy columns from the larger dataset. 

3. Numbers 1 through 6 were replaced with more descriptive ids for each activity  using the activity_labels.txt, which includes the names for activities coded 1 through 6 were (respectively): Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing, Laying.

4. More appropriate variable names were created by replacing all dashes and parantheses in variable names with dots. Due to the large number of variables included (86), no other changes to variable names were made, however their definitions are included in the code book. 

5. An independent, tidy data set was created of the average measurement of each variable for each activity for each subject (ie., 86 averages [one for each variable] for each of the 6 activities for each of the 30 subjects).  
