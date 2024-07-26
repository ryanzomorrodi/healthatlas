#' List Topic Subcategories
#'
#' @return Topic subcategory tibble
#' @export
#'
#' @examples
#' cha_topic_subcategories()
cha_topic_subcategories <- function() {
  body <- cha_api_categories_req() |>
    cha_req_perform() |>
    cha_resp_body("results")

  tibble::tibble(body) |>
    tidyr::unnest_wider(body) |>
    tidyr::unnest_longer(subcategories) |>
    tidyr::unnest_wider(subcategories, names_sep = "_") |>
    dplyr::select(
      subcategories_name,
      subcategories_key = subcategories_slug,
      category_name = name
    )
}
