cha_coverage <- function(topic) {
  coverages <- cha_api_coverage(topic) |>
    dplyr::rename(period_key = period)
  statification <- cha_api_stratifications() |>
    dplyr::select(
      population_key = key,
      population_name = name,
      population_grouping = grouping
    )
  layers <- cha_api_layers() |>
    dplyr::select(
      geography_name = name,
      geography_key = slug
    )
  
  coverages |>
    dplyr::left_join(
      statification,
      dplyr::join_by(population == population_key)) |>
    dplyr::left_join(
      layers,
      dplyr::join_by(layer == geography_key)) |>
    dplyr::select(
      population_key = population,
      population_name,
      population_grouping,
      period_key,
      geography_key = layer,
      geography_name)
}
