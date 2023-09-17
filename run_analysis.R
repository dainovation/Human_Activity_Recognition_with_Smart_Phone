library(tidyverse)
library(dplyr)
library(Hmisc)
library(tidyr)


download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data/getdata_projectfiles_UCI HAR Dataset")
unzip(zipfile = "data/getdata_projectfiles_UCI HAR Dataset")

## IMPORT TRAIN DATA
y_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
x_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/x_train.txt", col_names = FALSE)
subject_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
body_acc_x_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", col_names = FALSE)
body_acc_y_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", col_names = FALSE)
body_acc_z_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", col_names = FALSE)
body_gyro_x_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", col_names = FALSE)
body_gyro_y_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", col_names = FALSE)
body_gyro_z_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", col_names = FALSE)
total_acc_x_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", col_names = FALSE)
total_acc_y_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", col_names = FALSE)
total_acc_z_train <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", col_names = FALSE)

## IMPORT TEST DATA
y_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
x_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/x_test.txt", col_names = FALSE)
subject_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
body_acc_x_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", col_names = FALSE)
body_acc_y_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", col_names = FALSE)
body_acc_z_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", col_names = FALSE)
body_gyro_x_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", col_names = FALSE)
body_gyro_y_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", col_names = FALSE)
body_gyro_z_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", col_names = FALSE)
total_acc_x_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", col_names = FALSE)
total_acc_y_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", col_names = FALSE)
total_acc_z_test <- read_table("data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", col_names = FALSE)

# MERGE X
x <- rbind(x_train, x_test)

# MERGE Y
y <- rbind(y_train, y_test)

# MERGE SUBJECT
subject <- rbind(subject_train, subject_test)


# MERGE BODY ACC
body_acc_x <- rbind(body_acc_x_train,body_acc_x_test)
body_acc_y <- rbind(body_acc_y_train, body_acc_y_test)
body_acc_z <- rbind(body_acc_z_train,body_acc_z_test)

# MERGE BODY GYRO
body_gyro_x <- rbind(body_gyro_x_train,body_gyro_x_test)
body_gyro_y <- rbind(body_gyro_y_train, body_gyro_y_test)
body_gyro_z <- rbind(body_gyro_z_train,body_gyro_z_test)

# MERGE TOTAL ACC
total_acc_x <- rbind(total_acc_x_train,total_acc_x_test)
total_acc_y <- rbind(total_acc_y_train, total_acc_y_test)
total_acc_z <- rbind(total_acc_z_train,total_acc_z_test)

# MERGE ALL
ucr_har <- cbind(subject,y,x,body_acc_x,body_acc_y,body_acc_z,body_gyro_x,body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z)

# Rename Columns
names(ucr_har)[1] <- "Subject"
names(ucr_har)[2] <- "y"

# X average and stardard variation
ucr_har$x_avg <- rowMeans(ucr_har[,3:563])
ucr_har$x_sd = apply(ucr_har[,3:563],1, sd)

# body_acc average and stardard variation
ucr_har$body_acc_x_avg <- rowMeans(ucr_har[,564:691])
ucr_har$body_acc_x_sd = apply(ucr_har[,564:691],1, sd)

ucr_har$body_acc_y_avg <- rowMeans(ucr_har[,692:819])
ucr_har$body_acc_y_sd = apply(ucr_har[,692:819],1, sd)

ucr_har$body_acc_z_avg <- rowMeans(ucr_har[,820:947])
ucr_har$body_acc_z_sd = apply(ucr_har[,820:947],1, sd)

# body_gyro average and stardard variation
ucr_har$body_gyro_x_avg <- rowMeans(ucr_har[,948:1075])
ucr_har$body_gyro_x_sd = apply(ucr_har[,948:1075],1, sd)

ucr_har$body_gyro_y_avg <- rowMeans(ucr_har[,1076:1203])
ucr_har$body_gyro_y_sd = apply(ucr_har[,1076:1203],1, sd)

ucr_har$body_gyro_z_avg <- rowMeans(ucr_har[,1204:1331])
ucr_har$body_gyro_z_sd = apply(ucr_har[,1204:1331],1, sd)

# total_acc average and stardard variation
ucr_har$total_acc_x_avg <- rowMeans(ucr_har[,1332:1459])
ucr_har$total_acc_x_sd = apply(ucr_har[,1332:1459],1, sd)

ucr_har$total_acc_y_avg <- rowMeans(ucr_har[,1460:1587])
ucr_har$total_acc_y_sd = apply(ucr_har[,1460:1587],1, sd)

ucr_har$total_acc_z_avg <- rowMeans(ucr_har[,1588:1715])
ucr_har$total_acc_z_sd = apply(ucr_har[,1588:1715],1, sd)

# ucr_har_extract <- select(ucr_har[1], y = ucr_har[2], ucr_har[1716:1735])
ucr_har_extract <- ucr_har %>% select(Subject, y, ends_with("avg") | ends_with("sd"))

# Output for the dataset
write.table(ucr_har_extract, file = "data/UCR_HAR_Dataset.csv", sep = ",", col.names = TRUE)



