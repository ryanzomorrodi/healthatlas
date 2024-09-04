test_that("check layers list", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  layers <- ha_layers()

  "expect a tibble"
  expect_s3_class(layers, "tbl_df")
  expect_s3_class(layers, "tbl")
  expect_s3_class(layers, "data.frame")

  "check table names"
  expect_equal(names(layers), layers_header)

  "check 4 rows"
  expect_equal(nrow(layers), 4)
})

test_that("check a single layer", {
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  expect_snapshot(layer <- ha_layer("neighborhood", progress = FALSE))

  "expect a tibble"
  expect_s3_class(layer, "sf")
  expect_s3_class(layer, "tbl_df")
  expect_s3_class(layer, "tbl")
  expect_s3_class(layer, "data.frame")

  "check table names"
  expect_equal(names(layer), layer_header)

  "check 77 rows"
  expect_equal(nrow(layer), 77)
})
