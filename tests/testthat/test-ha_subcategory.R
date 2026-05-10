test_that("subcategories", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    subcategories <- ha_subcategories()
  )
  expect_s3_class(subcategories, "data.frame")
})
