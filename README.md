
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

## Reading datavolley files

This `dv_readXtra` is a function to read datavolley files with
additional columns. Add as many files as you want so long as you have
the correct path.

``` r
library(datavolleyXtra)
#> Loading required package: magrittr
df <- dv_readXtra('.')
#> Joining with `by = join_by(team, player_name)`
#> Joining with `by = join_by(team, player_name)`
df %>% head()
#>                           match_id point_id time video_file_number video_time
#> 1 307d64cb54979154942ca34098e942a9        0 <NA>                 1       1192
#> 2 307d64cb54979154942ca34098e942a9        0 <NA>                 1       1192
#> 3 307d64cb54979154942ca34098e942a9        0 <NA>                 1       1192
#> 4 307d64cb54979154942ca34098e942a9        0 <NA>                 1       1192
#> 5 307d64cb54979154942ca34098e942a9        0 <NA>                 1       1192
#> 6 307d64cb54979154942ca34098e942a9        0 <NA>                 1       1193
#>                 code                           team player_number   player_name
#> 1           *P01>LUp University of Nebraska-Lincoln            NA          <NA>
#> 2            *z1>LUp University of Nebraska-Lincoln            NA          <NA>
#> 3           aP21>LUp          University of Florida            NA          <NA>
#> 4            az6>LUp          University of Florida            NA          <NA>
#> 5  *01SM!~~~11C~~~00 University of Nebraska-Lincoln             1 Hames Nicklin
#> 6 a07RM!~~~11CR~~00B          University of Florida             7 Paige Hammons
#>   player_id     skill                 skill_type evaluation_code
#> 1      <NA>      <NA>                       <NA>            <NA>
#> 2      <NA>      <NA>                       <NA>            <NA>
#> 3      <NA>      <NA>                       <NA>            <NA>
#> 4      <NA>      <NA>                       <NA>            <NA>
#> 5   -189031     Serve           Jump-float serve               !
#> 6    -70607 Reception Jump-float serve reception               !
#>                    evaluation attack_code attack_description set_code
#> 1                        <NA>        <NA>               <NA>     <NA>
#> 2                        <NA>        <NA>               <NA>     <NA>
#> 3                        <NA>        <NA>               <NA>     <NA>
#> 4                        <NA>        <NA>               <NA>     <NA>
#> 5 OK, no first tempo possible        <NA>               <NA>     <NA>
#> 6 OK, no first tempo possible        <NA>               <NA>     <NA>
#>   set_description set_type start_zone end_zone end_subzone end_cone
#> 1            <NA>     <NA>         NA       NA        <NA>       NA
#> 2            <NA>     <NA>         NA       NA        <NA>       NA
#> 3            <NA>     <NA>         NA       NA        <NA>       NA
#> 4            <NA>     <NA>         NA       NA        <NA>       NA
#> 5            <NA>     <NA>          1        1           C       NA
#> 6            <NA>     <NA>          1        1           C       NA
#>   skill_subtype num_players num_players_numeric special_code timeout end_of_set
#> 1          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 2          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 3          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 4          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 5          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 6      On right        <NA>                  NA         <NA>   FALSE      FALSE
#>   substitution point home_team_score visiting_team_score home_setter_position
#> 1        FALSE FALSE               1                   0                   NA
#> 2        FALSE FALSE               1                   0                    1
#> 3        FALSE FALSE               1                   0                    1
#> 4        FALSE FALSE               1                   0                    1
#> 5        FALSE FALSE               1                   0                    1
#> 6        FALSE FALSE               1                   0                    1
#>   visiting_setter_position custom_code file_line_number home_p1 home_p2 home_p3
#> 1                       NA                          110       1       2      25
#> 2                       NA                          111       1       2      25
#> 3                       NA                          112       1       2      25
#> 4                        6                          113       1       2      25
#> 5                        6          00              114       1       2      25
#> 6                        6         00B              115       1       2      25
#>   home_p4 home_p5 home_p6 visiting_p1 visiting_p2 visiting_p3 visiting_p4
#> 1      12       3      26           7          10           9          20
#> 2      12       3      26           7          10           9          20
#> 3      12       3      26           7          10           9          20
#> 4      12       3      26           7          10           9          20
#> 5      12       3      26           7          10           9          20
#> 6      12       3      26           7          10           9          20
#>   visiting_p5 visiting_p6 start_coordinate mid_coordinate end_coordinate
#> 1           5          21               NA             NA             NA
#> 2           5          21               NA             NA             NA
#> 3           5          21               NA             NA             NA
#> 4           5          21               NA             NA             NA
#> 5           5          21              278             NA           8123
#> 6           5          21              278             NA           8123
#>   point_phase attack_phase start_coordinate_x start_coordinate_y
#> 1        <NA>         <NA>                 NA                 NA
#> 2        <NA>         <NA>                 NA                 NA
#> 3        <NA>         <NA>                 NA                 NA
#> 4        <NA>         <NA>                 NA                 NA
#> 5        <NA>         <NA>            3.03125        -0.05555556
#> 6        <NA>         <NA>            3.03125        -0.05555556
#>   mid_coordinate_x mid_coordinate_y end_coordinate_x end_coordinate_y
#> 1               NA               NA               NA               NA
#> 2               NA               NA               NA               NA
#> 3               NA               NA               NA               NA
#> 4               NA               NA               NA               NA
#> 5               NA               NA          0.96875         5.796296
#> 6               NA               NA          0.96875         5.796296
#>   home_player_id1 home_player_id2 home_player_id3 home_player_id4
#> 1         -189031         -121447         -220743          -65299
#> 2         -189031         -121447         -220743          -65299
#> 3         -189031         -121447         -220743          -65299
#> 4         -189031         -121447         -220743          -65299
#> 5         -189031         -121447         -220743          -65299
#> 6         -189031         -121447         -220743          -65299
#>   home_player_id5 home_player_id6 visiting_player_id1 visiting_player_id2
#> 1         -220746           15396              -70607                3607
#> 2         -220746           15396              -70607                3607
#> 3         -220746           15396              -70607                3607
#> 4         -220746           15396              -70607                3607
#> 5         -220746           15396              -70607                3607
#> 6         -220746           15396              -70607                3607
#>   visiting_player_id3 visiting_player_id4 visiting_player_id5
#> 1               15094             -229906               15092
#> 2               15094             -229906               15092
#> 3               15094             -229906               15092
#> 4               15094             -229906               15092
#> 5               15094             -229906               15092
#> 6               15094             -229906               15092
#>   visiting_player_id6 set_number team_touch_id                      home_team
#> 1             -231062          1             0 University of Nebraska-Lincoln
#> 2             -231062          1             0 University of Nebraska-Lincoln
#> 3             -231062          1             1 University of Nebraska-Lincoln
#> 4             -231062          1             1 University of Nebraska-Lincoln
#> 5             -231062          1             2 University of Nebraska-Lincoln
#> 6             -231062          1             3 University of Nebraska-Lincoln
#>           visiting_team home_team_id visiting_team_id team_id
#> 1 University of Florida           98              280      98
#> 2 University of Florida           98              280      98
#> 3 University of Florida           98              280     280
#> 4 University of Florida           98              280     280
#> 5 University of Florida           98              280      98
#> 6 University of Florida           98              280     280
#>                     point_won_by winning_attack                   serving_team
#> 1 University of Nebraska-Lincoln          FALSE University of Nebraska-Lincoln
#> 2 University of Nebraska-Lincoln          FALSE University of Nebraska-Lincoln
#> 3 University of Nebraska-Lincoln          FALSE University of Nebraska-Lincoln
#> 4 University of Nebraska-Lincoln          FALSE University of Nebraska-Lincoln
#> 5 University of Nebraska-Lincoln          FALSE University of Nebraska-Lincoln
#> 6 University of Nebraska-Lincoln          FALSE University of Nebraska-Lincoln
#>       phase home_score_start_of_point visiting_score_start_of_point
#> 1      <NA>                         0                             0
#> 2      <NA>                         0                             0
#> 3      <NA>                         0                             0
#> 4      <NA>                         0                             0
#> 5     Serve                         0                             0
#> 6 Reception                         0                             0
#>                           filename       date        receiving_team
#> 1 &2018-08-24 58911 UNL-UF(VM).dvw 2018-08-24 University of Florida
#> 2 &2018-08-24 58911 UNL-UF(VM).dvw 2018-08-24 University of Florida
#> 3 &2018-08-24 58911 UNL-UF(VM).dvw 2018-08-24 University of Florida
#> 4 &2018-08-24 58911 UNL-UF(VM).dvw 2018-08-24 University of Florida
#> 5 &2018-08-24 58911 UNL-UF(VM).dvw 2018-08-24 University of Florida
#> 6 &2018-08-24 58911 UNL-UF(VM).dvw 2018-08-24 University of Florida
#>   receiving_team_id            set_won_by home_sets_won visiting_sets_won
#> 1               280 University of Florida             1                 3
#> 2               280 University of Florida             1                 3
#> 3               280 University of Florida             1                 3
#> 4               280 University of Florida             1                 3
#> 5               280 University of Florida             1                 3
#> 6               280 University of Florida             1                 3
#>            match_won_by set_won_by_id team_won_set match_won_by_id
#> 1 University of Florida           280        FALSE             280
#> 2 University of Florida           280        FALSE             280
#> 3 University of Florida           280         TRUE             280
#> 4 University of Florida           280         TRUE             280
#> 5 University of Florida           280        FALSE             280
#> 6 University of Florida           280         TRUE             280
#>   team_won_match home_setter_id visiting_setter_id setter_id
#> 1              0           <NA>               <NA>      <NA>
#> 2              0        -189031               <NA>   -189031
#> 3              1        -189031               <NA>      <NA>
#> 4              1        -189031            -231062   -231062
#> 5              0        -189031            -231062   -189031
#> 6              1        -189031            -231062   -231062
#>       setter_position setter_front_back                       opponent sets_won
#> 1                <NA>              <NA>          University of Florida        1
#> 2 Rotation 1 (S in 1)              back          University of Florida        1
#> 3                <NA>              <NA> University of Nebraska-Lincoln        3
#> 4 Rotation 2 (S in 6)              back University of Nebraska-Lincoln        3
#> 5 Rotation 1 (S in 1)              back          University of Florida        1
#> 6 Rotation 2 (S in 6)              back University of Nebraska-Lincoln        3
#>   match_won position
#> 1         1     <NA>
#> 2         1     <NA>
#> 3         1     <NA>
#> 4         1     <NA>
#> 5         1        S
#> 6         1       OH
```

