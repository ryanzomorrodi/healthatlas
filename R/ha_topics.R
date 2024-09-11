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
    ha_resp_body_iterative()
  
  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    tidyr::hoist("subcategories",
      subcategory_name = list(1, "name"),
      subcategory_key = list(1, "slug"),
      category = list(1, "category")
    ) |>
    dplyr::select(
      c(
        "topic_name" = "name",
        "topic_key" = "key",
        "topic_description" = "description",
        "topic_units" = "units",
        "subcategory_name",
        "subcategory_key",
        "category_name" = "category"
      )
    )
}
