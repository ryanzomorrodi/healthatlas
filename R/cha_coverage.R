#' List Topic Coverage
#'
#' @description
#' List all combinations of population, periods, and
#' geographic layers available for a given topic. To
#' search for individual topics use `cha_topics`.
#' @param topic_key 3-8 letter ID uniquely identifying
#' a topic.
#'
#' @return Topic coverage tibble
#' @export
#'
#' @examples
#' cha_coverage("POP")
cha_coverage <- function(topic_key, progress = TRUE) {
  body <- cha_api_coverage_req(topic_key) |>
    cha_req_perform() |>
    cha_resp_body("coverages")

  stratifications <- cha_stratifications(progress)
  layers <- cha_layers()

  tibble::tibble(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::right_join(
      stratifications,
      dplyr::join_by(population == population_key)
    ) |>
    dplyr::right_join(
      layers,
      dplyr::join_by(body_id == layer_key)
    ) |>
    dplyr::select(
      population_key = population,
      population_name,
      population_grouping,
      period_key = period,
      layer_key = body_id,
      layer_name
    )
}
