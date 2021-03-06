
# set working dir to Data dir - so that the
# rest of the script finds the data files.
dir <- paste(dirname(sys.frame(1)$ofile), '/Data', sep='')
setwd(dir)

# import headers 
features     <- read.table('features.txt', colClasses = c("numeric", "character")); 
activityType <- read.table('activity_labels.txt'); 

# this is complicated enough - and has gone through enough iterations - to warrant its own
# function, rather than repeating it for training & test
prepareData <- function(subjectFile, xFile, yFile, featureData = features, activities = activityType){
  # import training data
  subjectData <- read.table(subjectFile); 
  xData       <- read.table(xFile); 
  yData       <- read.table(yFile);
  # Srep 3: Uses descriptive activity names to name the activities in the data set
  yNames      <- activities[,2][yData$V1] # this is funky, but direct. "merge" changes the order of the records
  
  # step 4: Appropriately labels the data set with descriptive variable names
  # -------------------------------------------------------------------------
  # naming columns - use feature set for the heavy lifting 
  # Note: the feature names are not particularly descriptive, but they're the best I've got
  names(subjectData) <- 'SubjectId';
  names(xData) <- featureData[,2];
  # yNames is just a vector, so we name it during the cbind below
  
  # Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
  # ----------------------------------------------------------------------------------------------
  # assuming that all features with mean()/std() in the name are a mean,std of that feature, i.e. that
  # tBodyAcc-mean()-X is actually tBodyAcc-X - mean
  # the alternative is to grep only on names *ending* with mean()/std()
  # this selection ignores meanFreq() values
  mean_std_cols <- grepl("mean\\()", names(xData)) | grepl( "std\\()", names(xData))

  # combine the data into a single table
  cbind(subjectData, "ActivityName" = yNames, xData[,mean_std_cols]);
}

dataTrain <- prepareData('train/subject_train.txt', 'train/x_train.txt', 'train/y_train.txt', features, activityType)
dataTest <- prepareData('test/subject_test.txt', 'test/x_test.txt', 'test/y_test.txt', features, activityType)

# Step 1: Merging the two sets
# ----------------------------
allData <- rbind(dataTrain, dataTest)

# Step 5: From the data set in step 4, create a second independent tidy data set with the 
#         average of each variable for each activity and each subject.
# ---------------------------------------------------------------------------------------

library(reshape2)

# the "raw" data is in long format
tidyRaw <- melt(allData, id=c("SubjectId", "ActivityName"))
# the averages data is in wide format - this is still tidy
tidyAverages   = dcast(tidyRaw, SubjectId + ActivityName ~ variable, mean)

write.table(tidyAverages, file='../tidyAverages.txt', row.names=FALSE)
