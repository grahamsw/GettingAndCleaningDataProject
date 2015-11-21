#GettingAndCleaningDataProject
Class Project for Coursera Data Specialization

The data for this project is available from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

It should be unzipped into a **Data** directory within the same folder as the **run_analysis.R** file so that the script can fine it. (I interpreted "can be run as long as the Samsung data is in your working directory" to allow putting it into a nicely named subdirectory - to leave my main project directory tidy.)

The script creates two data sets, one from the **test** subdirectory, the other from **train**, and then combines these sets into one. (Satisfying parts 1-4 of the project requirements.) 

It then creates a tall dataset with the form

subjectId  | ActivityName  | Measure            | Value

-----------|---------------|--------------------|--------
    1      |  WALKING      | tBodyAccMag-mean() | 0.1234

and then finds the average of each measure for each subject/activity combination (subject 1's average tBodyAccMag-mean() while walking was 0.4567, say)

Note: I interpret "descriptive variable names" to be satisfied by the names given in the "features.txt" file. These are not very descriptive, but they're all I have. I could make guesses about what tBodyAccMag means, but you might know more about this than me, and by changing the names I might make it **harder** for you to understand, so I'm leaving them alone.




