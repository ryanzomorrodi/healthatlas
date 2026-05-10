test_that("layers", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    layers <- ha_layers()
  )
  expect_s3_class(layers, "data.frame")
})

test_that("single layer", {
  skip_on_cran()
  skip_if_offline()
  ha_set("https://chicagohealthatlas.org/")

  expect_no_error(
    layer <- ha_layer("neighborhood", progress = FALSE)
  )

  expect_s3_class(layer, "data.frame")
})
