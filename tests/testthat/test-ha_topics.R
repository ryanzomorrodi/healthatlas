test_that("check all topic", {
  skip_if_offline(cha_url)
  skip_on_cran()

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
  skip_if_offline(cha_url)
  skip_on_cran()

  ha_set(cha_url)
  topics <- ha_topics(cha_subcategory_key)

  "expect a data.frame"
  expect_s3_class(topics, "data.frame")

  "check table names"
  expect_equal(names(topics), topic_header)

  "check table only contains the subcategory requested"
  expect_equal(unique(topics$subcategory_key), cha_subcategory_key)

  "check at least 1 row"
  expect_gt(nrow(topics), 1)
})
