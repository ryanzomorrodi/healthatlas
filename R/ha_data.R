#' Obtain Data
#'
#' @description
#' Obtain data for one or more topics within specified
#' populations for specified time periods and geographic
#' scale.
#' 
#' All combinations of topic, population, period, and layer
#' will be returned. Warnings will be generated for any
#' invalid combinations.
#' 
#' @param topic_key  Character string or vector of 
#' Unique IDs specifying topics.
#' @param population_key Character string or vector of 
#' Unique IDs for population stratifications.
#' @param period_key Character string or vector of 
#' Unique IDs for time periods.
#' @param layer_key Character string or vector of 
#' Unique IDs for geographic layers.
#' @param geometry Attach geometry to output?
#' @param wide Pivot wider so that each row contains 
#' the values of all topics within a population at a 
#' specified time period and a geographic area?
#' @param progress Display a progress bar?
#'
#' @return Data tibble containing value and standard
#' error for each topic measure.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_data("POP", "H", "2014-2018", "zip")
#' }
ha_data <- function(topic_key, population_key, period_key, layer_key, geometry = FALSE, wide = FALSE, progress = TRUE) {
  body <- ha_api_data_req(topic_key, population_key, period_key, layer_key) |>
    ha_req_perform() |>
    ha_resp_body("results")

  output <- tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(c("g", "a", "p", "d", "l", "v", "se")) |>
    dplyr::rename(
      c(
        "geoid" = "g",
        "topic_key" = "a",
        "population_key" = "p",
        "period_key" = "d",
        "layer_key" = "l",
        "value" = "v",
        "standardError" = "se"
      )
    )
  
  dplyr::select(
      output, 
      c("topic_key", "population_key", "period_key", "layer_key")
    ) |>
    dplyr::distinct() |>
    dplyr::anti_join(
      x = tidyr::crossing(topic_key, population_key, period_key, layer_key),
      c("topic_key", "population_key", "period_key", "layer_key")
    ) |> purrr::pwalk(function(topic_key, population_key, period_key, layer_key) {
      warning(paste0(
        "Your API call has errors. No results for ",
        "topic_key = \"", topic_key,
        "\" population_key = \"", population_key,
        "\" period_key = \"", period_key,
        "\" layer_key = \"", layer_key,
        "\"."
      ))
    })
  
  if (wide) {
    output <- tidyr::pivot_wider(
      output,
      names_from = "topic_key",
      values_from = c("value", "standardError"),
      names_glue = "{topic_key}_{.value}",
      names_vary = "slowest"
    )
  }
  if (geometry) {
    layer <- ha_layer(layer_key, progress)

    output <- output |>
      dplyr::left_join(
        dplyr::select(layer, "geoid"), 
        "geoid"
      ) |>
      sf::st_as_sf()
  }


  output
}
