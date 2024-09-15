ha_stratifications <- function(progress = TRUE) {
  body <- ha_api_stratifications_req() |>
    ha_req_perform_iterative(progress) |>
    ha_resp_body_iterative()

  output <- body[c("key", "name", "grouping")]
  colnames(output) <- c("population_key", "population_name", "population_grouping")

  tibble::as_tibble(output)
}
