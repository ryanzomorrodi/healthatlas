test_that("check place data for one topic", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  data <- ha_data("EDB", "", "2022", "place")

  "expect a data.frame"
  expect_s3_class(data, "data.frame")

  "check table names"
  expect_equal(names(data), data_header_long)

  "check 1 row"
  expect_equal(nrow(data), 1)
})

test_that("check zip data for one topic", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  data <- ha_data("EDB", "", "2018-2022", "zip")

  "expect a data.frame"
  expect_s3_class(data, "data.frame")

  "check table names"
  expect_equal(names(data), data_header_long)

  "check 58 rows"
  expect_equal(nrow(data), 58)
})

test_that("check community area data for one topic", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  data <- ha_data("EDB", "", "2018-2022", "neighborhood")

  "expect a data.frame"
  expect_s3_class(data, "data.frame")

  "check table names"
  expect_equal(names(data), data_header_long)

  "check 77 rows"
  expect_equal(nrow(data), 77)
})

test_that("check data with two topics and two periods", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  data <- ha_data(c("EDB", "EDE"), "", c("2017-2021", "2018-2022"), "neighborhood")

  "expect a data.frame"
  expect_s3_class(data, "data.frame")

  "check table names"
  expect_equal(names(data), data_header_long)

  "check 77 * 4 rows"
  expect_equal(nrow(data), 77 * 4)
})

test_that("check data with two topics and two periods and geometry", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  topics <- c("EDB", "EDE")
  data <- ha_data(topics, "", c("2017-2021", "2018-2022"), "neighborhood", geometry = TRUE)

  "expect a data.frame"
  expect_s3_class(data, "sf")
  expect_s3_class(data, "data.frame")

  "check table names"
  expect_equal(names(data), c(data_header_long, "geometry"))
  
  "check 77 * 2 rows"
  expect_equal(nrow(data), 77 * 4)
})
