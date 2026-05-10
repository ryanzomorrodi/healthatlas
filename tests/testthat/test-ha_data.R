test_that("place data for one topic", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    data <- ha_data("EDB", "", "2022", "place")
  )
  expect_s3_class(data, "data.frame")
})

test_that("zip data for one topic", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    data <- ha_data("EDB", "", "2018-2022", "zip")
  )
  expect_s3_class(data, "data.frame")
})

test_that("community area data for one topic", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    data <- ha_data("EDB", "", "2018-2022", "neighborhood")
  )
  expect_s3_class(data, "data.frame")
})

test_that("data with two topics and two periods", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    data <- ha_data(
      c("EDB", "EDE"),
      "",
      c("2017-2021", "2018-2022"),
      "neighborhood"
    )
  )
  expect_s3_class(data, "data.frame")
})

test_that("check data with two topics and two periods and geometry", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    data <- ha_data(
      c("EDB", "EDE"),
      "",
      c("2017-2021", "2018-2022"),
      "neighborhood",
      geometry = TRUE
    )
  )
  expect_s3_class(data, "data.frame")
})
