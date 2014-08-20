DATA DICTIONARY FOR HUMAN ACTIVITY RECOGNITION USING SMARTPHONES 

SUMMARY: This is a tiny data dataset obtained from a project of 30 volunteers as part of an experiment wearing a smartphone.  

FILES USED: subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, y_train.txt, features.txt, activity_labels.txt

DATA FORMAT: All data was collected in text format and then manipulated in R as table format. The output tidy set is converted back to text format as per assignment requirement.

___________________________________________________________________
VARIABLE: purpose  
VARIABLE-TYPE: Character(5)   
VARIABLE DESCRIPTION: Purpose of data being used for  
ALLOWABLE VALUES: "Test" or "Train"


VARIABLE: volunteer  
VARIABLE-TYPE: Integer(2)  
VARIABLE DESCRIPTION: Volunteer ID  
ALLOWABLE VALUES: 1 - 30


VARIABLE: activity  
VARIABLE-TYPE: Characters(18)  
VARIABLE DESCRIPTION: Activities performed while wearing smartphone 
ALLOWABLE VALUES: "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying""


VARIABLE: measurement  
VARIABLE-TYPE: Characters(30)  
VARIABLE DESCRIPTION: Measurement feature for each type of activity  
ALLOWABLE VALUES: Words containing 'mean()' and 'std()'


VARIABLE: value  
VARIABLE-TYPE: Characters(15)   
VARIABLE DESCRIPTION: Measured and derived values from the volunteers performing activities   
ALLOWABLE VALUES: 7 decimal numerical values expressed in exponential
