#' List Point Layers
#'
#' @description
#' List all point layers available.
#' 
#' @return Point layer information tibble.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_point_layers()
#' }
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
#' @return `sf` point layer.
#' @export
#'
#' @examples 
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_point_layer("67f58fa0-0dfa-4ee9-8600-c1ab4a093dc6")
#' }
ha_point_layer <- function(point_layer_uuid) {
  body <- ha_api_points_req(point_layer_uuid) |>
    ha_req_perform() |>
    ha_resp_body("points")
  
  output <- tibble::tibble(body) |>
    tidyr::unnest_wider(
      body,
      names_sep = "_"
    ) |>
    purrr::set_names(c("name", "lat", "lon"))
    
  output |> 
    dplyr::mutate("name" = gsub("&amp;", "&", !!as.symbol("name"))) |>
    dplyr::mutate("name" = strsplit(!!as.symbol("name"), "<br>")) |>
    dplyr::mutate("name" = 
      purrr::map(!!as.symbol("name"), function(x) {
        if (length(x) == 1) {
          names(x) <- "name"
        } else if (length(x) == 2) {
          names(x) <- c("name", "notes")
        } else if (length(x) == 3) {
          names(x) <- c("name", "addressLine_1", "addressLine_2")
        }
        x
      })
    ) |>
    tidyr::unnest_wider("name") |>
    dplyr::mutate(dplyr::across(-c("lat", "lon"), ~ gsub("<[^>]*>", "", .x))) |>
    dplyr::mutate(dplyr::across(-c("lat", "lon"), ~ gsub("^\\s+|\\s+$", "", .x))) |>
    sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
}
