% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_map_state}
\alias{fars_map_state}
\title{Plot FARS Accidents on a State Map}
\usage{
fars_map_state(state.num, year)
}
\arguments{
\item{state.num}{The numeric code of the U.S. state.}

\item{year}{The year of the FARS data to use.}
}
\value{
A plot of accident locations. If no accidents exist or input is invalid, returns \code{NULL} invisibly.
}
\description{
Plots accident locations from a FARS dataset for a given state and year on a map.
Filters out invalid longitude and latitude values before plotting.
}
\examples{
\dontrun{
fars_map_state(1, 2013)
}

}
