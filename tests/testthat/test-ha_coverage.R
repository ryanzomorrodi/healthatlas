with_mock_dir("ha_coverage", {
  test_that("check specific topic coverage", {
    ha_set(cha_url)

    "expect no progress bar"
    expect_snapshot(coverage <- ha_coverage("EDB", progress = FALSE))

    "expect a data.frame"
    expect_s3_class(coverage, "data.frame")

    "check table names"
    expect_equal(names(coverage), coverage_header)

    "check at least 1 row"
    expect_gt(nrow(coverage), 1)
  })

  test_that("check specific topic and layer coverage", {
    ha_set(cha_url)

    "expect no progress bar"
    expect_snapshot(
      coverage <- ha_coverage("EDB", "neighborhood", progress = FALSE)
    )

    "expect a data.frame"
    expect_s3_class(coverage, "data.frame")

    "check table names"
    expect_equal(names(coverage), coverage_header)

    "check at least 1 row"
    expect_gt(nrow(coverage), 1)
  })

  test_that("check keys only", {
    ha_set(cha_url)

    "expect no progress bar"
    expect_snapshot(
      coverage <- ha_coverage("EDB", "neighborhood", keys_only = TRUE)
    )

    "expect a data.frame"
    expect_s3_class(coverage, "data.frame")

    "check table names"
    expect_equal(names(coverage), coverage_header_keys_only)

    "check at least 1 row"
    expect_gt(nrow(coverage), 1)
  })
})
