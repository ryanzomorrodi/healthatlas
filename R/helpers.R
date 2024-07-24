cha_req_perform_iterative <- function(req) {
  httr2::req_perform_iterative(
    req,
    next_req = httr2::iterate_with_offset(
      param_name = "offset",
      start = 0,
      offset = 20,
      resp_pages = function(resp) ceiling(httr2::resp_body_json(resp)$count / 20)
    ),
    max_reqs = Inf
  )
}

cha_resp_body_iterative <- function(resp) {
  resp |>
    purrr::map(httr2::resp_body_json) |>
    purrr::map(~ .x$results) |>
    purrr::list_c()
}

cha_req_perform <- function(req) {
  httr2::req_perform(req)
}

cha_resp_body <- function(resp) {
  httr2::resp_body_json(resp) |>
    list()
}
