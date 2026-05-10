# Get Health Atlas Portal

Get health atlas currently connected to.

## Usage

``` r
ha_get()
```

## Value

Current value of ha_URL environment variable.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_get()
#> [1] "https://chicagohealthatlas.org/api/v1/"
# }
```
