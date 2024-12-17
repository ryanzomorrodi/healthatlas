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
  chk::chk_not_missing(topic_key, x_name = "`topic_key`")
  chk::chk_string(topic_key)
  if (!is.null(layer_key)) {
    chk::chk_character(layer_key)
  }
  chk::chk_logical(keys_only)
  chk::chk_logical(progress)

  body <- ha_api_coverage_req(topic_key, layer_key) |>
    ha_req_perform() |>
    ha_resp_body("coverages")

  output <- cbind(topic_key, body)
  colnames(output) <- c("topic_key", "population_key", "period_key", "layer_key")

  if (!keys_only) {
    stratifications <- ha_stratifications(progress)
    layers <- ha_layers()

    output <- output |>
      merge(stratifications, by = "population_key", all.x = TRUE) |>
      merge(layers, by = "layer_key", all.x = TRUE)
      
    output <- output[c("topic_key", "population_key", "population_name", 
      "population_grouping", "period_key", "layer_key", "layer_name")]
  }

  tibble::as_tibble(output)
}
