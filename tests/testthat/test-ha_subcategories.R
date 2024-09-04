
test_that("check all subcategories", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  subcategories <- ha_subcategories()

  "expect a tibble"
  expect_s3_class(subcategories, "tbl_df")
  expect_s3_class(subcategories, "tbl")
  expect_s3_class(subcategories, "data.frame")

  "check table names"
  expect_equal(names(subcategories), subcategories_header)

  "check at least 1 row"
  expect_gt(nrow(subcategories), 1)
})
