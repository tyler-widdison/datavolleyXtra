
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datavolleyXtra

<!-- badges: start -->
<!-- badges: end -->

datavolleyXtra is a supplementary to
<https://github.com/openvolley/datavolley>.

## Installation

You can install the development version of datavolleyXtra from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tyler-widdison/datavolleyXtra")
```

## Get NCAA Women Volleyball schedule

``` r
library(datavolleyXtra)
#> Loading required package: magrittr
```

Get the NCAA womens teams

``` r
get_ncaaw_teams()
#> # A tibble: 1,110 × 3
#>    Name               Conference                    ID   
#>    <chr>              <chr>                         <chr>
#>  1 1                  DI CA Test - Independent      2675 
#>  2 2                  DII CA Test - Independent     11361
#>  3 3                  DIII CA Test - Independent    30108
#>  4 A&M-Corpus Christi Southland                     26172
#>  5 AUM                Gulf South                    30093
#>  6 Abilene Christian  WAC                           2    
#>  7 Academy of Art     PacWest                       30123
#>  8 Adams St.          RMAC                          929  
#>  9 Adelphi            NE10                          3    
#> 10 Adrian             Michigan Intercol. Ath. Assn. 4    
#> # ℹ 1,100 more rows
```
