# List Point Layers

List all point layers available.

## Usage

``` r
ha_point_layers()
```

## Value

Point layer information tibble.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_point_layers()
#> # A tibble: 10 × 3
#>    point_layer_name                      point_layer_uuid point_layer_descript…¹
#>    <chr>                                 <chr>            <chr>                 
#>  1 Acute Care Hospitals - 2023           67f58fa0-0dfa-4… ""                    
#>  2 Chicago Public Schools - 2023         5a449804-a2cc-4… ""                    
#>  3 Federally Qualified Health Centers -… 22f48fd6-ee98-4… ""                    
#>  4 Federally Qualified Health Centers (… f224b3ce-6d83-4… ""                    
#>  5 Grocery Stores                        7d9caf3c-75e6-4… "All chain grocery st…
#>  6 Hospitals                             8768fad7-65a2-4… "https://hifld-geopla…
#>  7 Nursing Homes                         379a55c7-e569-4… "https://hifld-geopla…
#>  8 Pharmacies and Drug Stores            93ace519-6ba2-4… "All chain pharmacies…
#>  9 Skilled Nursing Facilities - 2023     93bc497d-3881-4… ""                    
#> 10 WIC Offices - 2023                    7c8e9992-4e25-4… ""                    
#> # ℹ abbreviated name: ¹​point_layer_description
# }
```
