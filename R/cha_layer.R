cha_layers <- function() {
  cha_api_layers() |>
    dplyr::select(
      layer_name = name,
      layer_key = slug,
      layer_description = description,

    )
}

cha_layer <- function(layer_key) {
  layer_url <- cha_api_layers() |>
    dplyr::filter(slug == layer_key) |>
    purrr::pluck("shapes")

  layer_sf <- sf::read_sf(layer_url) |>
    dplyr::select(id)

  layer_df <- cha_api_geographies(layer_key) |>
    dplyr::rename(layer_key = layer)

  layer_sf |>
    dplyr::left_join(
      layer_df, 
      by = dplyr::join_by(id == geoid)) |>
    dplyr::relocate(geometry, .after = dplyr::everything()) |>
    dplyr::rename(geoid = id)
}