#' List Topic Coverage
#'
#' @description
#' List all combinations of population, periods, and
#' geographic layers available for a given topic. To
#' search for individual topics use `ha_topics()`.
#' @param topic_key Unique ID specifying a topic.
#' @param layer_key Character string or vector of 
#' Unique IDs for geographic layers.
#' @param keys_only Return only keys?
#' @param progress Display a progress bar?
#'
#' @return Topic coverage tibble.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_coverage("POP", progress = FALSE)
#' }
ha_coverage <- function(topic_key, layer_key = NULL, keys_only = FALSE, progress = TRUE) {
  body <- ha_api_coverage_req(topic_key, layer_key) |>
    ha_req_perform() |>
    ha_resp_body("coverages")

  output <- tibble::tibble(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::mutate("topic_key" = topic_key) |>
    dplyr::select(
      c(
        "topic_key",
        "population_key" = "population",
        "period_key" = "period",
        "layer_key" = "body_id"
      )
    )

  if (!keys_only) {
    stratifications <- ha_stratifications(progress)
    layers <- ha_layers()

    output <- output |>
      dplyr::right_join(stratifications, by = "population_key") |>
      dplyr::right_join(layers, by = "layer_key") |>
      dplyr::select(
        c(
          "topic_key",
          "population_key",
          "population_name",
          "population_grouping",
          "period_key",
          "layer_key",
          "layer_name"
        )
      )
  }

  output
}
