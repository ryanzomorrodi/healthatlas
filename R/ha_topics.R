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
  body <- ha_api_topics_req(subcategory_key) |>
    ha_req_perform_iterative(progress) |>
      lapply(\(x) httr2::resp_body_json(x, simplifyVector = TRUE)) |>
      lapply(\(x) x[["results"]])
  
  output <- do.call(rbind, body)
  subcategories <- do.call(rbind, output$subcategories)
  output <- output[c("name", "key", "description", "units")]
  colnames(output) <- c("topic_name", "topic_key", "topic_description", "topic_units")
  colnames(subcategories) <- c("subcategory_name", "subcategory_key", "category_name")
  
  cbind(output, subcategories)
}
