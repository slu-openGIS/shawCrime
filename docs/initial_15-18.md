Initial 2015-2018 Data Creation
================
Christopher Prener, Ph.D.
(January 14, 2019)

## Introduction

This notebook contains the initial code for cleaning the 2015-2018 crime
file data to create Shaw-specific shapefiles.

## Dependencies

This notebook requires:

``` r
# primary data tools
library(compstatr)     # work with stlmpd crime data

# tidyverse packages
library(dplyr)         # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)         # working with csv data

# spatial packages
library(sf)            # working with spatial data
```

    ## Linking to GEOS 3.6.1, GDAL 2.1.3, PROJ 4.9.3

``` r
library(tidycensus)
library(tigris)        # tiger/line api access
```

    ## To enable 
    ## caching of data, set `options(tigris_use_cache = TRUE)` in your R script or .Rprofile.

    ## 
    ## Attaching package: 'tigris'

    ## The following object is masked from 'package:graphics':
    ## 
    ##     plot

``` r
# other packages
library(janitor)       # frequency tables
library(here)          # file path management
```

    ## here() starts at /Users/chris/GitHub/openGIS/shawCrime

``` r
library(knitr)         # output
library(testthat)      # unit testing
```

    ## 
    ## Attaching package: 'testthat'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     matches

## Create Data

Data downloaded from the STLMPD website come in `.csv` format but with
the wrong file extension. The following bash script copies them to a new
subdirectory and fixes the file extension issue:

``` bash
# change working directory
cd ..
# execute cleaning script
bash source/reformatHTML.sh
```

    ## mkdir: data/intermediate/2015: File exists
    ## mkdir: data/intermediate/2016: File exists
    ## mkdir: data/intermediate/2017: File exists
    ## mkdir: data/intermediate/2018: File exists

## Load Data

With our data renamed, we build a year list objects for 2016, 2017, and
2018 crimes:

``` r
data2015 <- cs_load_year(here("data", "intermediate", "2015"))
data2016 <- cs_load_year(here("data", "intermediate", "2016"))
data2017 <- cs_load_year(here("data", "intermediate", "2017"))
data2018 <- cs_load_year(here("data", "intermediate", "2018"))
```

## Validate Data

### 2015

Next we make sure there are no problems with the crime files in terms of
incongruent columns for 2015:

``` r
cs_validate_year(data2015, year = "2015")
```

    ## [1] FALSE

We can use the `verbose = TRUE` option on `cs_validate_year()` to
identify areas where the validation checks have failed:

``` r
cs_validate_year(data2015, year = "2015", verbose = TRUE)
```

    ## # A tibble: 12 x 9
    ##    namedMonth codedMonth valMonth codedYear valYear oneMonth varCount
    ##    <chr>      <chr>      <lgl>        <int> <lgl>   <lgl>    <lgl>   
    ##  1 January    January    TRUE          2015 TRUE    TRUE     TRUE    
    ##  2 February   February   TRUE          2015 TRUE    TRUE     TRUE    
    ##  3 March      March      TRUE          2015 TRUE    TRUE     TRUE    
    ##  4 April      April      TRUE          2015 TRUE    TRUE     TRUE    
    ##  5 May        May        TRUE          2015 TRUE    TRUE     TRUE    
    ##  6 June       June       TRUE          2015 TRUE    TRUE     TRUE    
    ##  7 July       July       TRUE          2015 TRUE    TRUE     TRUE    
    ##  8 August     August     TRUE          2015 TRUE    TRUE     TRUE    
    ##  9 September  September  TRUE          2015 TRUE    TRUE     TRUE    
    ## 10 October    October    TRUE          2015 TRUE    TRUE     TRUE    
    ## 11 November   November   TRUE          2015 TRUE    TRUE     TRUE    
    ## 12 December   December   TRUE          2015 TRUE    TRUE     TRUE    
    ## # … with 2 more variables: valVars <lgl>, valClasses <lgl>

Since thhere are only issues with the class validation, we’re going to
consider these validated for now.

### 2015

We’ll repeat the same validation for 2016:

``` r
cs_validate_year(data2016, year = "2016")
```

    ## [1] FALSE

We can use the `verbose = TRUE` option on `cs_validate_year()` to
identify areas where the validation checks have failed:

