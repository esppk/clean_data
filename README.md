# clean_data

# data clean with following step:

+ read data as data.frame
+ generate unique features names with make.names
+ rename the X_train/X_test data.frames' colnames.
+ calculate each Inertial Signals variables' mean along rows
+ cbind the data together
+ replace y with labels 
+ combine X and y
+ cbind subjects
+ rbind the train and test data
+ select cols only contain mean() and std(), along with labels and subjects
+ group by labels and subjects then summarise the means

*note* the script only work with absolute path. 
