with_mock_dir("ha_topics", {
  test_that("check all topic", {
    ha_set(cha_url)

    "expect no progress bar"
    expect_snapshot(topics <- ha_topics(progress = FALSE))

    "expect a data.frame"
    expect_s3_class(topics, "data.frame")

    "check table names"
    expect_equal(names(topics), topic_header)

    "check at least 1 row"
    expect_gt(nrow(topics), 1)
  })

  test_that("check specified subcategory", {
    ha_set(cha_url)
    topics <- ha_topics(cha_subcategory_key)

    "expect a data.frame"
    expect_s3_class(topics, "data.frame")

    "check table names"
    expect_equal(names(topics), topic_header)

    "check table only contains the subcategory requested"
    lapply(
      topics$topic_subcategories,
      \(x) expect_contains(x$key, cha_subcategory_key)
    )

    "check at least 1 row"
    expect_gt(nrow(topics), 1)
  })
})
