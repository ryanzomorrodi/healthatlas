test_that("check point layers list", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  point_layers <- ha_point_layers()

  "expect a tibble"
  expect_s3_class(point_layers, "tbl_df")
  expect_s3_class(point_layers, "tbl")
  expect_s3_class(point_layers, "data.frame")

  "check table names"
  expect_equal(names(point_layers), point_layers_header)

  "check more than 1 row"
  expect_gt(nrow(point_layers), 1)
})

test_that("check a single point layer", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  point_layer <- ha_point_layer("7d9caf3c-75e6-4382-8c97-069696a3efbf")

  "expect a tibble"
  expect_s3_class(point_layer, "sf")
  expect_s3_class(point_layer, "tbl_df")
  expect_s3_class(point_layer, "tbl")
  expect_s3_class(point_layer, "data.frame")

  "check more than 1 row"
  expect_gt(nrow(point_layer), 1)
})
