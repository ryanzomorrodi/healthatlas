ha_req <- function(endpoint) {
  if (!curl::has_internet()) {
    stop("Your API call has errors. No Internet Connection.")
  } else if (is.null(ha_get())) {
    stop("Set your portal using ha_set()")
  }

  httr2::request(ha_get()) |>
    httr2::req_user_agent("healthatlas R package") |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(format = "json") |>
    httr2::req_error(body = \(x) "Your API call has errors. No Results.")
}

ha_req_perform_iterative <- function(req, progress = TRUE) {
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

ha_req_perform <- function(req) {
  httr2::req_perform(req)
}

ha_resp_body_iterative <- function(resp) {
  resp |>
    purrr::map(httr2::resp_body_json) |>
    purrr::map(~ .x$results) |>
    purrr::list_c()
}

ha_resp_body <- function(resp, accessor = NULL) {
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
