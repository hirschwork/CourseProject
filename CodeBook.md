
## Dataset contents
The tidy dataset consists of four columns.

| variable name | variable description                        | datatype|
|---------------|-------------------------------------------------|------------------------------------------------------------|
| subject | Person identifier who performed the activity (1-30) | integer |
| activity | The activity performed (6 types - character: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying) | character  |
| metric | Name of the feature measured. Of the 561 features in the raw dataset only those which reflected a mean or standard deviation were extracted (based on column name) | character |
| metricMean | The mean of the above metric for the given subject and activity | numeric |
