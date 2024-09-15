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
  
  output <- body[c("g", "a", "p", "d", "l", "v", "se")]
  keys <- c("topic_key", "population_key", "period_key", "layer_key")
  colnames(output) <- c("geoid", keys, "value", "standardError")
  
  combinations <- expand.grid(
    topic_key = topic_key, 
    population_key = population_key, 
    period_key = period_key, 
    layer_key = layer_key
  )
  missing <- combinations[!interaction(combinations[keys]) %in% interaction(output[keys]),]
  for (i in seq_len(nrow(missing))) {
    warning(paste0(
      "Your API call has errors. No results for ",
      "topic_key = \"", missing$topic_key[i],
      "\" population_key = \"", missing$population_key[i],
      "\" period_key = \"", missing$period_key[i],
      "\" layer_key = \"", missing$layer_key[i],
      "\"."
    ))
  }
  
  if (wide) {
    idvars = c("geoid", "population_key", "period_key", "layer_key")
    output <- reshape(
      output, 
      direction = "wide", 
      idvar = idvars, 
      timevar = c("topic_key"),
      sep = "_"
    )

    # flipping new names to "{topic_key}_{.value}"
    col_index <- !(colnames(output) %in% idvars)
    colnames(output)[col_index] <- strsplit(colnames(output)[col_index], "_") |> 
      sapply(\(x) paste(rev(x), collapse = "_"))
  }
  if (geometry) {
    layer <- ha_layer(layer_key, progress)

    output <- merge(output, layer[c("geoid")], by = "geoid") |>
      sf::st_as_sf()
  }

  output
}
