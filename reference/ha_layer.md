# Obtain Geographic Layer

Import geographic layer as a `sf` object.

## Usage

``` r
ha_layer(layer_key, progress = TRUE)
```

## Arguments

- layer_key:

  Unique ID for a geographic layer.

- progress:

  Display a progress bar?

## Value

`sf` geographic layer.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_layer("zip", progress = FALSE)
#> Simple feature collection with 63 features and 6 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -87.94009 ymin: 41.64428 xmax: -87.52368 ymax: 42.02313
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>    geoid layer_key                          name population state
#> 1  60007       zip 60007 (Elk Grove Village, IL)      33670    IL
#> 2  60018       zip           60018 (Chicago, IL)      30051    IL
#> 3  60106       zip       60106 (Bensenville, IL)      20562    IL
#> 4  60131       zip     60131 (Franklin Park, IL)      18205    IL
#> 5  60176       zip     60176 (Schiller Park, IL)      11714    IL
#> 6  60601       zip           60601 (Chicago, IL)      15814    IL
#> 7  60602       zip           60602 (Chicago, IL)       1261    IL
#> 8  60603       zip           60603 (Chicago, IL)       1288    IL
#> 9  60604       zip           60604 (Chicago, IL)        897    IL
#> 10 60605       zip           60605 (Chicago, IL)      34071    IL
#>                        notes                       geometry
#> 1                            MULTIPOLYGON (((-87.93898 4...
#> 2                            MULTIPOLYGON (((-87.93528 4...
#> 3                            MULTIPOLYGON (((-87.93898 4...
#> 4                            MULTIPOLYGON (((-87.84959 4...
#> 5                            MULTIPOLYGON (((-87.85421 4...
#> 6  Central business district MULTIPOLYGON (((-87.61608 4...
#> 7  Central business district MULTIPOLYGON (((-87.62449 4...
#> 8  Central business district MULTIPOLYGON (((-87.62449 4...
#> 9  Central business district MULTIPOLYGON (((-87.62438 4...
#> 10                           MULTIPOLYGON (((-87.60432 4...
# }
```
