chk_has_internet <- function() {
  if (vld_has_internet()) {
    return(invisible())
  }
  chk::abort_chk("Your API call has errors. No Internet Connection.")
}
vld_has_internet <- function() curl::has_internet()

chk_has_set_ha <- function() {
  if (vld_has_set_ha()) {
    return(invisible())
  }
  chk::abort_chk("Health atlas portal must be set. Try using ha_set()")
}
vld_has_set_ha <- function() !is.na(ha_get())

ha_req <- function(endpoint) {
  chk_has_internet()
  chk_has_set_ha()

  httr2::request(ha_get()) |>
    httr2::req_user_agent("healthatlas R package") |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(format = "json") |>
    httr2::req_cache(path = tempdir()) |>
    httr2::req_error(body = \(x) "Your API call has errors. No Results.")
}

ha_req_perform_iterative <- function(req, progress = TRUE) {
  httr2::req_perform_iterative(
    req,
    next_req = httr2::iterate_with_offset(
      param_name = "offset",
      start = 0,
      offset = 1000,
      resp_pages = function(resp) {
        count <- httr2::resp_body_json(resp)[["count"]]

        if (count == 0) {
          chk::abort_chk("Your API call has errors. No Results.")
        }
        ceiling(count / 1000)
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
    chk::abort_chk("Your API call has errors. No Results.")
  }
  body <- body[[accessor]]
  if (is.matrix(body)) {
    body <- as.data.frame(body)
  }
  if (!is.data.frame(body)) {
    body <- body[lengths(body) != 0]
    body <- lapply(body, as.data.frame)
    body <- lapply(names(body), \(x) cbind(body[[x]], x))
    body <- do.call(rbind, body)
  }

  body
}
