coursera-getdata
================

This repository contains the processing code for producing tidy datasets from the raw dataset at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In order to produce the tidy datasets, I do the following:
 1. Read the measurement features from the file `features.txt`, recognizing the ordered index and name of each measurement
 2. Subset the recognized measurements to those whose names contain either the text `"mean"` or the text `"std"` which signifies that they are either an arithmetic mean or standard deviation of the corresponding series.
 3. Read the descriptive textual activity labels from the file `activity_labels.txt`
 4. For the `test` dataset, read in the subject column data for all the test observations from the file `subject_test.txt`
 5. From the `test` dataset, read in the measurement feautres from the file `X_test.txt`. The measurement values should correspond to the features read in step #2 before the subsetting. The measurement values are then projected onto only the features left after the subsetting in step #2.
 6. The activities associated with all the records are read in from the file `y_test.txt` for the `test` dataset.
 7. The columns from steps 4, 5, and 6 are then combined into one table where the rows are the observations and the columns are the variables.
 8. The steps 4:7 are repeated for the `train` dataset.
 9. The outcome dataset from steps 7 and 8 are combined vertically (the rows from the latter are appended to rows from the former) and this is our final tidy dataset: `tidy_data.csv`
 10. The separate dataset `tidy_data-averaged.csv` is produced by further modifying the dataset from step 9 by computing the arithmetic mean of each measurement variable across all observations, while grouping by the subject and activity.
