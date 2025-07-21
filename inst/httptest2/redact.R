function(response) {
  httptest2::gsub_response(
    response,
    "https://chicagohealthatlas.org/",
    "",
    fixed = TRUE
  )
}
