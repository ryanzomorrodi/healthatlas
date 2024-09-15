#' List Geographic Layers
#' 
#' @description
#' List all geographic layers available.
#' 
#' @return Layer information tibble.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_layers()
#' }
ha_layers <- function() {
  body <- ha_api_layers_req() |>
    ha_req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  output <- body[["results"]]
  output <- output[c("name", "slug", "description", "shapes")]
  colnames(output) <- c("layer_name", "layer_key", "layer_description", "layer_url")

  output
}

#' Obtain Geographic Layer
#'
#' @description
#' Import geographic layer as a `sf` object.
#' @param layer_key Unique ID for a geographic layer.
#' @param progress Display a progress bar?
#' 
#' @return `sf` geographic layer.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_layer("zip", progress = FALSE)
#' }
ha_layer <- function(layer_key, progress = TRUE) {
  body <- ha_api_geographies_req(layer_key) |>
    ha_req_perform_iterative(progress) |>
    lapply(\(x) httr2::resp_body_json(x, simplifyVector = TRUE)) |>
    lapply(\(x) x[["results"]])

  layers <- ha_layers()
  layer_url <- layers[layers$layer_key == layer_key, "layer_url"]
  layer_sf <- sf::read_sf(layer_url) |>
    subset(select = "id") |>
    setNames(c("geoid", "geometry"))

  do.call(rbind, body) |>
    merge(layer_sf, by = "geoid", all.x = TRUE) |>
    sf::st_as_sf(crs = 4326)
}
