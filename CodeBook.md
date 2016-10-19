This file represents a modified version of that provided by the original dataset described on the UCI Machine Learning repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The zip file containing the full dataset is availablefrom: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The modifications to the dataset have amounted to the addition of an "Activity" variable that has more easily readable character values (Walking, Walk_up, Walk_down, Siting, Standing, Laying) compared to the original 6 integer values (1-6), a "Subject" variable, an integer, to more easily distinguish the 30 individuals involved in the experiment.

There is a reduction in the number of measured variables from 561 to 66 that now only deal with mean and standard deviation measures.

There has been a slight ajustment to the individual measured variable names to conserve space along column headings but these should be easily identifiable from the original longer names. That shorter list of modified measured variables is included below but the detailed information describing the measured variables in terms of their original names is retained from the original codebook and can be found under 'Feature Selection'.

Cleaning the data
=================
1. Merges the 'training' and the 'test' data sets to create one data set.

The zip file containing the data and associated files was downloaded using the link to the UCI Machine Learning repository above.

Three files each in respect of training data (X_train.txt, y.train.txt, subject_train.txt) and testing data (X_test.txt, y.test.txt, subject_test.txt) were read into R using read.table.

The three files in each set were 'merged' using cbind in order of values relating to 'activity', 'subject' and 'measured variables'. The context of the experiment suggested that 'activity' would be the main focus of investigation in the sense that the experiment is couched in terms of using phone data to correctly detect the physical activities that the user might be engaged in and that the 'subject' would enable similar characteristics in the activity data to be compared across individuals to determine if there was evidence of a generic pattern across all users for a given activity.

The two sets of resulting data were then 'merged' using rbind to create a single dataframe (mergedPhone).

2. Extracts only the measurements on the mean and standard deviation for each measurement.

The features.txt file was then read into R using read.table to enable identification of measurement variables that only included mean and standard variation values.

A dataframe was constructed for each of the mean (measuresMean) and standard deviation (measuresStd) measurement variables using 'grepl'to include the relevant measurement variable names (e.g. tBodyAcc-mean()-X, tBodyAccMeanY) and their paired default row names (1, 2, 41, 42 etc).

These two files were 'merged' with rbind to create a single dataframe (measuresMandS) which was ordered based on ascending default row names (1, 2, 41, 42 etc).

The full data set of 'merged' 'activity', 'subject' and measurement variable values (mergedPhone) was indexed using the default column names in dataframe measuresMandS with an offset of +2 to accommodate the new 'Activity' and 'Subject' columns creating the dataframe phoneMeasures.

3. Use descriptive activity names to name the 6 activities.

The text file containing the activity labels (activity_labels.txt) was read into R using read.table creating a dataframe actLabels.

The activity labels were modified to shorten them slightly and stored in a new column actLabels$actSmart. 

The numeric identifier (actLabels$actIndex) for each activity label character string was then matched with the activity code (phoneMeasures$Activity) in the large dataframe phoneMeasures which was then modified by the addition of matched activity character strings in place of the numeric activity identifier.

4. Appropriately label the data set with descriptive variable names.

A new index column was added to dataframe measuresMandS to match the default column names (V1, V2, V41, V42 etc) in the large dataframe phoneMeasures.

The measured variable names were then added to phoneMeasures from measureMandS by matching the default column names (V1, V2, V41, V42 etc) in phoneMeasures to the new index in measuresMandS.  

The measured variable names had been modified slightly to reduce column widths, removing punctuation characters and ensuring that the 'M' and 'S' in mean and standard deviation names were capitalised for visibility.

5. From the data set in step 4, creates a second, independent tidy data set.

the reshape2 package was used to melt the phoneMeasures dataframe into a new dataframe phoneMelt, with "Activity' and 'Subject' as 'id variables' and all of the measurement variables as 'variables'. 

dcast was then used on phoneMelt with arguments 'Activity + Subject ~ variable, mean'to create a new tidy dataset in the form of dataframe tidyData as require.

This dataframe was then written to file tidyData.txt using write.table.


Description of data and variables
=================================
Identifying variables:

A   Activity - Activity undertaken while measurement variables were being sampled                               [1.Walking, 2.Walk_up, 3.Walk_down, 4.Siting, 5.Standing, 6.Laying]

B   Subject - Numeric identifier of each participant in the experiment [1-30]

Measurement variables:

1   tBodyAccMeanX
2   tBodyAccMeanY
3   tBodyAccMeanZ
4   tBodyAccStdX
5   tBodyAccStdY
6   tBodyAccStdZ
7   tGtyAccMeanX
8   tGtyAccMeanY
9   tGtyAccMeanZ
10  tGtyAccStdX
11  tGtyAccStdY
12  tGtyAccStdZ
13  tBodyAccJerkMeanX
14  tBodyAccJerkMeanY
15  tBodyAccJerkMeanZ
16  tBodyAccJerkStdX
17  tBodyAccJerkStdY
18  tBodyAccJerkStdZ
19  tBodyGyroMeanX
20  tBodyGyroMeanY
21  tBodyGyroMeanZ
22  tBodyGyroStdX
23  tBodyGyroStdY
24  tBodyGyroStdZ
25  tBodyGyroJerkMeanX
26  tBodyGyroJerkMeanY
27  tBodyGyroJerkMeanZ
28  tBodyGyroJerkStdX
29  tBodyGyroJerkStdY
30  tBodyGyroJerkStdZ
31  tBodyAccMagMean
32  tBodyAccMagStd
33  tGtyAccMagMean
34  tGtyAccMagStd
35  tBodyAccJerkMagMean
36  tBodyAccJerkMagStd
37  tBodyGyroMagMean
38  tBodyGyroMagStd
39  tBodyGyroJerkMagMean
40  tBodyGyroJerkMagStd
41  fBodyAccMeanX
42  fBodyAccMeanY
43  fBodyAccMeanZ
44  fBodyAccStdX
45  fBodyAccStdY
46  fBodyAccStdZ
47  fBodyAccJerkMeanX
48  fBodyAccJerkMeanY
49  fBodyAccJerkMeanZ
50  fBodyAccJerkStdX
51  fBodyAccJerkStdY
52  fBodyAccJerkStdZ
53  fBodyGyroMeanX
54  fBodyGyroMeanY
55  fBodyGyroMeanZ
56  fBodyGyroStdX
57  fBodyGyroStdY
58  fBodyGyroStdZ
59  fBodyAccMagMean
60  fBodyAccMagStd
61  fBodyBodyAccJerkMagMean
62  fBodyBodyAccJerkMagStd
63  fBodyBodyGyroMagMean
64  fBodyBodyGyroMagStd
65  fBodyBodyGyroJerkMagMean
66  fBodyBodyGyroJerkMagStd


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
