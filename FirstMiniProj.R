## NOTE: Function documentations are in the README.md of this repository

## Problem 1 - mean of a specified pollutant from a range of monitors
pollutantmean <- function(directory, pollutant, id=1:332) {
  # ensure that directory ends with `/`
  directory <- if (endsWith(directory, "/")) directory else paste(directory, "/", sep = "")
  csvs <- list.files(path = directory)[id]  # get csv files from directory
  compiled_data <- data.frame() # variable for compiled data from csv files
  
  # loop in each csv in csvs to get data
  for (csv in csvs){
    # rbind the new data from read.csv() to the existing compiled data
    # use paste() in read.csv() to get the directory+filename of the current csv file
    compiled_data <- rbind(compiled_data, read.csv(paste(directory, csv, sep = "")))
  }
  # get mean using mean() of the specified column using pollutant parameter
  # from the compiled_data and use na.rm to remove all NA in the compiled_data
  mean(compiled_data[, pollutant], na.rm = TRUE)
  # after executing the mean() it will print the mean result
}

## Problem 2 - number of complete observed cases from specified monitor/s
complete <- function(directory, id = 1:332) {
  
  # ensure that directory ends with `/`
  directory <- if (endsWith(directory, "/")) directory else paste(directory, "/", sep = "")
  csvs <- list.files(path = directory)[id]  # get csv files from directory
  complete_cases <- data.frame() # variable for complete cases
  
  # for loop in the range of id, using index is easier to get values from both
  # csvs and id since both have the same length
  for (ind in 1:length(id)){
    # get data from the csv file
    csv_data <- read.csv(paste(directory, csvs[ind], sep = ""))
    # omit NA values from the csv_data, getting all numeric values
    numeric_data <- na.omit(csv_data)
    # add monitor ID and number of complete case in that monitor to complete_cases data frame
    complete_cases <- rbind(complete_cases, c(id[ind], nrow(numeric_data)))
  }  
  
  # add column names to the data frame
  colnames(complete_cases) <- c("id", "nobs")
  # return data frame
  complete_cases
}

corr <- function(directory, threshold = 0) {
  # ensure that directory ends with `/`
  directory <- if (endsWith(directory, "/")) directory else paste(directory, "/", sep = "")
  csvs <- list.files(path = directory)[1:332]  # get csv files from directory
  correlations <- vector(mode="numeric") # numeric vector that will hold all correlations
  
  # loop in each csv from csvs to get data
  for(csv in csvs) {
    # get data from csv file
    csv_data <- read.csv(paste(directory, csv, sep = ""))
    # remove NA values from csv_data
    numeric_data <- na.omit(csv_data)
    # if the complete cases (no NA) is greater that the threshold
    if(nrow(numeric_data) > threshold) {
      # calculate correlation between nitrate and sulfate in each monitor
      # then append that result to `correlations`
      correlations <- c(correlations, cor(numeric_data$nitrate, numeric_data$sulfate))
    }
  }
  # return correlations
  correlations
}