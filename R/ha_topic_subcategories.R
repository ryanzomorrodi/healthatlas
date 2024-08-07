#' List Topic Subcategories
#'
#' @description
#' List the topic subcategories, which can be
#' used to filter topics within `ha_topics()`.
#' 
#' @return Topic subcategory tibble
#' @export
#'
#' @examples
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_topic_subcategories()
ha_topic_subcategories <- function() {
  body <- ha_api_categories_req() |>
    ha_req_perform() |>
    ha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    tidyr::unnest_longer("subcategories") |>
    tidyr::unnest_wider("subcategories", names_sep = "_") |>
    dplyr::select(
      c(
        "subcategories_name",
        "subcategories_key" = "subcategories_slug",
        "category_name" = "name"
      )
    )
}
