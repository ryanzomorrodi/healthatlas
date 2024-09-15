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
    ha_resp_body("results")

  output <- asplit(body, 1) |>
    lapply(do.call, what = cbind) |>
    do.call(what = rbind)
  
  output <- output[c("subcategories.name", "subcategories.slug", "name")]
  colnames(output) <- c("subcategory_name", "subcategory_key", "category_name")
  rownames(output) <- NULL

  tibble::as_tibble(output)
}