``` r
cs_validate_year(data2016, year = "2016", verbose = TRUE)
```

    ## # A tibble: 12 x 9
    ##    namedMonth codedMonth valMonth codedYear valYear oneMonth varCount
    ##    <chr>      <chr>      <lgl>        <int> <lgl>   <lgl>    <lgl>   
    ##  1 January    January    TRUE          2016 TRUE    TRUE     TRUE    
    ##  2 February   February   TRUE          2016 TRUE    TRUE     TRUE    
    ##  3 March      March      TRUE          2016 TRUE    TRUE     TRUE    
    ##  4 April      April      TRUE          2016 TRUE    TRUE     TRUE    
    ##  5 May        May        TRUE          2016 TRUE    TRUE     TRUE    
    ##  6 June       June       TRUE          2016 TRUE    TRUE     TRUE    
    ##  7 July       July       TRUE          2016 TRUE    TRUE     TRUE    
    ##  8 August     August     TRUE          2016 TRUE    TRUE     TRUE    
    ##  9 September  September  TRUE          2016 TRUE    TRUE     TRUE    
    ## 10 October    October    TRUE          2016 TRUE    TRUE     TRUE    
    ## 11 November   November   TRUE          2016 TRUE    TRUE     TRUE    
    ## 12 December   December   TRUE          2016 TRUE    TRUE     TRUE    
    ## # … with 2 more variables: valVars <lgl>, valClasses <lgl>

Since thhere are only issues with the class validation, we’re going to
consider these validated for now.

### 2017

All of the data passes the validation checks.

``` r
cs_validate_year(data2017, year = "2017")
```

    ## [1] FALSE

We can use the `verbose = TRUE` option on `cs_validate_year()` to
identify areas where the validation checks have failed:

``` r
cs_validate_year(data2017, year = "2017", verbose = TRUE)
```

    ## # A tibble: 12 x 9
    ##    namedMonth codedMonth valMonth codedYear valYear oneMonth varCount
    ##    <chr>      <chr>      <lgl>        <int> <lgl>   <lgl>    <lgl>   
    ##  1 January    January    TRUE          2017 TRUE    TRUE     TRUE    
    ##  2 February   February   TRUE          2017 TRUE    TRUE     TRUE    
    ##  3 March      March      TRUE          2017 TRUE    TRUE     TRUE    
    ##  4 April      April      TRUE          2017 TRUE    TRUE     TRUE    
    ##  5 May        May        TRUE          2017 TRUE    TRUE     FALSE   
    ##  6 June       June       TRUE          2017 TRUE    TRUE     TRUE    
    ##  7 July       July       TRUE          2017 TRUE    TRUE     TRUE    
    ##  8 August     August     TRUE          2017 TRUE    TRUE     TRUE    
    ##  9 September  September  TRUE          2017 TRUE    TRUE     TRUE    
    ## 10 October    October    TRUE          2017 TRUE    TRUE     TRUE    
    ## 11 November   November   TRUE          2017 TRUE    TRUE     TRUE    
    ## 12 December   December   TRUE          2017 TRUE    TRUE     TRUE    
    ## # … with 2 more variables: valVars <lgl>, valClasses <lgl>

The data for May 2017 do not pass the validation checks. We can extract
this month and confirm that there are too many columns in the May 2017
release. Once we have that confirmed, we can standardize that month and
re-run our validation.

``` r
# extract data
may2017 <- cs_extract_month(data2017, month = "May")
# unit test column number
expect_equal(ncol(may2017), 26)
# remove object
rm(may2017)
# standardize months
data2017 <- cs_standardize(data2017, month = "May", config = 26)
# validate data
cs_validate_year(data2017, year = "2017")
```

    ## [1] FALSE

We still get a `FALSE` value for `cs_validate_year()`:

``` r
cs_validate_year(data2017, year = "2017", verbose = TRUE)
```

    ## # A tibble: 12 x 9
    ##    namedMonth codedMonth valMonth codedYear valYear oneMonth varCount
    ##    <chr>      <chr>      <lgl>        <int> <lgl>   <lgl>    <lgl>   
    ##  1 January    January    TRUE          2017 TRUE    TRUE     TRUE    
    ##  2 February   February   TRUE          2017 TRUE    TRUE     TRUE    
    ##  3 March      March      TRUE          2017 TRUE    TRUE     TRUE    
    ##  4 April      April      TRUE          2017 TRUE    TRUE     TRUE    
    ##  5 May        May        TRUE          2017 TRUE    TRUE     TRUE    
    ##  6 June       June       TRUE          2017 TRUE    TRUE     TRUE    
    ##  7 July       July       TRUE          2017 TRUE    TRUE     TRUE    
    ##  8 August     August     TRUE          2017 TRUE    TRUE     TRUE    
    ##  9 September  September  TRUE          2017 TRUE    TRUE     TRUE    
    ## 10 October    October    TRUE          2017 TRUE    TRUE     TRUE    
    ## 11 November   November   TRUE          2017 TRUE    TRUE     TRUE    
    ## 12 December   December   TRUE          2017 TRUE    TRUE     TRUE    
    ## # … with 2 more variables: valVars <lgl>, valClasses <lgl>

