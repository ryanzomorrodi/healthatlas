ha_stratifications <- function(progress = TRUE) {
  body <- ha_api_stratifications_req() |>
    ha_req_perform_iterative(progress) |>
    lapply(\(x) httr2::resp_body_json(x, simplifyVector = TRUE)) |>
    lapply(\(x) x[["results"]])

  output <- do.call(rbind, body)
  output <- output[c("key", "name", "grouping")]
  colnames(output) <- c("population_key", "population_name", "population_grouping")

  output
}
