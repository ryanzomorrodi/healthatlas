cha_api_url <- "https://chicagohealthatlas.org/api/v1/"

# Indicators 
cha_api_topics <- function(subcategory = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("topics") |>
    httr2::req_url_query(
      format = "json",
      limit = 20,
      subcategory = subcategory)

  resp <- cha_req_perform_iterative(req)
  body <- cha_resp_body_iterative(resp)
  
  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    tidyr::hoist(subcategories,
      subcategory_name = list(1, "name"),
      subcategory_key = list(1, "slug"),
      category = list(1, "category")) |>
    dplyr::select(
      topic_name = name, 
      topic_key = key,
      topic_description = description,
      topic_units = units,
      subcategory_name,
      subcategory_key,
      category
    )
}

cha_api_categories <- function(name = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("categories") |>
    httr2::req_url_path_append(URLencode(name, reserved = TRUE)) |>
    httr2::req_url_query(format = "json")
  
  resp <- cha_req_perform(req)
  body <- httr2::resp_body_json(resp)

  if (is.null(name)) {
    body <- purrr::pluck(body, "results")
  } else {
    body <- list(body)
  }

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    tidyr::unnest_longer(subcategories) |>
    tidyr::unnest_wider(subcategories, names_sep = "_") |>
    dplyr::select(-subcategories_category)
}

cha_api_stratifications <- function(key = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("stratifications") |>
    httr2::req_url_path_append(key) |>
    httr2::req_url_query(
      format = "json",
      limit = 20)
  
  if (is.null(key)) {
    resp <- cha_req_perform_iterative(req)
    body <- cha_resp_body_iterative(resp)
  } else {
    resp <- cha_req_perform(req)
    body <- cha_resp_body(resp)
  }

  tibble::tibble(body) |>
    tidyr::unnest_wider(body)
}

cha_api_periods <- function(display = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("periods") |>
    httr2::req_url_path_append(URLencode(display, reserved = TRUE)) |>
    httr2::req_url_query(
      format = "json",
      limit = 20)
  
  if (is.null(display)) {
    resp <- cha_req_perform_iterative(req)
    body <- cha_resp_body_iterative(resp)
  } else {
    resp <- cha_req_perform(req)
    body <- cha_resp_body(resp)
  }

  tibble::tibble(body) |>
    tidyr::unnest_wider(body)
}

# Places
cha_api_layers <- function() {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("layers") |>
    httr2::req_url_query(format = "json")
  
  resp <- cha_req_perform(req)
  body <- httr2::resp_body_json(resp) |>
    purrr::pluck("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body)
}

cha_api_geographies <- function(layer_slug) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("geographies") |>
    httr2::req_url_path_append(URLencode(layer_slug, reserved = TRUE)) |>
    httr2::req_url_query(format = "json")
  
  resp <- cha_req_perform_iterative(req)
  body <- cha_resp_body_iterative(resp)

  result <- tibble::tibble(body) |>
    tidyr::unnest_wider(body)

  result
}

cha_api_points <- function(uuid = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("points") |>
    httr2::req_url_path_append(URLencode(uuid, reserved = TRUE)) |>
    httr2::req_url_query(format = "json")
  
  resp <- cha_req_perform(req)
  body <- httr2::resp_body_json(resp) 
  
  if (is.null(uuid)) {
    body <- purrr::pluck(body, "results")

    tibble::tibble(body) |>
      tidyr::unnest_wider(body)
  } else {
    body <- purrr::pluck(body, "points")

    tibble::tibble(body) |>
      tidyr::unnest_wider(
        body,
        names_sep="_") |>
      purrr::set_names(c("name", "lon", "lat")) |>
      sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
  }
}

cha_api_regions <- function(label = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("regions") |>
    httr2::req_url_path_append(URLencode(label, reserved = TRUE)) |>
    httr2::req_url_query(format = "json")
  
  resp <- cha_req_perform(req)
  body <- httr2::resp_body_json(resp) 

  if (is.null(label)) {
    body <- purrr::pluck(body, "results")
  } else {
    body <- purrr::pluck(body, "geographies")
  }

  tibble::tibble(body) |>
    tidyr::unnest_wider(body)
}

# Data
cha_api_coverage <- function(topic, layers = NULL) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("coverage") |>
    httr2::req_url_path_append(URLencode(topic, reserved = TRUE)) |>
    httr2::req_url_query(
      layers = layers,
      format = "json")
  
  resp <- cha_req_perform(req)
  body <- httr2::resp_body_json(resp) |>
    purrr::pluck("coverages") |>
    list()

  tibble::tibble(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_longer(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::rename(layer = body_id)
}

cha_api_data <- function(topic, population, period, layer) {
  req <- httr2::request(cha_api_url) |>
    httr2::req_url_path_append("data") |>
    httr2::req_url_query(
      format = "json",
      topic =  topic,
      population = population,
      period = period,
      layer = layer)

  resp <- req |> 
    httr2::req_perform()

  body <- resp |>
    httr2::resp_body_json() |>
    purrr::pluck("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    dplyr::select(g, a, v, se) |>
    dplyr::rename(
      !!layer := g, 
      measure = a, 
      value = v, 
      standardError = se)
}
