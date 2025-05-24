test_that("fars_read returns a tibble when file exists", {
  test_file <- system.file("extdata", "accident_2013.csv.bz2", package = "farsPackage")

  if (!file.exists(test_file)) {
    skip("Test data file does not exist in inst/extdata")
  }

  result <- fars_read(test_file)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 0, info = "fars_read should return non-empty tibble")
})

test_that("fars_read contains expected columns", {
  test_file <- system.file("extdata", "accident_2013.csv.bz2", package = "farsPackage")

  if (!file.exists(test_file)) {
    skip("Test data file does not exist in inst/extdata")
  }

  result <- fars_read(test_file)

  expected_cols <- c("MONTH", "STATE")  # adjust this based on actual dataset
  expect_true(all(expected_cols %in% names(result)),
              info = "Expected columns are missing from fars_read output")
})