## Get NCAA Women’s Volleyball schedules

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
get_team_schedule(team_name = 'Yale', team_id = '813', yr = 2019)
#> # A tibble: 23 × 5
#>    url                                  date                home  away  location
#>    <chr>                                <dttm>              <chr> <chr> <chr>   
#>  1 https://stats.ncaa.org/contests/175… 2019-09-06 00:00:00 Okla… Yale  Bloomin…
#>  2 https://stats.ncaa.org/contests/175… 2019-09-06 00:00:00 Oreg… Yale  Bloomin…
#>  3 https://stats.ncaa.org/contests/175… 2019-09-08 00:00:00 Indi… Yale  Indiana 
#>  4 https://stats.ncaa.org/contests/175… 2019-09-13 00:00:00 Vill… Yale  Los Ang…
#>  5 https://stats.ncaa.org/contests/175… 2019-09-13 00:00:00 Sout… Yale  Souther…
#>  6 https://stats.ncaa.org/contests/176… 2019-09-14 00:00:00 Howa… Yale  Los Ang…
#>  7 https://stats.ncaa.org/contests/176… 2019-09-20 00:00:00 Yale  Ston… Yale    
#>  8 https://stats.ncaa.org/contests/176… 2019-09-21 00:00:00 Yale  Army… Yale    
#>  9 https://stats.ncaa.org/contests/176… 2019-09-21 00:00:00 Yale  Sacr… Yale    
#> 10 https://stats.ncaa.org/contests/176… 2019-09-28 00:00:00 Yale  Brown Yale    
#> # ℹ 13 more rows
```

Or get a conference of NCAA womens matches

``` r
get_conf_schedule(conf_name = 'Big Ten', yr = 2022)
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
