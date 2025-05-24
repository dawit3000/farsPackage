devtools::install_github("dawit3000/farsPackage")
library(farsPackage)

# Read FARS data for 2013 (adjust path if needed)
data_2013 <- fars_read("data/accident_2013.csv.bz2")

# Summarize accident counts for multiple years
summary_data <- fars_summarize_years(c(2013, 2014, 2015))
print(summary_data)

# Plot accidents in state 1 (Alabama) for 2013
fars_map_state(1, 2013)
```
