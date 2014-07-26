
DATASET_PATH <- 'UCI HAR Dataset'

# Reads the feature definitions and returns a vector with the indices
# of the features of interest to us in the raw dataset. The names of the 
# elements in the vector correspond to the actual names of the features 
# from the raw dataset.
read.features <- function() {
  # Read in all the feature names
  raw <- read.table(file.path(DATASET_PATH, 'features.txt'))
  
  # The features that interest us are all the means and standard deviations
  rows <- union(grep('std', raw$V2), grep('mean', raw$V2))
  features <- raw[rows,'V1']
  names(features) <- raw[rows, 'V2']
  features
}

# Reads the activity types and and returns them as a numerical vector whose
# names correspond to the labels assigned in the raw data.
read.activity.types <- function() {
  raw <- read.table(file.path(DATASET_PATH, 'activity_labels.txt'), stringsAsFactors=F)
  activity.types <- raw$V1
  names(activity.types) <- raw$V2
  activity.types
}

# This function reads the dataset with the variables of interest to us.
# Args:
#   - type: A single-element character string vector of either of the values
#       'train' or 'test', each value causes the function to return the 
#       corresponding dataset.
#   - features: A numerical vector whose values are the indices of the and
#       names are the corresponding names of the variables in the output
#       dataset.
#   - activity.types: A numerical vector whose values are the qualitative types
#       of activitites used in the raw data, and names correspond to the assigned
#       activity labels.
#
read.dataset <- function(type, features, activity.types) {
  if (!type %in% c('train', 'test')) {
    stop("The type must be provided and be one of the values {'train', 'test'}")
  } else if (missing(features)) {
    stop("The features must be provided")
  } else if (missing(activity.types)) {
    stop("The activity.types must be provided")
  }
  
  # Read the record subjects
  subject <- read.table(file.path(DATASET_PATH, type, paste('subject_', type, '.txt', sep='')))$V1
  
  # Read the record measurement features
  measurements <- read.table(file.path(DATASET_PATH, type, paste('X_', type, '.txt', sep='')))
  measurements <- measurements[,features]
  names(measurements) <- names(features)
  
  # Read the record activities
  activities <- read.table(file.path(DATASET_PATH, type, paste('y_', type, '.txt', sep='')))$V1
  activities <- sapply(activities, function(activity) names(activity.types)[activity])
  activities <- factor(activities)
  
  # Combine them all
  dataset <- data.frame(Subject=subject, Activity=activities)
  dataset <- cbind(dataset, measurements)
}

# Read in the feature definitions
features <- read.features()

# Read in the activity types
activity.types <- read.activity.types()

# Read in the test and training datasets
test.dataset <- read.dataset('test', features, activity.types)
train.dataset <- read.dataset('train', features, activity.types)

# Combine the test and training datasets
dataset <- rbind(test.dataset, train.dataset)

# Write out the tidy datasets to 'tidy_data.csv'
write.csv(dataset, 'tidy_data.csv', row.names=F)

