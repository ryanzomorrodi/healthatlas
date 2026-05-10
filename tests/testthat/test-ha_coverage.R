test_that("specific topic", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    output <- ha_coverage("EDB")
  )
  expect_s3_class(output, "data.frame")
})

test_that("specific topic and layer", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    output <- ha_coverage("EDB", "neighborhood")
  )
  expect_s3_class(output, "data.frame")
})

test_that("keys only", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    output <- ha_coverage("EDB", "neighborhood", keys_only = TRUE)
  )
  expect_s3_class(output, "data.frame")
})
