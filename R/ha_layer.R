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
    ha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(
      c(
        "layer_name" = "name",
        "layer_key" = "slug",
        "layer_description" = "description",
        "layer_url" = "shapes"
      )
    )
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
  key <- layer_key

  body <- ha_api_geographies_req(layer_key) |>
    ha_req_perform_iterative(progress) |>
    ha_resp_body_iterative()

  layer_sf <- ha_layers() |>
    dplyr::filter(layer_key == key) |>
    purrr::pluck("layer_url") |>
    sf::read_sf() |>
    dplyr::select(c("geoid" = "id"))

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::rename(c("layer_key" = "layer")) |>
    dplyr::left_join(
      layer_sf,
      by = "geoid"
    ) |>
    sf::st_as_sf(crs = 4326)
}
