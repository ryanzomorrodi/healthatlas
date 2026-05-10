# Changelog

## healthatlas (development version)

## healthatlas 0.2.2

CRAN release: 2025-07-22

- Started mocking requests to reduce CRAN issues.

## healthatlas 0.2.1

CRAN release: 2025-05-01

- Empty lists within point objects no longer cause errors within
  [`ha_point_layer()`](https://ryanzomorrodi.github.io/healthatlas/reference/ha_point_layer.md).

## healthatlas 0.2.0

CRAN release: 2025-03-01

- Datasets and keywords were added to
  [`ha_topics()`](https://ryanzomorrodi.github.io/healthatlas/reference/ha_topics.md)
  results. Additionally, multiple subcategories are now viewable.
  ([\#5](https://github.com/ryanzomorrodi/healthatlas/issues/5)).
- API page limit was raised, resulting in faster queries
  ([\#7](https://github.com/ryanzomorrodi/healthatlas/issues/7)).
- Requests are now cached
  ([\#9](https://github.com/ryanzomorrodi/healthatlas/issues/9)).

## healthatlas 0.1.1

CRAN release: 2024-12-18

- `dplyr`, `tidyr`, and `purrr` dependencies were removed
  ([\#2](https://github.com/ryanzomorrodi/healthatlas/issues/2)).  
- `chk`s were introduced to ensure type checking and provide consistent
  error syntax.  
- [`ha_get()`](https://ryanzomorrodi.github.io/healthatlas/reference/ha_get.md)
  now returns `NA` if no health atlas is set.

## healthatlas 0.1.0

CRAN release: 2024-09-13

- Initial Release
