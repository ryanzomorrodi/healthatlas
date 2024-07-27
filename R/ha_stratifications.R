ha_stratifications <- function(progress = TRUE) {
  body <- ha_api_stratifications_req() |>
    ha_req_perform_iterative(progress) |>
    ha_resp_body_iterative()

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(
      c(
        "population_key" = "key",
        "population_name" = "name",
        "population_grouping" = "grouping"
      )
    )
}
