% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ha_getset.R
\name{ha_get}
\alias{ha_get}
\title{Get Health Atlas Portal}
\usage{
ha_get()
}
\value{
Current value of ha_URL environment variable.
}
\description{
Get health atlas currently connected to.
}
\examples{
\donttest{
ha_set("chicagohealthatlas.org")

ha_get()
}
}
