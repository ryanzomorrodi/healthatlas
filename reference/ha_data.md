# Obtain Data

Obtain data for one or more topics within specified populations for
specified time periods and geographic scale.

All combinations of topic, population, period, and layer will be
returned. Warnings will be generated for any invalid combinations.

## Usage

``` r
ha_data(
  topic_key,
  population_key,
  period_key,
  layer_key,
  geometry = FALSE,
  progress = TRUE
)
```

## Arguments

- topic_key:

  Character string or vector of Unique IDs(s) specifying topic(s).

- population_key:

  Character string or vector of Unique ID(s) for population
  stratification(s).

- period_key:

  Character string or vector of Unique ID(s) for time period(s).

- layer_key:

  Character string specifying an Unique ID for a geographic layer.

- geometry:

  Attach geometry to output?

- progress:

  Display a progress bar?

## Value

Data tibble containing value and standard error for each topic measure.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_data("POP", "H", "2014-2018", "zip")
#> # A tibble: 32,923 × 7
#>    geoid topic_key population_key period_key layer_key value standardError
#>    <chr> <chr>     <chr>          <chr>      <chr>     <dbl>         <dbl>
#>  1 72013 POP       H              2014-2018  zip          15         15.2 
#>  2 95684 POP       H              2014-2018  zip         298        157.  
#>  3 92086 POP       H              2014-2018  zip         217         55.3 
#>  4 95430 POP       H              2014-2018  zip           0          7.29
#>  5 61007 POP       H              2014-2018  zip           9          9.12
#>  6 61276 POP       H              2014-2018  zip          69         51.1 
#>  7 34473 POP       H              2014-2018  zip        6863        727.  
#>  8 61417 POP       H              2014-2018  zip           5          4.86
#>  9 31552 POP       H              2014-2018  zip           0          7.90
#> 10 70449 POP       H              2014-2018  zip          20         18.8 
#> # ℹ 32,913 more rows
# }
```
