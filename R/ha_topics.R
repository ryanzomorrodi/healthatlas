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

  output <- tibble::as_tibble(body)
  output$keywords <- strsplit(output$keywords, ",") |>
    lapply(trimws)
  output$datasets <- lapply(output$datasets, process_dataset)
  output$subcategories <- lapply(output$subcategories, process_subcategory)

  output <- output[c(
    "name",
    "key",
    "description",
    "units",
    "keywords",
    "datasets",
    "subcategories"
  )]
  colnames(output) <- paste0("topic_", names(output))

  output
}

process_dataset <- function(data_df) {
  col_names <- c("name", "key")

  if (nrow(data_df) == 0) {
    return(
      tibble::as_tibble(
        matrix(
          rep(NA_character_, length(col_names)),
          ncol = length(col_names),
          dimnames = list(NULL, col_names)
        )
      )
    )
  }

  data_df <- tibble::as_tibble(data_df$dataset)
  colnames(data_df) <- col_names

  data_df
}

process_subcategory <- function(subcategory_df) {
  col_names <- c("name", "key", "category")

  if (nrow(subcategory_df) == 0) {
    return(
      tibble::as_tibble(
        matrix(
          rep(NA_character_, length(col_names)),
          ncol = length(col_names),
          dimnames = list(NULL, col_names)
        )
      )
    )
  }

  subcategory_df <- tibble::as_tibble(subcategory_df)
  colnames(subcategory_df) <- col_names

  subcategory_df
}
