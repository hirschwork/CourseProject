library(plyr)
library(reshape2)

### Assume data has already been downloaded
###  #Add directory if not there
###  if(!file.exists("./data")){dir.create("./data")}

###  setwd("./data")

###  # get the zip file
###  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
###  download.file(fileUrl, destfile = "./Dataset.zip")

###  cat("download completed at:  ", date(), "\n")
###

# unzip the file
unzip("./UCI CHAR Dataset.zip")

# move into the file folder
WD <- getwd()
setwd("./UCI HAR Dataset")

## Read in list of features so later these can be substituted as readable column names
myfeat <- read.table("features.txt")

## Read in list of activities so later these can be substituted as readable values
myAct <- read.table("activity_labels.txt")


## Go through column names and tag those which are "means" or "std dev" and put into vector (colnum). These are the only
## features (columns) we want in our final data set.
c <- numeric()
colnum <- NULL

for (ii in 1:nrow(myfeat)) {
  if (grepl("mean", myfeat$V2[ii])  ||  grepl("std", myfeat$V2[ii])) {
    # found one, put it in the list
    colnum <- c(colnum, ii)
  }
}



## Get the Test data first

setwd("./test")

## Read in activity label vector. We'll append this column later to the final data set
##
mylabels <- read.table("y_test.txt")
# Get Train data
mylabelsTrain <- read.table("../train/y_train.txt")
#   combine data
mylabels <- rbind(mylabels, mylabelsTrain)

colnames(mylabels) <- c("activity")
#   convert to factors
mylabels$activity <- as.factor(mylabels$activity)
#   now convert numerics to strings using levels
levels(mylabels$activity) <- myAct$V2



## Read in subject vector
##
mySubj <- read.table("subject_test.txt")
## Get Train data too
mySubjTrain <- read.table("../train/subject_train.txt")
# combine the two data sets
mySubj <- rbind(mySubj, mySubjTrain)
#   Give a proper column name
colnames(mySubj) <- c("subject")

## Finally, now read in some data
##
# read in test set
mydata <- read.table("X_test.txt")
# read in train set
mydataTrain <- read.table("../train/X_train.txt")
#   combine data sets
mydata <- rbind(mydata, mydataTrain)

# Convert column names to what they are defined in files
colnames(mydata) <- myfeat$V2

## Create new data frame only with columns requested and tag on the activity and subject
combined <- data.frame()
combined <- cbind(mydata[, colnum])
# Add in the activity
combined <- cbind(combined, mylabels)
# Add in the subject vector
combined <- cbind(combined, mySubj)

# Ugly step, reset the dataframe so that column names are valid
combined <- data.frame(combined)


# wide to long conversion - convert all the feature columns into a single column
longDF <- melt(combined, id.vars=c("activity","subject"), variable.name="metric", value.name="metricMean")

# Now run split/apply/combine to aggregate (i.e. group-by)
finalDF <- ddply(longDF, .(subject, activity, metric), summarize, metricMean=mean(metricMean))

setwd(WD)

# Write out dataset
write.table(finalDF, file="MeanResults.txt", row.names=FALSE)


finalDF
