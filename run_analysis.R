# Set working direction  
setwd("C:/Users/WP/Desktop/Coursera CSC/Intermediate Data Science with R/Getting and Cleaning Data/Assignment/getdata_2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset")
# import activity labels
act_labels <- read.table("activity_labels.txt")
# import variable names
features <- read.table("features.txt")
# create new data frame with only the mean and standard deviaton variables 
features_mean_n_std_dev <- features[grep(".*mean.*|.*std.*", features[,2]),]
# load stringr package
library(stringr)
# edit variable names

# remove all special characters                                                            
features_mean_n_std_dev$V2 <- str_replace_all(features_mean_n_std_dev$V2, "[[:punct:]]",'')
features_mean_n_std_dev$V2 <- str_replace_all(features_mean_n_std_dev$V2, 'mean','Mean')
features_mean_n_std_dev$V2 <- str_replace_all(features_mean_n_std_dev$V2, 'std','Std')

# load training set
train_set <- read.table("train/X_train.txt")[features_mean_n_std_dev$V1]
# load training activites 
train_act <- read.table("train/Y_train.txt")
# load training subjects
train_subj <- read.table("train/subject_train.txt")
# combine all into one
train_set <- cbind(train_subj, train_act, train_set)

# load test set
test_set <- read.table("test/X_test.txt")[features_mean_n_std_dev$V1]
# load test activites 
test_act <- read.table("test/Y_test.txt")
# load test subjects
test_subj <- read.table("test/subject_test.txt")
# combine all into one
test_set <- cbind(test_subj, test_act, test_set)

# combine test and training set
all_data <- rbind(train_set, test_set)
# name all columns
colnames(all_data) <- c("subject", "activity", features_mean_n_std_dev$V2)
# convert to factors and add labels
all_data$activity <- factor(all_data$activity, levels = act_labels[,1], labels = act_labels[,2])
all_data$subject <- as.factor(all_data$subject)


library(reshape2)
# find new means
all_data_melt <- melt(all_data, id = c("subject", "activity"))
new_mean <- dcast(all_data_melt, subject + activity ~ variable, mean)
write.table(new_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
