INTRODUCTION

This depository is a project assignment for Coursera Getting and Cleaning Data course. The project consists of a R-script to extract the required data from a group of text files. The final output is  a tidy dataset in text format called tinydata.txt. 
The CodeBook.md explains the structure of the final tidy dataset. 


SUMMARY OF APPROACH 

This script will read selected text files as into R as data.table formats to be combined and cleaned. There are 2 parts in this script. The first part involves files in folder 'test' and then follow by folder 'train' in part two. The resulting 2 data sets were then joined (using rbind() function) into a bigger data set as per assignment instructions. Finally, this data set were be melted down to produce a tiny data set of 5 columns.


PART 1 - Folder 'test'

The data extraction process excludes all text files in the 'Inertial Signals' in the 'test' folder as these raw data were already included in the X_test.txt file. The other 2 files used were 'y_test.txt' and 'subject_test.txt'. These 3 files were first read into data.table format:

X_test.txt  ===> measurements (name of data.table) [2947 rows]
y_test.txt  ===> activities (name of data.table) [2947 rows]
subject_test.txt  ===> volunteers (name of data.table) [2947 rows]

Since all these 3 tables contained the same number of rows, they were part of a larger data set and could be joined together by columns using cbind(). The activities in the original text file were represented by numbers (between 1 to 6) and there were replaced by more descriptive words: 
   1 ===> "Walking" 
   2 ===> "Walking Upstairs" 
   3 ===> "Walking Downstairs" 
   4 ===> "Sitting" 
   5 ===> "Standing" 
   6 ===> "Laying" 

The data.table 'measurements' contained 561 columns and they clearly represented the 561 measurement features as indicated in the features.txt file. Since the assignment specified that only mean and standard deviation measurement features were to be extracted, the required rows were extracted using the grep() function. Note that measurements like meanFreq(), even though they contained the word 'mean', were excluded because these were not the actual mean value of that particular measurement. For example, in examining the features.txt file, one could see that:

  - feature no. 542: fBodyBodyGyroJerkMag-mean() and 
  - feature no. 552: fBodyBodyGyroJerkMag-meanFreq()

That is, for this 'fBodyBodyGyroJerkMag' measurement, feature no. 542 is the required mean value and the R-script should just extract this feature and not the one containing 'meanFreq'. To achieve this, the attribute 'fixed=TRUE' must be included in the grep() function.

Once the required columns containing mean and std were extracted, they were renamed to more descriptive words instead of just V1, V2, etc… I have decided to simply use the labels as provided in the features.txt file. My script will simply remove the '()' characters from the original features. In my opinion, these words are already rather self-explanatory. Any attempt to come up with alternative labels would not provide addition information.

The 3 tables 'measurements', 'activities' and 'volunteers' were column-binded to form a data set called test_data. This data set will later be combined with the data set created in Part II.



PART II - Folder 'train'

The script from Part I was essentially repeated for this folder files. The data extraction process excludes all text files in the 'Inertial Signals' in the 'train' folder as these raw data were already included in the X_train.txt file. The final result will be the data set called train_data.

Both the data sets 'test_data' and 'train_data' were row-binded and melted down to form the tidy data set called 'data'. The final output is created using write.table() in the form of a text file called 'tinydata.txt'. 

More detailed explanations and comments are included in the remarks section in the R-script.
