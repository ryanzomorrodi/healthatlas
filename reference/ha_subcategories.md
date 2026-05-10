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
#> # A tibble: 32 × 3
#>    subcategory_name      subcategory_key       category_name       
#>    <chr>                 <chr>                 <chr>               
#>  1 Pollution             pollution-32          Environmental       
#>  2 Access to Care        access-to-care        Clinical Care       
#>  3 Quality of Care       quality-of-care       Clinical Care       
#>  4 Cancer                cancer-36             Health Outcomes     
#>  5 Community Safety      community-safety      Physical Environment
#>  6 Housing & Transit     housing-transit       Physical Environment
#>  7 Pollution             pollution-26          Physical Environment
#>  8 Resource Availability resource-availability Physical Environment
#>  9 Behavioral Health     behavioral-health-2   Morbidity           
#> 10 Chronic Disease       chronic-disease-31    Morbidity           
#> # ℹ 22 more rows
# }
```
