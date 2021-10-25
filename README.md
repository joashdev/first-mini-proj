# First Mini Project

---
#### Contents
- [Description](#description)
- [Functions](#functions)
- [Contributors](#contributors)
---
### Description
This repository is a mini-project in `CMSC 197 - Introduction to Data Science` which contains exercises in R Language

---
### Functions
1. `pollutantmean()` - this function returns the mean value of the specified pollutant from the given directory and monitor IDs
    + params:
        + `directory` | character vector | location of .csv files
        + `pollutant` | character vector (`nitrate` or `sulfate`) | name of the pollutant
        + `id` | integer vector (`default: 1:332`) | monitor IDs from which data will be retrieved
    + returns:
        + `numeric vector` of length 1
    + execution:
        + `pollutantmean("specdata", "nitrate", 23)`
        + `pollutantmean("specdata", "sulfate", 70:72)`
2. `complete()` - this function returns the number of complete observed cases from the given monitor IDs
    + params:
        + `directory` | character vector | location of .csv files
        + `id` | integer vector (`default: 1:332`) | monitor IDs from which data will be retrieved from
    + returns:
        + `data.frame`
    + execution:
        + `complete("specdata", c(2,4,7,10))`
        + `complete("specdata", 1)`
3. `corr()` - this function returns the correlation between nitrate and sulfate in each monitor IDs whose complete cases are greater than the threshold
    + params:
        + `directory` | character vector | location of .csv files
        + `threshold` | integer (`default: 0`) | lower limit of complete cases
    + returns:
        + `numeric vector`
    + execution:
        + `cr <- corr("specdata", 150) ; head(cr) ; summary(cr)`


---
### Contributors
- Kent Joash A. Zamudio $~~-~~$ [@github/joashdev](https://github.com/joashdev)

