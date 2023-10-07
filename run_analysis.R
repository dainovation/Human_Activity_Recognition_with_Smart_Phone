# Load the required libraries
library(dplyr)

options(timeout = 600)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data/getdata_projectfiles_UCI HAR Dataset", method = "auto", quiet = FALSE, mode = "w",
              cacheOK = TRUE)
unzip(zipfile = "data/getdata_projectfiles_UCI HAR Dataset")

# Setting the path to the dataset
data_path <- "/UCI HAR Dataset"
data_path <- paste0(getwd(),data_path)

# Step 1: Merging the training and test sets
# Read the features, activity labels, and subject IDs
features <- read.table(file.path(data_path, "features.txt"), col.names = c("index", "name"), colClasses = c("numeric", "character"))
labels_for_activity <- read.table(file.path(data_path, "activity_labels.txt"), col.names = c("index", "activity"))
subject_train <- read.table(file.path(data_path, "train", "subject_train.txt"), col.names = "subject", colClasses = "numeric")
subject_test <- read.table(file.path(data_path, "test", "subject_test.txt"), col.names = "subject", colClasses = "numeric")
subject <- rbind(subject_train,subject_test)
subject <- apply(subject,1, as.numeric)

# Read and merge the training and test data
train_data <- read.table(file.path(data_path, "train", "X_train.txt"), col.names = features$name)
test_data <- read.table(file.path(data_path, "test", "X_test.txt"), col.names = features$name)
merged_data <- rbind(train_data, test_data)

# Step 2: Extracting mean and standard deviation measurements
# Select columns with mean() or std() in their names
selected_cols <- merged_data %>%
    select(matches("mean\\(\\)|std\\(\\)"))

# Step 3: Using descriptive activity names
# Merge activity labels with the data
activity_data <- bind_rows(
    read.table(file.path(data_path, "train", "y_train.txt"), col.names = "activity"),
    read.table(file.path(data_path, "test", "y_test.txt"), col.names = "activity")
)
activity_data <- apply(activity_data,1, as.numeric)

merged_data <- cbind(subject, merged_data, activity_data) %>%
    left_join(labels_for_activity, by = c("activity_data" = "index")) %>%
    select(-activity, activity_name = activity)

# Step 4: Appropriately labeling the data set
# Clean up variable names for readability
colnames(merged_data) <- gsub("\\()", "", colnames(merged_data))
colnames(merged_data) <- gsub("-", "_", colnames(merged_data))

# Step 5: Creating a tidy data set with the average of each variable for each activity and subject
tidy_data <- merged_data %>%
    group_by(subject, activity_name) %>%
    summarise(across(.cols = -c(subject), .fns = mean))

# Write the tidy data to a file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

# Print a message
cat("Kindly note that tidy data has been created and saved as 'tidy_data.txt' for this project.\n")
