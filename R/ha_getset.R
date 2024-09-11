#' Set Health Atlas Portal
#'
#' @description
#' Set health atlas to connect to.
#' @param ha_URL URL of the health atlas home page.
#' 
#' @return No return value. Sets ha_URL environment variable.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' }
ha_set <- function(ha_URL) {
  if (!grepl("^https://", ha_URL)) {
    ha_URL <- paste0("https://", ha_URL)
  }
  if (!grepl("/$", ha_URL)) {
    ha_URL <- paste0(ha_URL, "/")
  }
  if (!grepl("api/v1/$", ha_URL)) {
    ha_URL <- paste0(ha_URL, "api/v1/")
  }

  Sys.setenv(ha_URL = ha_URL)
}

#' Get Health Atlas Portal
#'
#' @description
#' Get health atlas currently connected to.
#'
#' @return Current value of ha_URL environment variable.
#' @export
#'
#' @examples
#' \donttest{
#' ha_set("chicagohealthatlas.org")
#' 
#' ha_get()
#' }
ha_get <- function() {
  Sys.getenv("ha_URL")
}
