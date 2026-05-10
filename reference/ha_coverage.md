# List Topic Coverage

List all combinations of population, periods, and geographic layers
available for a given topic. To search for individual topics use
[`ha_topics()`](https://ryanzomorrodi.github.io/healthatlas/reference/ha_topics.md).

## Usage

``` r
ha_coverage(topic_key, layer_key = NULL, keys_only = FALSE, progress = TRUE)
```

## Arguments

- topic_key:

  Unique ID specifying a topic.

- layer_key:

  Character string or vector of Unique IDs for geographic layers.

- keys_only:

  Return only keys?

- progress:

  Display a progress bar?

## Value

Topic coverage tibble.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_coverage("POP", progress = FALSE)
#> # A tibble: 8,236 × 7
#>    topic_key population_key population_name       population_grouping period_key
#>    <chr>     <chr>          <chr>                 <chr>               <chr>     
#>  1 POP       "HM"           Hispanic or Latino, … "Race/Ethnicity an… 2006      
#>  2 POP       "AFJ"          Asian or Pacific Isl… "Race/Ethnicity, S… 2019      
#>  3 POP       ""             Full population       ""                  2010-2014 
#>  4 POP       "AY"           Asian, Young Adults … "Race/Ethnicity an… 2016      
#>  5 POP       ""             Full population       ""                  2011      
#>  6 POP       "BFY"          Black, Females, Youn… "Race/Ethnicity, S… 2014-2018 
#>  7 POP       "MS"           Males, Seniors (65 a… "Sex and Age"       2008      
#>  8 POP       "WO"           White, Middle-Aged A… "Race/Ethnicity an… 2020-2024 
#>  9 POP       "HY"           Hispanic or Latino, … "Race/Ethnicity an… 2019-2023 
#> 10 POP       "AFY"          Asian or Pacific Isl… "Race/Ethnicity, S… 2018      
#> # ℹ 8,226 more rows
#> # ℹ 2 more variables: layer_key <chr>, layer_name <chr>
# }
```
