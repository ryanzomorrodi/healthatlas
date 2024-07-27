#' List Topic Coverage
#'
#' @description
#' List all combinations of population, periods, and
#' geographic layers available for a given topic. To
#' search for individual topics use `ha_topics()`.
#' @param topic_key 3-8 letter ID uniquely identifying
#' a topic.
#' @param progress Display a progress bar?
#'
#' @return Topic coverage tibble
#' @export
#'
#' @examples
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_coverage("POP", progress = FALSE)
ha_coverage <- function(topic_key, progress = TRUE) {
  body <- ha_api_coverage_req(topic_key) |>
    ha_req_perform() |>
    ha_resp_body("coverages")

  stratifications <- ha_stratifications(progress)
  layers <- ha_layers()

  tibble::tibble(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::right_join(
      stratifications,
      by = c("population" = "population_key")
    ) |>
    dplyr::right_join(
      layers,
      by = c("body_id" = "layer_key")
    ) |>
    dplyr::select(
      c(
        "population_key" = "population",
        "population_name",
        "population_grouping",
        "period_key" = "period",
        "layer_key" = "body_id",
        "layer_name"
      )
    )
}
