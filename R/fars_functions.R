#' Read FARS Data File
#'
#' Reads a CSV file containing Fatality Analysis Reporting System (FARS) data.
#' This function checks for the existence of the file, reads it using `readr::read_csv()`,
#' and returns the data as a tibble.
#'
#' @param filename A character string giving the name of the file to read.
#'
#' @return A tibble (`tbl_df`) containing the FARS data.
#'
#'@examples
#'data_2013 <- fars_read("accident_2013.csv.bz2")
#'
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })


  dplyr::tbl_df(data)
}


#' Creates the filename for a FARS data file based on the given year.
#'
#' @param year An integer or string representing the year.
#'
#' @return A character string representing the filename.
#'
#' @examples
#' make_filename(2015)
#'
#' @export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}


#' Read and process FARS Data for a list of years
#'
#' Reads and processes FARS data files for a list of years.
#' For each year, adds a `year` column and selects the `MONTH` and `year` columns.
#' If the file for a year cannot be read, a warning is issued and that year is skipped.
#'
#' @param years A vector of years (numeric or character).
#'
#' @return A list of tibbles, each containing `MONTH` and `year` columns.
#'
#' @examples
#' \dontrun{
#' fars_read_years(c(2013, 2014, 2015))
#' }
#'
#' @importFrom dplyr mutate select
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}


#' Summarize FARS Data by Month and Year
#'
#' Aggregates FARS data across multiple years and summarizes the number of accidents per month.
#' Returns a wide-format table with months as rows and years as columns.
#'
#' @param years A vector of years to summarize.
#'
#' @return A tibble with months as rows and accident counts for each year as columns.
#'
#' @examples
#' \dontrun{
#' fars_summarize_years(c(2013, 2014, 2015))
#' }
#'
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}


#' Plot FARS Accidents on a State Map
#'
#' Plots accident locations from a FARS dataset for a given state and year on a map.
#' Filters out invalid longitude and latitude values before plotting.
#'
#' @param state.num The numeric code of the U.S. state.
#' @param year The year of the FARS data to use.
#'
#' @return A plot of accident locations. If no accidents exist or input is invalid, returns `NULL` invisibly.
#'
#' @examples
#' \dontrun{
#' fars_map_state(1, 2013)
#' }
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
