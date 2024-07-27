#' List Point Layers
#'
#' @description
#' List all point layers available.
#' 
#' @return Point layer information tibble.
#' @export
#'
#' @examples
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_point_layers()
ha_point_layers <- function() {
  body <- ha_api_points_req() |>
    ha_req_perform() |>
    ha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(
      c(
        "point_layer_name" = "name",
        "point_layer_uuid" = "uuid",
        "point_layer_description" = "description"
      )
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
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_point_layer("67f58fa0-0dfa-4ee9-8600-c1ab4a093dc6")
ha_point_layer <- function(point_layer_uuid) {
  body <- ha_api_points_req(point_layer_uuid) |>
    ha_req_perform() |>
    ha_resp_body("points")
  
  output <- tibble::tibble(body) |>
    tidyr::unnest_wider(
      body,
      names_sep = "_"
    ) |>
    purrr::set_names(c("name", "lat", "lon")) |>
    sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
    
  output$name <- purrr::map_chr(output$name, function(pt_name) {
    xml2::xml_text(xml2::read_html(paste0("<x>", pt_name, "</x>")))
  })

  output
}