We’ve now limited the validation issues to the classes.

### 2018

Finally, we’ll attempt to validate the 2018 data:

``` r
cs_validate_year(data2018, year = "2018")
```

    ## [1] FALSE

Now with the `verbose = TRUE` option:

``` r
cs_validate_year(data2018, year = "2018", verbose = TRUE)
```

    ## # A tibble: 12 x 9
    ##    namedMonth codedMonth valMonth codedYear valYear oneMonth varCount
    ##    <chr>      <chr>      <lgl>        <int> <lgl>   <lgl>    <lgl>   
    ##  1 January    January    TRUE          2018 TRUE    TRUE     TRUE    
    ##  2 February   February   TRUE          2018 TRUE    TRUE     TRUE    
    ##  3 March      March      TRUE          2018 TRUE    TRUE     TRUE    
    ##  4 April      April      TRUE          2018 TRUE    TRUE     TRUE    
    ##  5 May        May        TRUE          2018 TRUE    TRUE     TRUE    
    ##  6 June       June       TRUE          2018 TRUE    TRUE     TRUE    
    ##  7 July       July       TRUE          2018 TRUE    TRUE     TRUE    
    ##  8 August     August     TRUE          2018 TRUE    TRUE     TRUE    
    ##  9 September  September  TRUE          2018 TRUE    TRUE     TRUE    
    ## 10 October    October    TRUE          2018 TRUE    TRUE     TRUE    
    ## 11 November   November   TRUE          2018 TRUE    TRUE     TRUE    
    ## 12 December   December   TRUE          2018 TRUE    TRUE     TRUE    
    ## # … with 2 more variables: valVars <lgl>, valClasses <lgl>

## Collapse Data

With the data validated, we collapse each year into a single, flat
object:

``` r
data2015_flat <- cs_collapse(data2015)
data2016_flat <- cs_collapse(data2016)
data2017_flat <- cs_collapse(data2017)
data2018_flat <- cs_collapse(data2018)
```

What we need for this project is a single object with only the crimes
for 2016. Since crimes were *reported* in subsequent years for 2015 (as
well as 2016 and 2017), we need to merge all the tables and then retain
only the relevant year’s data. The `cs_combine()` function will do
this:

``` r
crimes2015 <- cs_combine(type = "year", date = 2015, data2015_flat, data2016_flat, data2017_flat, data2018_flat)
crimes2016 <- cs_combine(type = "year", date = 2016, data2016_flat, data2017_flat, data2018_flat)
crimes2017 <- cs_combine(type = "year", date = 2017, data2017_flat, data2018_flat)
crimes2018 <- cs_combine(type = "year", date = 2018, data2018_flat)
```

### Clean-up Enviornment

With our data created, we can remove some of the intermediary objects
we’ve
created:

``` r
rm(data2015, data2015_flat, data2016, data2016_flat, data2017, data2017_flat, data2018, data2018_flat)
```

## Remove Unfounded Crimes and Subset Based on Type of Crime:

The following code chunk removes unfounded crimes (those where `Count ==
-1`) and then creates a data frame for all part one crimes for each
year. We also print the number of crimes missing spatial data. In
general, these tend to be rapes.

### 2015

``` r
crimes2015 %>% 
  cs_filter_count(var = Count) %>%
  cs_filter_crime(var = Crime, crime = "Part 1") %>%
  cs_crime_cat(var = Crime, newVar = crimeCat, output = "string") %>%
  cs_missing_xy(varx = XCoord, vary = YCoord, newVar = xyStatus) %>%
  select(Complaint, DateOccur, Crime, crimeCat, District, Description, 
         ILEADSAddress, ILEADSStreet, XCoord, YCoord, xyStatus) -> p1_2015

p1_2015 %>%
  tabyl(xyStatus) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| xyStatus |     n | percent |
| :------- | ----: | :------ |
| FALSE    | 25955 | 98.326% |
| TRUE     |   442 | 1.674%  |

``` r
p1_2015 %>%
  tabyl(crimeCat) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| crimeCat            |     n | percent |
| :------------------ | ----: | :------ |
| Aggravated Assault  |  3529 | 13.369% |
| Arson               |   240 | 0.909%  |
| Burgalry            |  4247 | 16.089% |
| Forcible Rape       |   236 | 0.894%  |
| Homicide            |   194 | 0.735%  |
| Larceny             | 12739 | 48.259% |
| Motor Vehicle Theft |  3359 | 12.725% |
| Robbery             |  1853 | 7.020%  |

### 2016

