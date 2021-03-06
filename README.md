The script run_analysis.R downloads a zipfile containing text files (.txt) of smartphone data from the UCI Machine Learning Repository. The data comprises 561 readings from the phones accelerometer and gyros that provides movement data sampled 50 times per second during the course of the experiment in which 30 human subjects performed 6 activities (Walking, walking upstairs, walking downstairs, sitting, standing and laying down).

The downloaded files are combined so that 'activity', 'subject' and measurement variable data are combined in a single dataframe. A subset of 66 mean and standard deviation measurement variables out of a total dataset of 561 measurement variables is extracted and appropriate variable labels are added.  

The context for the experiment from which the phone data was generated appears to be concerned with analysing the movements of a variety of subjects with a view to being able to use smartphones to determine the activity that a phone user is currently performing. This data could be used for a variety of purposes for example identifying and then tracking physical activity as part of a workout.

With this in mind the shape of the tidy data has been chosen as a dataframe with 2 columns representing 'Activity' and 'Subject' as identifier variables and a further 66 columns representing mean and standard deviation measurement variables as a subset of the full dataset of 561 measurement variables. Evidently this tidy data takes a wide format.

Reading the tidy dataset into R
===============================
The following code enables the tidy dataset generated by run_analysis.R to be read into and viewed in R .

TidyData <- read.table("./tidyData.txt", sep="", header=TRUE)
View(TidyData)