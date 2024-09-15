ha_req <- function(endpoint) {
  if (!curl::has_internet()) {
    stop("Your API call has errors. No Internet Connection.")
  } else if (ha_get() == "") {
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
        count <- httr2::resp_body_json(resp)[["count"]]

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
    lapply(\(x) httr2::resp_body_json(x, simplifyVector = TRUE)) |>
    lapply(\(x) x[["results"]]) |>
    do.call(what = rbind)
}

ha_resp_body <- function(resp, accessor) {
  body <- httr2::resp_body_json(resp, simplifyVector = TRUE)

  count <- body[["count"]]
  if (!is.null(count) && count == 0) {
    stop("Your API call has errors. No Results.")
  }
  body <- body[[accessor]]
  if (is.matrix(body)) {
    body <- as.data.frame(body)
  }
  if (!is.data.frame(body)) {
    body <- body[!is.na(body)]
    body <- lapply(body, as.data.frame)
    body <- lapply(names(body), \(x) cbind(body[[x]], x))
    body <- do.call(rbind, body)
  }

  body
}

as_tibble <- function(x) {
  class(x) <- c("tbl_df", "tbl", "data.frame")
  x
}
