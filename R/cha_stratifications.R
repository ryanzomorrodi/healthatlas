cha_stratifications <- function(progress = TRUE) {
  body <- cha_api_stratifications_req() |>
    cha_req_perform_iterative(progress) |>
    cha_resp_body_iterative()

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
