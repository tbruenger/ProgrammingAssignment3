#--------------------------------------------------------------------
# run_analysis.R
# 1. Merges the training and the test sets to create one dt set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the dt set
# 4. Appropriately labels the dt set with descriptive variable names. 
# 5. From the dt set in step 4, creates a second, independent tidy dt set with the average 
#       of each variable for each activity and each subject.
#
# 19.XI.2015 tbr
#
#--------------------------------------------------------------------
library(data.table)

read_DT <- function(name) {
    # ext <- "100"
    ext <- "txt"
    x <- fread(sprintf("./UCI HAR dataset/%s/X_%s.%s", name, name, ext))
    y <- fread(sprintf("./UCI HAR dataset/%s/y_%s.%s", name, name, ext))
    s <- fread(sprintf("./UCI HAR dataset/%s/subject_%s.%s", name, name, ext))
    x[, subject := s]
    x[, activity := y]
    x
}

# read features, dt sets & activity labels
features <- fread("./UCI HAR dataset/features.txt")
names(features) <- c("idx", "name")
activity <- fread("./UCI HAR dataset/activity_labels.txt")
names(activity) <- c("id", "name")
test <- read_DT("test")
train <- read_DT("train")

# merges (rbind) the sets
dt <- rbind(train, test)
rm(train, test)

# "mean" or "std" in features
cols <- features[c(grep("mean()", name), grep("std()", name))]

# reduce columns
dt <- dt[, c(cols$idx, ncol(dt)-1, ncol(dt)), with=FALSE]

# descriptive activity names
dt$activity <- factor(dt$activity, levels=activity$id, labels=activity$name)

#  descriptive variable names
cols$name <- gsub("\\(\\)", "", cols$name)
cols$name <- gsub("-", ".", cols$name)
cols <- cols[order(cols$idx),]
names(dt)[1:nrow(cols)] <- cols$name

# average of each variable for each activity and each subject
dt.mean <- dt[, lapply(.SD, mean), by=c("activity", "subject")]

# write dt.mean
write.table(dt.mean, "har_mean.txt", row.names=FALSE)


