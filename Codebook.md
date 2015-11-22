#Codebook for tidy data

The data for this project is available from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

See [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for more details.

The variables output in the tidyAverages.txt are all averages, per user/activity combination of the labelled variables. These variables are described, somewhat, in features_info.txt in the zipped collection of documents. This does **not** include information about the units used (!).


* SubjectId is an identifier for the subject
* ActivityName is one of 
  + WALKING
  + WALKING_UPSTAIRS
  + WALKING_DOWNSTARIS
  + SITTING
  + STANDING
  + LAYING
* Remaining columns are averages of measures of means/standard deviations 
All variables are included that contain "mean" or "std" in their names. There is some ambiguity as to which of these are actually means or standard deviations, I have erred on the side of inclusiveness.





