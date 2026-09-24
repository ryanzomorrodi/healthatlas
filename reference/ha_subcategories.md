# List Topic Subcategories

List the topic subcategories, which can be used to filter topics within
[`ha_topics()`](https://ryanzomorrodi.github.io/healthatlas/reference/ha_topics.md).

## Usage

``` r
ha_subcategories()
```

## Value

Topic subcategory tibble.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_subcategories()
#> # A tibble: 30 × 3
#>    subcategory_name      subcategory_key       category_name       
#>    <chr>                 <chr>                 <chr>               
#>  1 Access to Care        access-to-care        Clinical Care       
#>  2 Quality of Care       quality-of-care       Clinical Care       
#>  3 Community Safety      community-safety      Physical Environment
#>  4 Housing & Transit     housing-transit       Physical Environment
#>  5 Pollution             pollution-26          Physical Environment
#>  6 Resource Availability resource-availability Physical Environment
#>  7 Behavioral Health     behavioral-health-2   Morbidity           
#>  8 Chronic Disease       chronic-disease-31    Morbidity           
#>  9 Infectious Disease    infectious-disease    Morbidity           
#> 10 Injury & Violence     injury-violence-1     Morbidity           
#> # ℹ 20 more rows
# }
```
