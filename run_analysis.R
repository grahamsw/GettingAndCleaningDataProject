
# set working dir to where this script is - so that the
# rest of the script finds the data files.
setwd(dirname(sys.frame(1)$ofile))

# import headers 
features     <- read.table('features.txt', colClasses = c("numeric", "character")); 
activityType <- read.table('activity_labels.txt', colClasses = c("character")); 

# import training data
subjectTrain <- read.table('train/subject_train.txt'); 
xTrain       <- read.table('train/x_train.txt'); 
yTrain       <- read.table('train/y_train.txt');
yTrainNames  <- activityType[,2][yTrain$V1] # a bit funky 

# import test data
subjectTest <- read.table('test/subject_test.txt'); 
xTest        <- read.table('test/x_test.txt')
yTest        <- read.table('test/y_test.txt')
yTestNames  <- activityType[,2][yTest$V1] 

# combine the data into a single table
dataTrain <- cbind(subjectTrain, yTrainNames, xTrain)
dataTest <- cbind(subjectTest, yTestNames, xTest)

allData <- rbind(dataTrain, dataTest)

# create names
names(allData) <- c('subjectId', 'activity', features$V2)
