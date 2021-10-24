pollutantmean <- function(directory, pollutant, id=1:332) {
  
  ## `directory` is a character vector of length 1 
  ## location of the csv files
  
  ## `pollutant` is a character vector of length 1
  ## name of the pollutant for which we will calculate the mean : 'nitrate' or 'sulfate'
  
  ## `id` integer vector
  ## indicates the monitor ID numbers
  
  # ensure that directory ends with `/`
  directory <- if (endsWith(directory, "/")) directory else paste(directory, "/", sep = "")
  csvs <- list.files(path = directory)[id]  # get csv files from directory
  compiled_csv <- data.frame() # variable for compiled data from csv files
  
  for (csv in csvs){
    compiled_csv <- rbind(compiled_csv, read.csv(paste(directory, csv, sep = "")))
  }
  
  mean(compiled_csv[, pollutant], na.rm = TRUE)
}