#' List Point Layers
#'
#' @description
#' List point layers available.
#' 
#' @return Point layer information tibble.
#' @export
#'
#' @examples
#' cha_point_layers()
cha_point_layers <- function() {
  body <- cha_api_points_req() |>
    cha_req_perform() |>
    cha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(
      point_layer_name = name,
      point_layer_uuid = uuid,
      point_layer_description = description
    )
}

#' Obtain Point Layer
#'
#' @description
#' Import point layer as a `sf` object.
#' @param point_layer_uuid Unique ID for a point layer.
#' 
#' @return `sf` point layer
#' @export
#'
#' @examples
#' cha_point_layer("67f58fa0-0dfa-4ee9-8600-c1ab4a093dc6")
cha_point_layer <- function(point_layer_uuid) {
  body <- cha_api_points_req(point_layer_uuid) |>
    cha_req_perform() |>
    cha_resp_body("points")
  
  tibble::tibble(body) |>
    tidyr::unnest_wider(
      body,
      names_sep = "_"
    ) |>
    purrr::set_names(c("name", "lat", "lon")) |>
    sf::st_as_sf(coords = c("lon", "lat"), crs = 4326) |>
    dplyr::mutate(
      name = purrr::map_chr(name, function(pt_name) {
        xml2::xml_text(xml2::read_html(paste0("<x>", pt_name, "</x>")))
      })
    )
}
