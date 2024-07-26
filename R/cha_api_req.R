# Indicators
cha_api_topics_req <- function(subcategory = NULL) {
  cha_req("topics") |>
    httr2::req_url_query(limit = 20, subcategory = subcategory)
}

cha_api_categories_req <- function(name = NULL) {
  cha_req("categories") |>
    httr2::req_url_path_append(name)
}

cha_api_stratifications_req <- function() {
  cha_req("stratifications") |>
    httr2::req_url_query(limit = 20)
}

cha_api_periods_req <- function(display = NULL) {
  cha_req("periods") |>
    httr2::req_url_path_append(display) |>
    httr2::req_url_query(limit = 20)
}

# Places
cha_api_layers_req <- function() {
  cha_req("layers")
}

cha_api_geographies_req <- function(layer_slug) {
  cha_req("geographies") |>
    httr2::req_url_path_append(layer_slug)
}

cha_api_points_req <- function(uuid = NULL) {
  cha_req("points") |>
    httr2::req_url_path_append(uuid)
}

cha_api_regions_req <- function(label = NULL) {
  cha_req("regions") |>
    httr2::req_url_path_append(label)
}

# Data
cha_api_coverage_req <- function(topic, layers = NULL) {
  cha_req("coverage") |>
    httr2::req_url_path_append(topic) |>
    httr2::req_url_query(layers = layers)
}

cha_api_data_req <- function(topic, population, period, layer) {
  cha_req("data") |>
    httr2::req_url_query(
      topic =  topic,
      population = population,
      period = period,
      layer = layer
    )
}
