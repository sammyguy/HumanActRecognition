# PART 1: The first part of this script deals with getting the dataset from 'Test' folder.
# Read in the first table consisting of volunteers. This is a single column table
# with 2947 rows 
volunteers <- read.table("./data/UCI_HAR/test/subject_test.txt", sep="")

# Read in the second table consisting of activities. This is a single column table
# with 2947 rows 
activities <- read.table("./data/UCI_HAR/test/y_test.txt", dec=".", sep="")

# Create a new column for more descriptive activities
activities$Desc <- ""
activities[activities$V1==1,]$Desc <- "Walking" 
activities[activities$V1==2,]$Desc <- "Walking Upstairs" 
activities[activities$V1==3,]$Desc <- "Walking Downstairs" 
activities[activities$V1==4,]$Desc <- "Sitting" 
activities[activities$V1==5,]$Desc <- "Standing" 
activities[activities$V1==6,]$Desc <- "Laying" 

# Read in the third table consisting of all measurements. There are 561 columns in this 
# table, with 2947 rows. Each column represents one measurement feature of the data.
# I have at first tried to use read.table() without specifying colClasses="character"
# and the data was automatically imported in as numeric, with the exponential
# 'e' being removed.  
measurements <- read.table("./data/UCI_HAR/test/X_test.txt",
                       colClasses="character", sep="")

# Read in features.txt into a table to obtain descriptions of measurement 
# features. Then use the function grep() to extract all rows containing
# mean(), to be stored in vector 'featuredesc_mean'. Similarly, extract all
# rows containing std() to be stored in vector 'featuredesc_std'.
# Then combine and sort these 2 vectors together into vector 'featuredesc'.
# Note that in the grep() function, must specify 'fixed=TRUE' in order to
# exclude non-desired measurement features like meanFreq()
all_featuredesc <- read.table("./data/UCI_HAR/features.txt",
                              colClasses="character", sep="")
featuredesc_mean <- grep(pattern="mean()", fixed=TRUE, all_featuredesc$V2)
featuredesc_std <- grep(pattern="std()", fixed=TRUE, all_featuredesc$V2)
featuredesc <- sort(c(featuredesc_mean, featuredesc_std))

# Rename measurement variables by using more descriptive labels. This is 
# done using a For-loop. 
for (i in 1:length(measurements)) {
    colnames(measurements)[i] <- all_featuredesc[i,2]
}

# Subset measurements containing 'mean()' and 'std()' by
# passing in vector 'featuredesc'
measurements <- measurements[,c(featuredesc)]

# All 3 tables: 'volunteers', 'activities' and 'measurements' have
# the same number of rows. To combine all 3 into one table, use 
# cbind(). First join table 'volunteers' with table 'activities' (applying
# subsetting so that only column 'Desc' in column 2 is included) in the binding.
# Rename the first 2 columns of the joined table as 'Volunteers' and 'Activities'.
# Then, join this table with table 'measurements'. The final
# table will be named test_data, since this dataset is for TEST folder.
test_data <- cbind(volunteers, activities[,2])
names(test_data) <- c("Volunteer", "Activity")
test_data <- cbind(test_data, measurements)

# Add another variable named 'Purpose' to indicate this belong to Test folder
test_data <- cbind("Test", test_data)
colnames(test_data)[1] <- "Purpose"

# Remove unwanted dataset
rm(volunteers, activities, measurements)

#=======================================================================
# PART II: The 2nd part of this script deals with getting the dataset from
# 'Train' folder. Read in the first table consisting of volunteers.
# This is a single column table with 7352 rows 
volunteers <- read.table("./data/UCI_HAR/train/subject_train.txt", sep="")

# Read in the second table consisting of activities. This is a single column table
# with 7352 rows 
activities <- read.table("./data/UCI_HAR/train/y_train.txt", dec=".", sep="")

# Create a new column for more descriptive activities
activities$Desc <- ""
activities[activities$V1==1,]$Desc <- "Walking" 
activities[activities$V1==2,]$Desc <- "Walking Upstairs" 
activities[activities$V1==3,]$Desc <- "Walking Downstairs" 
activities[activities$V1==4,]$Desc <- "Sitting" 
activities[activities$V1==5,]$Desc <- "Standing" 
activities[activities$V1==6,]$Desc <- "Laying" 

# Read in the third table consisting of all measurements. There are 561 columns in this 
# table, with 7352 rows. Each column represents one measurement feature of the data.
# Remember to add the attribute colClasses="character" in the read.table function 
# so that the data will be imported as characters, in order to retain the exponential
# 'e'. 
measurements <- read.table("./data/UCI_HAR/train/X_train.txt",
                           colClasses="character", sep="")

# Rename measurement variables for more descriptive labels by using a 
# for loop. 
for (i in 1:length(measurements)) {
    colnames(measurements)[i] <- all_featuredesc[i,2]
}

# Subset measurements containing 'mean()' and 'std()' by
# passing in vector 'featuredesc'
measurements <- measurements[,c(featuredesc)]

# All 3 tables: 'volunteers', 'activities' and 'measurements' have
# the same number of rows. To combine all 3 into one table, use 
# cbind(). First join table 'volunteers' with table 'activities' (applying
# subsetting so that only column 'Desc' in column 2 is included) in the binding.
# Rename the first 2 columns as 'Volunteers' and 'Activities'.
# Then, join this table with table 'measurements'. The final
# table will be named train_data, since this dataset is for TRAIN folder.
train_data <- cbind(volunteers, activities[,2])
names(train_data) <- c("Volunteer", "Activity")
train_data <- cbind(train_data, measurements)

# Cbind() another column named 'Purpose' to indicate this belongs to Train folder
train_data <- cbind("Train", train_data)
colnames(train_data)[1] <- "Purpose"

# Rbind() both test_data and train_data tables into a final table called 'data',
# as per assignment requirement
data <- rbind(test_data, train_data)

# Melt dataset down to form tiny data
library(reshape2)
tidydata <- melt(data, id=c("Purpose", "Volunteer", "Activity"))
names(tidydata)[4:5] <- c("Measurement", "Value")

# Output data as text file
write.table(tidydata, "./data/UCI_HAR/tinydata.txt", row.names=FALSE, sep="")

# Remove unwanted datasets
rm(volunteers, activities, measurements, all_featuredesc, 
   featuredesc_mean, featuredesc_std, featuredesc, test_data, train_data, data, i)
