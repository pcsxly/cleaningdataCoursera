#setwd("P:\\Courses\\Data Science Coursera\\CleaningData\\UCI HAR Dataset")
#rm(list=ls())

###### 0. Load Dataset
# features and activity labels
actLabels = read.table("activity_labels.txt")
features = read.table("features.txt")

# only select features that have mean() or std() from features
featureIdx = grep("mean\\(\\)|std\\(\\)",features[,2])

# directories for reading in data files
sep = .Platform$file.sep
TRAINDIR = paste0('.',sep,'train',sep)
TESTDIR = paste0('.',sep,'test',sep)

# select columns to make loading in X data quicker
tmp = read.table(paste0(TRAINDIR,'X_train.txt'),nrows=1)
colClass = lapply(tmp,class)
xColClass = rep("NULL",length(colClass))
xColClass[featureIdx] = colClass[featureIdx]

# load in dataset
xTrain = read.table(paste0(TRAINDIR,'X_train.txt'),colClasses = xColClass)
yTrain = read.table(paste0(TRAINDIR,'y_train.txt'))
subTrain = read.table(paste0(TRAINDIR,'subject_train.txt'))
xTest = read.table(paste0(TESTDIR,'X_test.txt'),colClasses = xColClass)
yTest = read.table(paste0(TESTDIR,'y_test.txt'))
subTest = read.table(paste0(TESTDIR,'subject_test.txt'))

# label columns in dataset
colnames(yTrain) = "Activity"
colnames(yTest) = "Activity"
colnames(subTrain) = "Subject"
colnames(subTest) = "Subject"
colnames(xTrain) = as.character(features[featureIdx,2])
colnames(xTest) = as.character(features[featureIdx,2])

###### 1. Merge training and test sets to create one data set
df = rbind(cbind(subTrain,yTrain,xTrain),cbind(subTest,yTest,xTest))

###### 2. Extract only measurements on mean and std
# [Note - This is done in Step 0 already in the data loading step]

###### 3. Use descriptive activity names in the data set
df$Activity = actLabels[df$Activity,2]

###### 4. Appropriately label data set with descriptive names
# [Note - This is done at the end of Step 0]

###### 5. Create independent tidy data set with avgs per activity and sub
dfTidy = df[0,]
for (i in min(df$Subject):max(df$Subject)) {
  for (j in 1:length(actLabels[,1])) {
    itr = nrow(dfTidy)+1
    dfTidy[itr,1] = i
    dfTidy[itr,2] = actLabels[j,2]
    
    # set other entries to means
    idx = (df$Subject == i) & (df$Activity == actLabels[j,2])    
    dfTidy[itr,3:ncol(df)] = colMeans(df[idx,3:ncol(df)])        
  }
}

###### Write out Tidy Data Frame
write.table(file="dfTidy.txt",x=dfTidy)