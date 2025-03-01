# Indicators
ha_api_topics_req <- function(subcategory = NULL) {
  ha_req("topics") |>
    httr2::req_url_query(limit = 1000, subcategory = subcategory)
}

ha_api_categories_req <- function(name = NULL) {
  ha_req("categories") |>
    httr2::req_url_path_append(name)
}

ha_api_stratifications_req <- function() {
  ha_req("stratifications") |>
    httr2::req_url_query(limit = 1000)
}

ha_api_periods_req <- function(display = NULL) {
  ha_req("periods") |>
    httr2::req_url_path_append(display) |>
    httr2::req_url_query(limit = 1000)
}

# Places
ha_api_layers_req <- function() {
  ha_req("layers")
}

ha_api_geographies_req <- function(layer_slug) {
  ha_req("geographies") |>
    httr2::req_url_path_append(layer_slug) |>
    httr2::req_url_query(limit = 1000)
}

ha_api_points_req <- function(uuid = NULL) {
  ha_req("points") |>
    httr2::req_url_path_append(uuid)
}

ha_api_regions_req <- function(label = NULL) {
  ha_req("regions") |>
    httr2::req_url_path_append(label)
}

# Data
ha_api_coverage_req <- function(topic, layers = NULL) {
  ha_req("coverage") |>
    httr2::req_url_path_append(topic) |>
    httr2::req_url_query(layers = layers, .multi = "comma")
}

ha_api_data_req <- function(topic, population, period, layer) {
  ha_req("data") |>
    httr2::req_url_query(
      topic = topic,
      population = population,
      period = period,
      layer = layer,
      .multi = "comma"
    )
}
