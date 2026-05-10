test_that("check all topic", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    topics <- ha_topics()
  )
  expect_s3_class(topics, "data.frame")
})

test_that("check specified subcategory", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    topics <- ha_topics("education")
  )
  expect_s3_class(topics, "data.frame")
})
