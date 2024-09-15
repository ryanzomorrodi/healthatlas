#' List Topic Subcategories
#'
#' @description
#' List the topic subcategories, which can be
#' used to filter topics within `ha_topics()`.
#' 
#' @return Topic subcategory tibble.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_subcategories()
#' }
ha_subcategories <- function() {
  body <- ha_api_categories_req() |>
    ha_req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  output <- body$results 
  output <- asplit(output, 1) |> 
    lapply(\(x) do.call(cbind, x)) |>
    do.call(what = rbind)
  rownames(output) <- NULL
  output <- output[c("subcategories.name", "subcategories.slug", "name")]
  colnames(output) <- c("subcategory_name", "subcategory_key", "category_name")

  output
}
