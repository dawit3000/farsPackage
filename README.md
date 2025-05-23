# farsPackage

[![R-CMD-check](https://github.com/dawit3000/farsPackage/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dawit3000/farsPackage/actions/workflows/R-CMD-check.yaml)


## Overview

`farsPackage` provides tools for working with the Fatality Analysis Reporting System (FARS) data.  
It includes functions to read, process, summarize, and visualize FARS accident data by year and state.

## Installation

You can install the development version from GitHub with:

```r
# install.packages("devtools") # if needed
devtools::install_github("dawit3000/farsPackage")

```

## Example


This is a basic example which shows you how to read FARS data for a given year, summarize accidents by month and year, and plot accidents for a state.

```r
library(farsPackage)

# Read FARS data for 2013 (make sure the file exists in your working directory or specify full path)
data_2013 <- fars_read("data/accident_2013.csv.bz2")

# Summarize accident counts for 2013, 2014, and 2015
summary_data <- fars_summarize_years(c(2013, 2014, 2015))
print(summary_data)

# Plot accidents in state number 1 (Alabama) for the year 2013
fars_map_state(1, 2013)
