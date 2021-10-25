## First Mini Project in CMSC 197

## Problem 1 - mean of a specified pollutant from a range of monitors
pollutantmean <- function(directory, pollutant, id=1:332) {
  # ensure that directory ends with `/`
  directory <- if (endsWith(directory, "/")) directory else paste(directory, "/", sep = "")
  # get csv files from directory
  csvs <- list.files(path = directory)[id]  
  # variable for compiled data from csv files
  compiled_data <- data.frame() 
  
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
  # get csv files from directory
  csvs <- list.files(path = directory)[id]  
  # variable for complete cases
  complete_cases <- data.frame()
  
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

## Problem 3 - get correlation between pollutants from monitors that has complete 
##            cases greater than the specified threshold
corr <- function(directory, threshold = 0) {
  # ensure that directory ends with `/`
  directory <- if (endsWith(directory, "/")) directory else paste(directory, "/", sep = "")
  # get csv files from directory
  csvs <- list.files(path = directory)[1:332]  
  # numeric vector that will hold all correlations
  correlations <- vector(mode="numeric") 
  
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

## Problem 4 - modify the given code to plot the 30-day mortality rate from heart attack
# read the csv file
outcome <- read.csv('hospdata/outcome-of-care-measures.csv', colClasses = "character")
# coerce the column 11 of `outcome` to be numeric instead of character
outcome[, 11] <- as.numeric(outcome[, 11])
# create a histogram from `outcome[, 11]`, 
# use `xlab` to change the label in x-axis,
# use the `main` argument to change the histogram title
# and use the `col` argument to change the colors of the bars
hist(outcome[, 11], xlab = "Deaths", main = "Hospital 30-Day Death(Mortality) Rates from Heart Attack", col = "lightblue")
