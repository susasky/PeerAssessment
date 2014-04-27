#reads test dataset
test<-read.table("test/X_test.txt")
#reads test dataset subject id
test_subj<-read.table("test/subject_test.txt")
#reads test dataset activity id
test_act<-read.table("test/y_test.txt")

#reads train dataset
train<-read.table("train/X_train.txt")
#reads train dataset subject id
train_subj<-read.table("train/subject_train.txt")
#reads train dataset activity id
train_act<-read.table("train/y_train.txt")

##### 1. Merges the training and the test sets to create one data set ######
#merges data [step x]
dataMerge<-rbind(data.frame(test,test_subj[1],test_act[1]),data.frame(train,train_subj[1],train_act[1]))

#reads the features table
features<-read.table("features.txt")
#select features to grep
toGrep <- c("mean()", "std()")
#selects only means and stds
greps <- unique (grep(paste(toGrep,collapse="|"),features$V2, value=TRUE))
# index of columns
grepsIndx <- unique (grep(paste(toGrep,collapse="|"),features$V2))

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ####
dataSet<-data.frame(dataMerge[562],dataMerge[563],dataMerge[,grepsIndx])

### 3. Uses descriptive activity names to name the activities in the data set ####
names(dataSet)<-c("subject_id","activity_id",greps)

### 4. Appropriately labels the data set with descriptive activity names.
#assigns a description to the activity
assign<-function(x){
	if(x==1){dataSet$activity<-"WALKING"}
	else if(x==2){dataSet$activity<-"WALKING_UPSTAIRS"}
	else if(x==3){dataSet$activity<-"WALKING_DOWNSTAIRS"}
	else if(x==4){dataSet$activity<-"SITTING"}
	else if(x==5){dataSet$activity<-"STANDING"}
	else if(x==6){dataSet$activity<-"LAYING"}
	else {dataSet$activity<-NA}
}
#add the column to the dataset
dataSet$activity<-unlist(lapply(dataSet$activity_id,assign))
#reorder columns
dataSet<-dataSet[,c(1:2,82,3:81)]
#writes the output to file
write.table(dataSet,file="tidy_data_4.txt",col.names = T, row.names = F)

#### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject 
library(reshape2)

#sets dataMerge names
names(dataMerge)<-c(as.vector(features$V2),"subject_id","activity_id")
assign2<-function(x){
	if(x==1){dataMerge$activity<-"WALKING"}
	else if(x==2){dataMerge$activity<-"WALKING_UPSTAIRS"}
	else if(x==3){dataMerge$activity<-"WALKING_DOWNSTAIRS"}
	else if(x==4){dataMerge$activity<-"SITTING"}
	else if(x==5){dataMerge$activity<-"STANDING"}
	else if(x==6){dataMerge$activity<-"LAYING"}
	else {dataMerge$activity<-NA}
}
#add the column to the dataset
dataMerge$activity<-unlist(lapply(dataMerge$activity_id,assign2))
#reorder columns
dataMerge<-dataMerge[,c(562:564,1:561)]
#melt dataframe
dataMelt<-melt(dataMerge,id=c("subject_id","activity_id","activity"))

byactsubj<-dcast(dataMelt,subject_id + activity ~ variable, mean)
write.table(byactsubj,file="tidy_data_5.txt",col.names = T, row.names = F)

