cha_topic_subcategories <- function() {
  cha_api_categories() |>
    dplyr::select(
      subcategories_name,
      subcategories_key = subcategories_slug,
      category_name = name
    )
}
