
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

## Get NCAA Women’s Volleyball schedules

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

Get NCAA womens team schedule

``` r
get_team_schedule('Yale', 813, 2019)
#> # A tibble: 24 × 5
#>    url                                  date                home  away  location
#>    <chr>                                <dttm>              <chr> <chr> <chr>   
#>  1 https://stats.ncaa.org/contests/154… 2018-08-31 00:00:00 Yale  Fair… Yale    
#>  2 https://stats.ncaa.org/contests/154… 2018-09-01 00:00:00 Yale  Cent… Yale    
#>  3 https://stats.ncaa.org/contests/154… 2018-09-01 00:00:00 Yale  Quin… Yale    
#>  4 https://stats.ncaa.org/contests/154… 2018-09-07 00:00:00 Army… Yale  Kingsto…
#>  5 https://stats.ncaa.org/contests/154… 2018-09-08 00:00:00 New … Yale  Kingsto…
#>  6 https://stats.ncaa.org/contests/154… 2018-09-08 00:00:00 Rhod… Yale  Rhode I…
#>  7 https://stats.ncaa.org/contests/154… 2018-09-14 00:00:00 Alab… Yale  Orlando…
#>  8 https://stats.ncaa.org/contests/154… 2018-09-14 00:00:00 FGCU  Yale  Orlando…
#>  9 https://stats.ncaa.org/contests/154… 2018-09-15 00:00:00 UCF   Yale  UCF     
#> 10 https://stats.ncaa.org/contests/154… 2018-09-22 00:00:00 Brown Yale  Brown   
#> # ℹ 14 more rows
```

Or get a conference of NCAA womens matches

``` r
get_conf_schedule('Big Ten', 2023)
#> # A tibble: 303 × 5
#>    url                                  date                home  away  location
#>    <chr>                                <dttm>              <chr> <chr> <chr>   
#>  1 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Indi… Indi… Indiana 
#>  2 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Gonz… Iowa  Norman,…
#>  3 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 FIU   Iowa  Norman,…
#>  4 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Mary… Rhod… Maryland
#>  5 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Mary… Navy  Maryland
#>  6 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Old … Mich… Flagsta…
#>  7 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Nort… Mich… Norther…
#>  8 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Mich… Loui… Michiga…
#>  9 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Bayl… Minn… Fort Wo…
#> 10 https://stats.ncaa.org/contests/229… 2022-08-26 00:00:00 Nebr… A&M-… Nebraska
#> # ℹ 293 more rows
```