``` r
crimes2016 %>% 
  cs_filter_count(var = Count) %>%
  cs_filter_crime(var = Crime, crime = "Part 1") %>%
  cs_crime_cat(var = Crime, newVar = crimeCat, output = "string") %>%
  cs_missing_xy(varx = XCoord, vary = YCoord, newVar = xyStatus) %>%
  select(Complaint, DateOccur, Crime, crimeCat, District, Description, 
         ILEADSAddress, ILEADSStreet, XCoord, YCoord, xyStatus) -> p1_2016

p1_2016 %>%
  tabyl(xyStatus) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| xyStatus |     n | percent |
| :------- | ----: | :------ |
| FALSE    | 24954 | 98.078% |
| TRUE     |   489 | 1.922%  |

``` r
p1_2016 %>%
  tabyl(crimeCat) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| crimeCat            |     n | percent |
| :------------------ | ----: | :------ |
| Aggravated Assault  |  3668 | 14.417% |
| Arson               |   297 | 1.167%  |
| Burgalry            |  3270 | 12.852% |
| Forcible Rape       |   281 | 1.104%  |
| Homicide            |   201 | 0.790%  |
| Larceny             | 12511 | 49.173% |
| Motor Vehicle Theft |  3275 | 12.872% |
| Robbery             |  1940 | 7.625%  |

### 2017

``` r
crimes2017 %>% 
  cs_filter_count(var = Count) %>%
  cs_filter_crime(var = Crime, crime = "Part 1") %>%
  cs_crime_cat(var = Crime, newVar = crimeCat, output = "string") %>%
  cs_missing_xy(varx = XCoord, vary = YCoord, newVar = xyStatus) %>%
  select(Complaint, DateOccur, Crime, crimeCat, District, Description, 
         ILEADSAddress, ILEADSStreet, XCoord, YCoord, xyStatus) -> p1_2017

p1_2017 %>%
  tabyl(xyStatus) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| xyStatus |     n | percent |
| :------- | ----: | :------ |
| FALSE    | 25367 | 98.033% |
| TRUE     |   509 | 1.967%  |

``` r
p1_2017 %>%
  tabyl(crimeCat) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| crimeCat            |     n | percent |
| :------------------ | ----: | :------ |
| Aggravated Assault  |  4074 | 15.744% |
| Arson               |   230 | 0.889%  |
| Burgalry            |  3203 | 12.378% |
| Forcible Rape       |   244 | 0.943%  |
| Homicide            |   220 | 0.850%  |
| Larceny             | 12999 | 50.236% |
| Motor Vehicle Theft |  2919 | 11.281% |
| Robbery             |  1987 | 7.679%  |

### 2018

``` r
crimes2018 %>% 
  cs_filter_count(var = Count) %>%
  cs_filter_crime(var = Crime, crime = "Part 1") %>%
  cs_crime_cat(var = Crime, newVar = crimeCat, output = "string") %>%
  cs_missing_xy(varx = XCoord, vary = YCoord, newVar = xyStatus) %>%
  select(Complaint, DateOccur, Crime, crimeCat, District, Description, 
         ILEADSAddress, ILEADSStreet, XCoord, YCoord, xyStatus) -> p1_2018

p1_2018 %>%
  tabyl(xyStatus) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| xyStatus |     n | percent |
| :------- | ----: | :------ |
| FALSE    | 23589 | 98.059% |
| TRUE     |   467 | 1.941%  |

``` r
p1_2018 %>%
  tabyl(crimeCat) %>%
  adorn_pct_formatting(digits = 3) %>%
  kable()
```

| crimeCat            |     n | percent |
| :------------------ | ----: | :------ |
| Aggravated Assault  |  3598 | 14.957% |
| Arson               |   214 | 0.890%  |
| Burgalry            |  2999 | 12.467% |
| Forcible Rape       |   250 | 1.039%  |
| Homicide            |   192 | 0.798%  |
| Larceny             | 12359 | 51.376% |
| Motor Vehicle Theft |  2961 | 12.309% |
| Robbery             |  1483 | 6.165%  |

## Clean Enviornment

``` r
rm(crimes2015, crimes2016, crimes2017, crimes2018)
```

## Create Violent Crime Data Frames

``` r
vc_2015 <- cs_filter_crime(p1_2015, var = Crime, crime = "violent")
vc_2016 <- cs_filter_crime(p1_2016, var = Crime, crime = "violent")
vc_2017 <- cs_filter_crime(p1_2017, var = Crime, crime = "violent")
vc_2018 <- cs_filter_crime(p1_2018, var = Crime, crime = "violent")
```

## Project Data

We project the main set of previously geocoded data, remove excess
columns, and transform the data to NAD 1983:

``` r
p1_2015 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> p1_2015

p1_2016 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> p1_2016

p1_2017 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> p1_2017

