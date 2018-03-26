#---------------------
# For Common data 
features <- readr::read_table2("F:/UCI HAR Dataset/features.txt", col_names = FALSE)
activity_labels <- read_table2("F:/UCI HAR Dataset/activity_labels.txt", col_names = FALSE)

#---------------------
# For test data 
y_train <- read.table("F:/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
X_train <- read.table("F:/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

colnames(X_train) <- make.names(features[[2]], unique = T)

body_acc_x_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", col_names = FALSE)
body_acc_y_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", col_names = FALSE)
body_acc_z_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", col_names = FALSE)

body_gyro_x_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", col_names = FALSE)
body_gyro_y_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", col_names = FALSE)
body_gyro_z_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", col_names = FALSE)

total_acc_x_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", col_names = FALSE)
total_acc_y_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", col_names = FALSE)
total_acc_z_train <- read_table2("F:/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", col_names = FALSE)

X_train$body_acc_x_mean <- apply(body_acc_x_train, 1, mean) %>% length
X_train$body_acc_y_mean <- apply(body_acc_y_train, 1, mean) %>% length
X_train$body_acc_z_mean <- apply(body_acc_z_train, 1, mean) %>% length

X_train$body_gyro_x_mean <- apply(body_gyro_x_train, 1, mean) %>% length
X_train$body_gyro_y_mean <- apply(body_gyro_y_train, 1, mean) %>% length
X_train$body_gyro_z_mean <- apply(body_gyro_z_train, 1, mean) %>% length

X_train$total_acc_x_mean <- apply(total_acc_x_train, 1, mean) %>% length
X_train$total_acc_y_mean <- apply(total_acc_y_train, 1, mean) %>% length
X_train$total_acc_z_mean <- apply(total_acc_z_train, 1, mean) %>% length

y_train <- y_train %>% left_join(activity_labels, by = c("V1" = "X1")) %>% 
    rename(labels = X2) %>% select(labels)

train_data <- cbind(X_train, y_train) 

subject_train <- read_csv("F:/UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)

train_data$subject <- subject_train[[1]]

#---------------------
# For test data 

y_test <- read.table("F:/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
X_test <- read.table("F:/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

colnames(X_test) <- make.names(features[[2]], unique = T)

body_acc_x_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", col_names = FALSE)
body_acc_y_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", col_names = FALSE)
body_acc_z_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", col_names = FALSE)

body_gyro_x_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", col_names = FALSE)
body_gyro_y_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", col_names = FALSE)
body_gyro_z_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", col_names = FALSE)

total_acc_x_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", col_names = FALSE)
total_acc_y_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", col_names = FALSE)
total_acc_z_test <- read_table2("F:/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", col_names = FALSE)

X_test$body_acc_x_mean <- apply(body_acc_x_test, 1, mean) %>% length
X_test$body_acc_y_mean <- apply(body_acc_y_test, 1, mean) %>% length
X_test$body_acc_z_mean <- apply(body_acc_z_test, 1, mean) %>% length

X_test$body_gyro_x_mean <- apply(body_gyro_x_test, 1, mean) %>% length
X_test$body_gyro_y_mean <- apply(body_gyro_y_test, 1, mean) %>% length
X_test$body_gyro_z_mean <- apply(body_gyro_z_test, 1, mean) %>% length

X_test$total_acc_x_mean <- apply(total_acc_x_test, 1, mean) %>% length
X_test$total_acc_y_mean <- apply(total_acc_y_test, 1, mean) %>% length
X_test$total_acc_z_mean <- apply(total_acc_z_test, 1, mean) %>% length

y_test <- y_test %>% left_join(activity_labels, by = c("V1" = "X1")) %>% 
    rename(labels = X2) %>% select(labels)

test_data <- cbind(X_test, y_test) 

subject_test <- read_csv("F:/UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)

test_data$subject <- subject_test[[1]]


#-------------------
# combine the data


All_data <- rbind(train_data, test_data) %>% select(contains("mean"), contains("std"), -contains("meanFreq"), 
                                                    subject, labels)


avg_data <- All_data %>% group_by(subject, labels) %>% 
    summarise_all(mean)

write.table(avg_data,"avg_data.txt", row.names = F)




