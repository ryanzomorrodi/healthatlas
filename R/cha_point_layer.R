cha_point_layers <- function() {
  cha_api_points() |>
    dplyr::select(
      point_layer_name = name,
      point_layer_uuid = uuid,
      point_layer_description = description)
}

cha_point_layer <- function(point_layer_uuid) {
  cha_api_points(point_layer_uuid) |>
    dplyr::mutate(
      name = purrr::map_chr(name, ~ 
        xml2::xml_text(xml2::read_html(paste0("<x>", .x, "</x>")))
      )
    )
}
