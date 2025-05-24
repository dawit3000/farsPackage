# farsPackage

[![R-CMD-check](https://github.com/dawit3000/farsPackage/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dawit3000/farsPackage/actions/workflows/R-CMD-check.yaml)

## Overview

`farsPackage` provides tools for working with the **Fatality Analysis Reporting System (FARS)** data.  
It includes functions to read, process, summarize, and visualize accident data by year and U.S. state.

## Installation

You can install the development version from GitHub:

```r
# install.packages("devtools")  # if not already installed
devtools::install_github("dawit3000/farsPackage")
````

## Example

This basic example shows how to read FARS data, summarize it by year/month, and plot accidents for a given state:

```r
library(farsPackage)

# Read FARS data for 2013 (included in package's extdata folder)
file_2013 <- system.file("extdata", "accident_2013.csv.bz2", package = "farsPackage")
data_2013 <- fars_read(file_2013)
summary(data_2013)

# Summarize accident counts for multiple years
years <- c(2013, 2014, 2015)
files <- file.path(system.file("extdata", package = "farsPackage"), 
                   paste0("accident_", years, ".csv.bz2"))

# fars_summarize_years expects years, not files — ensure your function uses fars_read_year
summary_data <- fars_summarize_years(years)
print(summary_data)

# Plot accidents in state 1 (Alabama) for 2013
fars_map_state(1, 2013)


## Vignette

To see a full walkthrough of all package features, check out the vignette:

📄 [`Using farsPackage`](https://dawit3000.github.io/farsPackage/articles/Using_farsPackage.html) *(link works after deploying GitHub Pages)*

---

## License

MIT © Dawit Aberra

```
