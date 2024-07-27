#' Obtain Data
#'
#' @description
#' Obtain data for a topic within a population at a
#' specified time period and a geographic scale.
#' @param topic_key Unique ID specifying a topic.
#' @param population_key Unique ID for a population
#' stratification.
#' @param period_key Unique ID for a time period.
#' @param layer_key Unique ID for a geographic layer.
#'
#' @return Data tibble containing value and standard
#' error for topic measure.
#' @export
#'
#' @examples
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_data("POP", "H", "2014-2018", "zip")
ha_data <- function(topic_key, population_key, period_key, layer_key) {
  body <- ha_api_data_req(topic_key, population_key, period_key, layer_key) |>
    ha_req_perform() |>
    ha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(c("g", "a", "v", "se")) |>
    dplyr::rename(
      c(
        "geoid" = "g",
        "measure" = "a",
        "value" = "v",
        "standardError" = "se"
      )
    )
}