p1_2018 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> p1_2018

vc_2015 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> vc_2015

vc_2016 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> vc_2016

vc_2017 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> vc_2017

vc_2018 %>%
  st_as_sf(coords = c("XCoord", "YCoord"), crs = 102696) %>%
  select(-xyStatus) %>%
  st_transform(crs = 4269) -> vc_2018
```

## Spatial Join with Neighborhood Data

``` r
st_read(here("data", "raw", "nhood", "STL_BOUNDARY_Nhoods.shp"), stringsAsFactors = FALSE) %>%
  st_transform(crs = 102696) -> nhoods
```

    ## Reading layer `STL_BOUNDARY_Nhoods' from data source `/Users/chris/GitHub/openGIS/shawCrime/data/raw/nhood/STL_BOUNDARY_Nhoods.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 88 features and 6 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: 871512.3 ymin: 982994.4 xmax: 912850.5 ymax: 1070957
    ## epsg (SRID):    NA
    ## proj4string:    +proj=tmerc +lat_0=35.83333333333334 +lon_0=-90.5 +k=0.9999333333333333 +x_0=250000 +y_0=0 +datum=NAD83 +units=us-ft +no_defs

``` r
nhoods %>%
  filter(NHD_NAME == "Shaw") %>%
  select(NHD_NUM, NHD_NAME) -> shaw

rm(nhoods)
```

``` r
p1_2015 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> p1_2015_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
p1_2016 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> p1_2016_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
p1_2017 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> p1_2017_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
p1_2018 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> p1_2018_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
vc_2015 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> vc_2015_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
vc_2016 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> vc_2016_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
vc_2017 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> vc_2017_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

``` r
vc_2018 %>%
  st_transform(crs = 102696) %>%
  st_intersection(., shaw) %>%
  st_transform(crs = 4269) %>%
  select(-NHD_NAME, -NHD_NUM) -> vc_2018_shaw
