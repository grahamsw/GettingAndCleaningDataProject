
# set working dir to where this script is - so that the
# rest of the script finds the data files.
setwd(dirname(sys.frame(1)$ofile))

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
  yDataNames  <- activities[,2][yData$V1] # a bit funky - could also merge
  
  # naming columns - use feature set for the heavy lifting
  names(subjectData) <- 'SubjectId';
  names(xData) <- featureData[,2];
  
  # assuming that all features with mean()/std() in the name are a mean,std of that feature, i.e. that
  # tBodyAcc-mean()-X is actually tBodyAcc-X - mean
  # the alternative is to grep only on names *ending* with mean()/std()
  mean_std_cols <- grepl("mean()", names(xData)) | grepl( "std()", names(xData))
  names(yDataNames) <- 'Activity';
  
  # combine the data into a single table
  dataTrain <- cbind(subjectData, yDataNames, xData[,mean_std_cols]);
}


dataTrain <- prepareData('train/subject_train.txt', 'train/x_train.txt', 'train/y_train.txt', features, activityType)
dataTest <- prepareData('test/subject_test.txt', 'test/x_test.txt', 'test/y_test.txt', features, activityType)



allData <- rbind(dataTrain, dataTest)

