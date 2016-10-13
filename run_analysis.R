#Reading the training data. I already made the session into the data direcory from R studio.
x_train_dat<-read.table("../UCI HAR Dataset/train/X_train.txt")
y_train_dat<-read.table("../UCI HAR Dataset/train/y_train.txt")
sub_train<-read.table("../UCI HAR Dataset/train/subject_train.txt")

#Reading test data
x_test_dat<-read.table("../UCI HAR Dataset/test/X_test.txt")
y_test_dat<-read.table("../UCI HAR Dataset/test/y_test.txt")
sub_test<-read.table("../UCI HAR Dataset/test/subject_test.txt")

# 1st. Merging the training and the test sets to create one data set.
x_data<-rbind(x_train_dat,x_test_dat)
y_data<-rbind(y_train_dat,y_test_dat)
sub_data<-rbind(sub_train,sub_test)
#Naming the columns according to features
feat<-read.table("features.txt")
xdata<-rbind(x_data,feat[,2])

# 2nd. Extracting only the measurements of the mean and standard deviation. 
mean_sd<-grep(".*mean.*|.*std.*",feat[,2])
xxdata<-xdata[,mean_sd]
dim(xxdata)
# 3rd. Using descriptive activity names to name the activities in the data set.
activity<-read.table("activity_labels.txt")
y_data<-activity[y_data[,1],2]
names(y_data) = "activity"
# 4th
xxxdata<-x_data[,mean_sd]
names(xxxdata)<-feat[mean_sd,2]
names(sub_data)<-"subject"
alldata<-cbind(xxxdata,y_data,sub_data)
View(alldata)
# 5th
library(plyr)
avg_data <- ddply(alldata, .(subject, y_data), function(x) colMeans(x[, 1:66]))

write.table(avg_data, "tidy_data_set.txt", row.name=FALSE)
