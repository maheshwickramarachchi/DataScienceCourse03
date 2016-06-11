#Downloarding Data
folderName<-"UCI_HAR_Dataset.zip"
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,folderName)
unzip(folderName)

#Loading Data
features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = T)
features[,2]<-as.character(features[,2])
#View(features)

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = T)
activity_labels[,2]<-as.character(activity_labels[,2])
#View(activity_labels)

featuresRequired <- grep(".*mean.*|.*std.*", features[,2])
featuresRequiredNames <- features[featuresRequired,2]
featuresRequiredNames = gsub('-mean', 'Mean', featuresRequiredNames)
featuresRequiredNames = gsub('-std', 'Std', featuresRequiredNames)
featuresRequiredNames = gsub('[-()]', '', featuresRequiredNames)


train<-read.table("./UCI HAR Dataset/train/X_train.txt",stringsAsFactors = T)[featuresRequired]
trainActivity<-read.table("./UCI HAR Dataset/train/y_train.txt",stringsAsFactors = T)
trainSubject<-read.table("./UCI HAR Dataset/train/subject_train.txt",stringsAsFactors = T)

test<-read.table("./UCI HAR Dataset/test/X_test.txt",stringsAsFactors = T)[featuresRequired]
testActivity<-read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors = T)
testSubject<-read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors = T)

#Marging data sets and adding labels
trainData<-cbind(trainSubject,trainActivity,train)
testData<-cbind(testSubject,testActivity,test)
#View(trainData);View(testData)

allData<-rbind(trainData,testData)
names(allData)<-c("Subject","Activity",featuresRequiredNames)
allData$Activity<-factor(allData$Activity,levels=activity_labels[,1],labels =activity_labels[,2])
#View(allData)

#average of each variable for each activity and each subject
library(reshape2)
meltData<-melt(allData,id=c("Subject","Activity"),measure.vars = as.vector(featuresRequiredNames))
finalTable<-dcast(meltData,Activity+Subject~variable,mean)

View(finalTable)
write.table(finalTable,file = "tidyData.txt",row.names = F)




