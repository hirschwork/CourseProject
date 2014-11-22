CourseProject
=============

## Background
The raw data from this tidy dataset is retrieved from an experiment at the SmartLab at the University of Genoa, specifically Human Activity Recognition Using Smartphones Dataset (Version 1.0).

The team recorded experiments with a group of 30 volunteers performing different exercises ("activities") while wearing a smartphone. The smartphone tracked 561 features during six different activities.

For more information see: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw data was retreived from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

## Summary
The run_analysis.R script pulls in the raw data, combines the test and training groups, and provides mean values for all mean/standard deviation features. To run the script:
  1. Copy run_analytics.R script into your home directory
  2. Source the script and a tidy dataset will be written to "MeanResults.txt"

## Script steps
The script assumes that the raw dataset has already been downloaded into your working directory ("UCI HAR DataSet.zip"). It performs the following steps:
  1. Unzips the raw data file into the present directory
  2. Reads several lookup files to retrieve the features, activities, and subjects
  3. Filters 561 features into only those which are means or standard deviations (based on column name)
  4. The raw data was split into a test and train datasets, the script then combines these back together.
  5. New columns for the activity and subject are linked to each row
  6. The column names are cleaned up to be more readable
  7. All the features are converted from several columns into a two columns (feature name/value to metric/metricMean)
  8. The features are then aggregated and a single mean value is produced for each subject and activity
