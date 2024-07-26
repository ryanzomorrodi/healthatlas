cha_api_url <- "https://chicagohealthatlas.org/api/v1/"

cha_req <- function(endpoint) {
  httr2::request(cha_api_url) |>
    httr2::req_user_agent("ChicagoHA R package") |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(format = "json") |>
    httr2::req_error(body = \(x) "Your API call has errors. No Results.")
}

cha_req_perform_iterative <- function(req, progress = TRUE) {
  httr2::req_perform_iterative(
    req,
    next_req = httr2::iterate_with_offset(
      param_name = "offset",
      start = 0,
      offset = 20,
      resp_pages = function(resp) {
        count <- httr2::resp_body_json(resp) |>
          purrr::pluck("count")

        if (count == 0) {
          stop("Your API call has errors. No Results.")
        }
        ceiling(count / 20)
      }
    ),
    max_reqs = Inf,
    progress = progress
  )
}

cha_req_perform <- function(req) {
  httr2::req_perform(req)
}

cha_resp_body_iterative <- function(resp) {
  resp |>
    purrr::map(httr2::resp_body_json) |>
    purrr::map(~ .x$results) |>
    purrr::list_c()
}

cha_resp_body <- function(resp, accessor = NULL) {
  body <- httr2::resp_body_json(resp)

  count <- purrr::pluck(body, "count")
  if (!is.null(count) && count == 0) {
    stop("Your API call has errors. No Results.")
  }
  if (!is.null(accessor)) {
    body <- purrr::pluck(body, accessor)
  }
  if (!is.null(names(body))) {
    body <- list(body)
  }
  body
}
