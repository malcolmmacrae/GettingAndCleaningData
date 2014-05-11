#   Load library to melt and recast data frames.
library(reshape2)

#   Set working directory to base directory: ~/UCI HAR Dataset/
##  COMMENT ME OUT BEFORE SUBMITTING!
##	setwd("C:/Users/mmacrae/Coursera/3. Getting and Cleaning Data/UCI HAR Dataset")

#   Load factor labels from text files.
y.levels <- read.table("activity_labels.txt")
x.names <- read.table("features.txt")

#   Load training data from ./train subdirectory.
subject.train <- read.table("./train/subject_train.txt")
x.train <- read.table("./train/X_train.txt")
y.train <- read.table("./train/y_train.txt")
cat("Training data record count matches: ",
    nrow(subject.train)==nrow(x.train) & nrow(x.train)==nrow(y.train))

#   Load test data from ./test subdirectory.
subject.test <- read.table("./test/subject_test.txt")
x.test <- read.table("./test/X_test.txt")
y.test <- read.table("./test/y_test.txt")
cat("Test data record count matches: ",
    nrow(subject.test)==nrow(x.test) & nrow(x.test)==nrow(y.test))

#   Merge training and test data into single data set.
dat.all <-rbind(data.frame("subject"=subject.test,"x"=x.test,"y"=y.test),
                data.frame("subject"=subject.train,"x"=x.train,"y"=y.train))

#   Identify indices of means and standard deviations for each measurement.
x.indices <- sort(unique(c(grep("mean()",x.names[,2],fixed=TRUE),
                           grep("std()",x.names[,2],fixed=TRUE))))

#   Extract only the means and standard deviations for each measurement.
dat <- dat.all[,c(1,c(x.indices+1),
                  ncol(dat.all))]

#   Count unique subject levels.
subject <- unique(dat[,1])

#   Label data table with descriptive field names.
colNames.raw <- tolower(as.character(x.names[x.indices,2]))
colNames <- gsub("\\-","",colNames.raw)
colNames <- gsub("\\(","",colNames)
colNames <- gsub("\\)","",colNames)
names(dat) = c("subject", c(colNames), "activity")

#   Convert subject and activity data to factors.
dat[,1] <- factor(unlist(dat[,1]))
dat[,ncol(dat)] <- factor(unlist(dat[,ncol(dat)]), labels=y.levels[,2])

#   Melt detailed data into long data set.
##  melt() represents measure variables as factor levels.
dat.melt <- melt(dat, 
                 id=c(names(dat)[c(1,ncol(dat))]),
                 measure.vars=c(names(dat)[c(2:(ncol(dat)-1))])
    )

#   Calculate mean by 1. subject, 2. activity, and 3. variable.
dat.summary <- tapply(dat.melt$value,
                      list("subject"=dat.melt$subject,
                           "activity"=dat.melt$activity,
                           "statistic"=dat.melt$variable),
                      mean)

#   Convert three-dimensional summary table to flat contingency table.
dat.ft <- ftable(dat.summary, 
                 row.vars=c("subject","activity"), 
                 col.vars="statistic")

#   Write flat contingency table to text file.
write.ftable(dat.ft, "UCI HAR ft.txt")