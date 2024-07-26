#' List Geographic Layers
#' 
#' @description
#' List geographic layers available.
#' 
#' @return Layer information tibble.
#' @export
#'
#' @examples
#' cha_layers()
cha_layers <- function() {
  body <- cha_api_layers_req() |>
    cha_req_perform() |>
    cha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(
      layer_name = name,
      layer_key = slug,
      layer_description = description,
      layer_url = shapes
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
#' cha_layer("zip")
cha_layer <- function(layer_key, progress = TRUE) {
  body <- cha_api_geographies_req(layer_key) |>
    cha_req_perform_iterative(progress) |>
    cha_resp_body_iterative()

  layer_sf <- cha_layers() |>
    dplyr::filter(layer_key == .env$layer_key) |>
    purrr::pluck("layer_url") |>
    sf::read_sf() |>
    dplyr::select(geoid = id)

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::rename(layer_key = layer) |>
    dplyr::left_join(
      layer_sf,
      by = dplyr::join_by(geoid)
    ) |>
    sf::st_as_sf(crs = 4326)
}