```

    ## Warning: attribute variables are assumed to be spatially constant
    ## throughout all geometries

## Write Shapefiles

``` r
st_write(p1_2015_shaw, here("data", "clean", "Part 1", "2015", "SHAW_Part1_2015.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2015/SHAW_Part1_2015.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Part1_2015' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2015/SHAW_Part1_2015.shp' using driver `ESRI Shapefile'
    ## features:       296
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(p1_2016_shaw, here("data", "clean", "Part 1", "2016", "SHAW_Part1_2016.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2016/SHAW_Part1_2016.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Part1_2016' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2016/SHAW_Part1_2016.shp' using driver `ESRI Shapefile'
    ## features:       308
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(p1_2017_shaw, here("data", "clean", "Part 1", "2017", "SHAW_Part1_2017.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2017/SHAW_Part1_2017.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Part1_2017' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2017/SHAW_Part1_2017.shp' using driver `ESRI Shapefile'
    ## features:       329
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(p1_2018_shaw, here("data", "clean", "Part 1", "2018", "SHAW_Part1_2018.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2018/SHAW_Part1_2018.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Part1_2018' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Part 1/2018/SHAW_Part1_2018.shp' using driver `ESRI Shapefile'
    ## features:       201
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(vc_2015_shaw, here("data", "clean", "Violent", "2015", "SHAW_Violent_2015.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2015/SHAW_Violent_2015.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Violent_2015' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2015/SHAW_Violent_2015.shp' using driver `ESRI Shapefile'
    ## features:       20
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(vc_2016_shaw, here("data", "clean", "Violent", "2016", "SHAW_Violent_2016.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2016/SHAW_Violent_2016.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Violent_2016' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2016/SHAW_Violent_2016.shp' using driver `ESRI Shapefile'
    ## features:       41
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(vc_2017_shaw, here("data", "clean", "Violent", "2017", "SHAW_Violent_2017.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2017/SHAW_Violent_2017.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Violent_2017' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2017/SHAW_Violent_2017.shp' using driver `ESRI Shapefile'
    ## features:       37
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(vc_2018_shaw, here("data", "clean", "Violent", "2018", "SHAW_Violent_2018.shp"), delete_dsn = TRUE)
```

    ## Warning in abbreviate_shapefile_names(obj): Field names abbreviated for
    ## ESRI Shapefile driver

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2018/SHAW_Violent_2018.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Violent_2018' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Violent/2018/SHAW_Violent_2018.shp' using driver `ESRI Shapefile'
    ## features:       23
    ## fields:         8
    ## geometry type:  Point

``` r
st_write(shaw, here("data", "clean", "Shaw", "SHAW_Boundary.shp"), delete_dsn = TRUE)
```

    ## Deleting source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Shaw/SHAW_Boundary.shp' using driver `ESRI Shapefile'
    ## Writing layer `SHAW_Boundary' to data source `/Users/chris/GitHub/openGIS/shawCrime/data/clean/Shaw/SHAW_Boundary.shp' using driver `ESRI Shapefile'
    ## features:       1
    ## fields:         2
    ## geometry type:  Multi Polygon

## Crime Rates

``` r
years <- c(2015, 2016, 2017)

years %>%
  unlist(years) %>%
  purrr:::map_df(~ get_acs(year = .x, geography = "county", variable = "B01003_001", state = 29, county = 510)) -> cityPop
```

    ## Getting data from the 2011-2015 5-year ACS

    ## Getting data from the 2012-2016 5-year ACS

    ## Getting data from the 2013-2017 5-year ACS

``` r
tract15 <- get_acs(year = 2015, geography = "tract", variable = "B01003_001", 
                        state = 29, county = 510)
```

    ## Getting data from the 2011-2015 5-year ACS

``` r
tract16 <- get_acs(year = 2016, geography = "tract", variable = "B01003_001", 
                        state = 29, county = 510)
```

    ## Getting data from the 2012-2016 5-year ACS

``` r
tract17 <- get_acs(year = 2017, geography = "tract", variable = "B01003_001", 
                        state = 29, county = 510)
```

    ## Getting data from the 2013-2017 5-year ACS

``` r
tracts <- tigris::tracts(state = 29, count = 510, class = "sf")
```

    ## 
      |                                                                       
      |                                                                 |   0%
      |                                                                       
      |                                                                 |   1%
      |                                                                       
      |=                                                                |   1%
      |                                                                       
      |=                                                                |   2%
      |                                                                       
      |==                                                               |   2%
      |                                                                       
      |==                                                               |   3%
      |                                                                       
      |==                                                               |   4%
      |                                                                       
      |===                                                              |   4%
      |                                                                       
      |===                                                              |   5%
      |                                                                       
      |====                                                             |   5%
      |                                                                       
      |====                                                             |   6%
      |                                                                       
      |====                                                             |   7%
      |                                                                       
      |=====                                                            |   7%
      |                                                                       
      |=====                                                            |   8%
      |                                                                       
      |======                                                           |   9%
      |                                                                       
      |======                                                           |  10%
      |                                                                       
      |=======                                                          |  10%
      |                                                                       
      |=======                                                          |  11%
      |                                                                       
      |========                                                         |  12%
      |                                                                       
      |========                                                         |  13%
      |                                                                       
      |=========                                                        |  13%
      |                                                                       
      |=========                                                        |  14%
      |                                                                       
      |=========                                                        |  15%
      |                                                                       
      |==========                                                       |  15%
      |                                                                       
      |==========                                                       |  16%
      |                                                                       
      |===========                                                      |  16%
      |                                                                       
      |===========                                                      |  17%
      |                                                                       
      |===========                                                      |  18%
      |                                                                       
      |============                                                     |  18%
      |                                                                       
      |============                                                     |  19%
      |                                                                       
      |=============                                                    |  19%
      |                                                                       
      |=============                                                    |  20%
      |                                                                       
      |=============                                                    |  21%
      |                                                                       
      |==============                                                   |  21%
      |                                                                       
      |==============                                                   |  22%
      |                                                                       
      |===============                                                  |  22%
      |                                                                       
      |===============                                                  |  23%
      |                                                                       
      |===============                                                  |  24%
      |                                                                       
      |================                                                 |  24%
      |                                                                       
      |================                                                 |  25%
      |                                                                       
      |=================                                                |  25%
      |                                                                       
      |=================                                                |  26%
      |                                                                       
      |=================                                                |  27%
      |                                                                       
      |==================                                               |  27%
      |                                                                       
      |==================                                               |  28%
      |                                                                       
      |===================                                              |  29%
      |                                                                       
      |===================                                              |  30%
      |                                                                       
      |====================                                             |  30%
      |                                                                       
      |====================                                             |  31%
      |                                                                       
      |=====================                                            |  32%
      |                                                                       
      |=====================                                            |  33%
      |                                                                       
      |======================                                           |  33%
      |                                                                       
      |======================                                           |  34%
      |                                                                       
      |======================                                           |  35%
      |                                                                       
      |=======================                                          |  35%
      |                                                                       
      |=======================                                          |  36%
      |                                                                       
      |========================                                         |  36%
      |                                                                       
      |========================                                         |  37%
      |                                                                       
      |========================                                         |  38%
      |                                                                       
      |=========================                                        |  38%
      |                                                                       
      |=========================                                        |  39%
      |                                                                       
      |==========================                                       |  39%
      |                                                                       
      |==========================                                       |  40%
      |                                                                       
      |==========================                                       |  41%
      |                                                                       
      |===========================                                      |  41%
      |                                                                       
      |===========================                                      |  42%
      |                                                                       
      |============================                                     |  42%
      |                                                                       
      |============================                                     |  43%
      |                                                                       
      |============================                                     |  44%
      |                                                                       
      |=============================                                    |  44%
      |                                                                       
      |=============================                                    |  45%
      |                                                                       
      |==============================                                   |  46%
      |                                                                       
      |==============================                                   |  47%
      |                                                                       
      |===============================                                  |  47%
      |                                                                       
      |===============================                                  |  48%
      |                                                                       
      |================================                                 |  48%
      |                                                                       
      |================================                                 |  49%
      |                                                                       
      |================================                                 |  50%
      |                                                                       
      |=================================                                |  50%
      |                                                                       
      |=================================                                |  51%
      |                                                                       
      |==================================                               |  52%
      |                                                                       
      |==================================                               |  53%
      |                                                                       
      |===================================                              |  53%
      |                                                                       
      |===================================                              |  54%
      |                                                                       
      |===================================                              |  55%
      |                                                                       
      |====================================                             |  55%
      |                                                                       
      |====================================                             |  56%
      |                                                                       
      |=====================================                            |  56%
      |                                                                       
      |=====================================                            |  57%
      |                                                                       
      |=====================================                            |  58%
      |                                                                       
      |======================================                           |  58%
      |                                                                       
      |======================================                           |  59%
      |                                                                       
      |=======================================                          |  59%
      |                                                                       
      |=======================================                          |  60%
      |                                                                       
      |=======================================                          |  61%
      |                                                                       
      |========================================                         |  61%
      |                                                                       
      |========================================                         |  62%
      |                                                                       
      |=========================================                        |  62%
      |                                                                       
      |=========================================                        |  63%
      |                                                                       
      |=========================================                        |  64%
      |                                                                       
      |==========================================                       |  64%
      |                                                                       
      |==========================================                       |  65%
      |                                                                       
      |===========================================                      |  65%
      |                                                                       
      |===========================================                      |  66%
      |                                                                       
      |===========================================                      |  67%
      |                                                                       
      |============================================                     |  67%
      |                                                                       
      |============================================                     |  68%
      |                                                                       
      |=============================================                    |  69%
      |                                                                       
      |=============================================                    |  70%
      |                                                                       
      |==============================================                   |  70%
      |                                                                       
      |==============================================                   |  71%
      |                                                                       
      |===============================================                  |  72%
      |                                                                       
      |===============================================                  |  73%
      |                                                                       
      |================================================                 |  73%
      |                                                                       
      |================================================                 |  74%
      |                                                                       
      |================================================                 |  75%
      |                                                                       
      |=================================================                |  75%
      |                                                                       
      |=================================================                |  76%
      |                                                                       
      |==================================================               |  76%
      |                                                                       
      |==================================================               |  77%
      |                                                                       
      |==================================================               |  78%
      |                                                                       
      |===================================================              |  78%
      |                                                                       
      |===================================================              |  79%
      |                                                                       
      |====================================================             |  79%
      |                                                                       
      |====================================================             |  80%
      |                                                                       
      |====================================================             |  81%
      |                                                                       
      |=====================================================            |  81%
      |                                                                       
      |=====================================================            |  82%
      |                                                                       
      |======================================================           |  82%
      |                                                                       
      |======================================================           |  83%
      |                                                                       
      |======================================================           |  84%
      |                                                                       
      |=======================================================          |  84%
      |                                                                       
      |=======================================================          |  85%
      |                                                                       
      |========================================================         |  86%
      |                                                                       
      |========================================================         |  87%
      |                                                                       
      |=========================================================        |  87%
      |                                                                       
      |=========================================================        |  88%
      |                                                                       
      |==========================================================       |  88%
      |                                                                       
      |==========================================================       |  89%
      |                                                                       
      |==========================================================       |  90%
      |                                                                       
      |===========================================================      |  90%
      |                                                                       
      |===========================================================      |  91%
      |                                                                       
      |============================================================     |  92%
      |                                                                       
      |============================================================     |  93%
      |                                                                       
      |=============================================================    |  93%
      |                                                                       
      |=============================================================    |  94%
      |                                                                       
      |==============================================================   |  95%
      |                                                                       
      |==============================================================   |  96%
      |                                                                       
      |===============================================================  |  96%
      |                                                                       
      |===============================================================  |  97%
      |                                                                       
      |===============================================================  |  98%
      |                                                                       
      |================================================================ |  98%
      |                                                                       
      |================================================================ |  99%
      |                                                                       
      |=================================================================|  99%
      |                                                                       
      |=================================================================| 100%

``` r
tracts <- select(tracts, GEOID)

tract15 <- left_join(tracts, tract15, by = "GEOID")
tract15 <- st_transform(tract15, crs = 102696)

tract16 <- left_join(tracts, tract16, by = "GEOID")
tract16 <- st_transform(tract16, crs = 102696)

tract17 <- left_join(tracts, tract17, by = "GEOID")
tract17 <- st_transform(tract17, crs = 102696)

rm(tracts)
```

``` r
shaw15 <- areal::aw_interpolate(shaw, tid = NHD_NUM, source = tract15, sid = GEOID, 
                      weight = "total", output = "tibble", extensive = "estimate")

shaw16 <- areal::aw_interpolate(shaw, tid = NHD_NUM, source = tract16, sid = GEOID, 
                      weight = "total", output = "tibble", extensive = "estimate")

shaw17 <- areal::aw_interpolate(shaw, tid = NHD_NUM, source = tract17, sid = GEOID, 
                      weight = "total", output = "tibble", extensive = "estimate")

rm(tract15, tract16, tract17)
```

``` r
murder_2015 <- filter(vc_2015, crimeCat == "Homicide")
murder_2016 <- filter(vc_2016, crimeCat == "Homicide")
murder_2017 <- filter(vc_2017, crimeCat == "Homicide")
murder_2018 <- filter(vc_2018, crimeCat == "Homicide")

murder_2015_shaw <- filter(vc_2015_shaw, crimeCat == "Homicide")
murder_2016_shaw <- filter(vc_2016_shaw, crimeCat == "Homicide")
murder_2017_shaw <- filter(vc_2017_shaw, crimeCat == "Homicide")
murder_2018_shaw <- filter(vc_2018_shaw, crimeCat == "Homicide")
```

``` r
cityCrime <- data.frame(
  year = c(2015, 2016, 2017, 2018),
  pop = c(cityPop$estimate[1], cityPop$estimate[2], cityPop$estimate[3], cityPop$estimate[3]),
  homicideCount = c(nrow(murder_2015), nrow(murder_2016), nrow(murder_2017), nrow(murder_2018)),
  vcCount = c(nrow(vc_2015), nrow(vc_2016), nrow(vc_2017), nrow(vc_2018)),
  p1Count = c(nrow(p1_2015), nrow(p1_2016), nrow(p1_2017), nrow(p1_2018)),
  stringsAsFactors = FALSE
)

cityCrime %>%
  mutate(city_homicideRate = (homicideCount/pop)*100000) %>%
  mutate(city_vcRate = (vcCount/pop)*100000) %>%
  mutate(city_p1Rate = (p1Count/pop)*100000) -> cityCrime

shawCrime <- data.frame(
  year = c(2015, 2016, 2017, 2018),
  pop = c(shaw15$estimate, shaw16$estimate, shaw17$estimate, shaw17$estimate),
  homicideCount = c(nrow(murder_2015_shaw), nrow(murder_2016_shaw), nrow(murder_2017_shaw), nrow(murder_2018_shaw)),
  vcCount = c(nrow(vc_2015_shaw), nrow(vc_2016_shaw), nrow(vc_2017_shaw), nrow(vc_2018_shaw)),
  p1Count = c(nrow(p1_2015_shaw), nrow(p1_2016_shaw), nrow(p1_2017_shaw), nrow(p1_2018_shaw)),
  stringsAsFactors = FALSE
)

shawCrime %>%
  mutate(homicideRate = (homicideCount/pop)*100000) %>%
  mutate(vcRate = (vcCount/pop)*100000) %>%
  mutate(p1Rate = (p1Count/pop)*100000) %>%
  mutate(homicideRateS = (homicideCount/pop)*1000) %>%
  mutate(vcRateS = (vcCount/pop)*1000) %>%
  mutate(p1RateS = (p1Count/pop)*1000) -> shawCrime

cityCrime %>%
  select(year, city_homicideRate, city_vcRate, city_p1Rate) %>%
  left_join(shawCrime, ., by = "year") %>%
  mutate(homicideRatio = homicideRate/city_homicideRate) %>%
  mutate(vcRatio = vcRate/city_vcRate) %>%
  mutate(p1Ratio = p1Rate/city_p1Rate) %>%
  select(year, pop, 
         homicideCount, homicideRateS, homicideRate, city_homicideRate, homicideRatio, 
         vcCount, vcRateS, vcRate, city_vcRate, vcRatio, 
         p1Count, p1RateS, p1Rate, city_p1Rate, p1Ratio) -> shawCrime

write_csv(shawCrime, path = here("data", "clean", "shawCrime.csv"))
```
