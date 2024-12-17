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
    httr2::resp_body_json(simplifyVector = TRUE)

  output <- body[["results"]]
  output <- output[c("name", "uuid", "description")]
  colnames(output) <- c("point_layer_name", "point_layer_uuid", "point_layer_description")

  tibble::as_tibble(output)
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
  chk::chk_not_missing(point_layer_uuid, x_name = "`point_layer_uuid`")
  chk::chk_string(point_layer_uuid)

  body <- ha_api_points_req(point_layer_uuid) |>
    ha_req_perform() |>
    ha_resp_body("points")
  
  output <- tibble::as_tibble(body)
  colnames(output) <- c("name", "lat", "lon")
  output$name <- gsub("&amp;", "&", output$name)
  output$name <- gsub("<[^>]*>", " ", output$name)
  output$name <- gsub("\\s+", " ", output$name)
  output$name <- trimws(output$name)

  sf::st_as_sf(output, coords = c("lon", "lat"), crs = 4326)
}
