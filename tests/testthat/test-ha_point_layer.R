test_that("point layers list", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    point_layers <- ha_point_layers()
  )
  expect_s3_class(point_layers, "data.frame")
})

test_that("single point layer", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    point_layer <- ha_point_layer("7d9caf3c-75e6-4382-8c97-069696a3efbf")
  )
  expect_s3_class(point_layer, "data.frame")
})
