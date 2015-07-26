setwd("/Users/summer/Documents/Git/UCI HAR Dataset/test")
Xtest<-read.table("X_test.txt")
Ytest<-read.table("y_test.txt")
Xid<-read.table("subject_test.txt")
test<-cbind(Xid,Xtest,Ytest)
setwd("/Users/summer/Documents/Git/UCI HAR Dataset/train")
Xtrain<-read.table("X_train.txt")
Ytrain<-read.table("y_train.txt")
Yid<-read.table("subject_train.txt")
train<-cbind(Yid,Xtrain,Ytrain)
setwd("/Users/summer/Documents/Git/UCI HAR Dataset")
names<-read.table("features.txt")
names<-as.character(names[,2])
names<-c("SubjectID",names,"Activity")

com_data<-rbind(train,test)
colnames(com_data)<-names

index<-c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)
index<-index+1
index<-c(1,index,563)
new_data<-com_data[,index]
new_data$Activity<-factor(new_data$Activity)
library(plyr)
new_data$Activity<-revalue(new_data$Activity, c("1"="Walking", "2"="Walking_Upstairs","3"="Walking_Downstairs","4"="Sitting","5"="Standing","6"="Laying"))

library(reshape2)

datamelt<-melt(new_data,id=c("SubjectID","Activity"),measure.vars=colnames(new_data)[2:67])
new_data2<-dcast(datamelt,SubjectID+Activity~variable,mean)


