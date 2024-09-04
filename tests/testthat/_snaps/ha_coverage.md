# check specific topic coverage

    Code
      coverage <- ha_coverage("EDB", progress = FALSE)

# check specific topic and layer coverage

    Code
      coverage <- ha_coverage("EDB", "neighborhood", progress = FALSE)

# check keys only

    Code
      coverage <- ha_coverage("EDB", "neighborhood", keys_only = TRUE)

