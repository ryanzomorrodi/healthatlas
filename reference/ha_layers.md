# List Geographic Layers

List all geographic layers available.

## Usage

``` r
ha_layers()
```

## Value

Layer information tibble.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_layers()
#> # A tibble: 7 × 3
#>   layer_name      layer_key    layer_url                                        
#>   <chr>           <chr>        <chr>                                            
#> 1 Community areas neighborhood https://metopio.blob.core.windows.net/lalage/sha…
#> 2 ZIP Codes       zip          https://metopio.blob.core.windows.net/lalage/sha…
#> 3 Census Tracts   tract-2020   https://metopio.blob.core.windows.net/lalage/sha…
#> 4 Chicago         place        https://metopio.blob.core.windows.net/lalage/sha…
#> 5 United States   us           https://metopio.blob.core.windows.net/lalage/sha…
#> 6 States          state        https://metopio.blob.core.windows.net/lalage/sha…
#> 7 Counties        county       https://metopio.blob.core.windows.net/lalage/sha…
# }
```
