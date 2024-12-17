#' List Topics
#'
#' @description
#' List all topics available with descriptions
#' and units.
#' @param subcategory_key Unique id for a
#' topic subcategory
#' @param progress Display a progress bar?
#'
#' @return Topics information tibble.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_topics("education", progress = FALSE)
#' }
ha_topics <- function(subcategory_key = NULL, progress = TRUE) {
  if (!is.null(subcategory_key)) {
    chk::chk_string(subcategory_key)
  }
  chk::chk_logical(progress)

  body <- ha_api_topics_req(subcategory_key) |>
    ha_req_perform_iterative(progress) |>
    ha_resp_body_iterative()
  
  subcategories <- do.call(rbind, body$subcategories)
  output <- body[c("name", "key", "description", "units")]
  colnames(output) <- c("topic_name", "topic_key", "topic_description", "topic_units")
  colnames(subcategories) <- c("subcategory_name", "subcategory_key", "category_name")
  
  cbind(output, subcategories) |>
    tibble::as_tibble()
}
