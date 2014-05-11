#   Code book for Human Activity Recognition Using Smartphones Dataset

Raw data sourced from [zip-compressed archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

"run_analysis.R" R script outputs "UCI HAR ft.txt" fixed-width text file containing a three-dimensional contingency table.

Contingency-table dimensions:
* Rows: Subject, Activity
* Columns: Statistic
* Values: Mean value over testing and training data sets.

This file was written using the write.ftable() function from R.
It can be read using the read.ftable() function.
Accuracy losses between results and output due to truncation are less than 5e-8 in magnitude.

#   Subject

ID number corresponding to the subject who performed the experiment.

#   Activity

Activity that each subject was performing.

#   Statistic

Variable under observation.

##  Domain

Symbol|Interpretation
------|-------------------
t|Time-domain signals
f|Frequency-domain signal

##  Features

Features definitions are provided in the features_info.txt file.

Symbol|Interpretation
------|-------------------
bodyacc|
gravityacc|
bodyaccjerk|
bodygyro|
bodygyrojerk|
bodyaccmag|
gravityaccmag|
bodyaccjerkmag|
bodygyromag|
bodygyrojerkmag|
bodybodyaccjerkmag|
bodybodygyromag|
bodybodygyrojerkmag|

##  Variable

Symbol|Interpretation
------|-------------------
mean|Average
std|Standard deviation

##  Direction

Symbol|Interpretation
------|-------------------
x|X-dimension
y|Y-dimension
z|Z-dimension
