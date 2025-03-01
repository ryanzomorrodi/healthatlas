cha_url <- "chicagohealthatlas.org"
cha_subcategory_key <- "education"

subcategories_header <- c(
  "subcategory_name",
  "subcategory_key",
  "category_name"
)
topic_header <- c(
  "topic_name",
  "topic_key",
  "topic_description",
  "topic_units",
  "topic_keywords",
  "topic_datasets",
  "topic_subcategories"
)
coverage_header <- c(
  "topic_key",
  "population_key",
  "population_name",
  "population_grouping",
  "period_key",
  "layer_key",
  "layer_name"
)
coverage_header_keys_only <- c(
  "topic_key",
  "population_key",
  "period_key",
  "layer_key"
)
data_header_long <- c(
  "geoid",
  "topic_key",
  "population_key",
  "period_key",
  "layer_key",
  "value",
  "standardError"
)
layers_header <- c("layer_name", "layer_key", "layer_description", "layer_url")
layer_header <- c(
  "geoid",
  "layer_key",
  "name",
  "population",
  "state",
  "notes",
  "geometry"
)
point_layers_header <- c(
  "point_layer_name",
  "point_layer_uuid",
  "point_layer_description"
)
