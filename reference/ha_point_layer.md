# Obtain Point Layer

Import point layer as a `sf` object.

## Usage

``` r
ha_point_layer(point_layer_uuid)
```

## Arguments

- point_layer_uuid:

  Unique ID for a point layer.

## Value

`sf` point layer.

## Examples

``` r
# \donttest{
ha_set("chicagohealthatlas.org")

ha_point_layer("67f58fa0-0dfa-4ee9-8600-c1ab4a093dc6")
#> Simple feature collection with 33 features and 1 field
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -87.81431 ymin: 41.69231 xmax: -87.56723 ymax: 41.99368
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                                                    name
#> 1               Advocate Aurora Health Illinois Masonic
#> 2                    Holy Cross Hospital (Sinai Health)
#> 3      Saints Mary And Elizabeth Medical Center Chicago
#> 4                             Advocate Trinity Hospital
#> 5  Ann & Robert H. Lurie Children's Hospital Of Chicago
#> 6                 Ascension Resurrection Medical Center
#> 7                                Ascension Saint Joseph
#> 8                        Community First Medical Center
#> 9                                    Hartgrove Hospital
#> 10                               Humboldt Park Hospital
#>                      geometry
#> 1  POINT (-87.65159 41.93722)
#> 2  POINT (-87.69072 41.77019)
#> 3  POINT (-87.68336 41.90251)
#> 4  POINT (-87.56723 41.72669)
#> 5  POINT (-87.62178 41.89645)
#> 6   POINT (-87.81431 41.9871)
#> 7  POINT (-87.63745 41.93467)
#> 8  POINT (-87.76777 41.94523)
#> 9   POINT (-87.76745 41.8657)
#> 10 POINT (-87.69944 41.90052)
# }
```
