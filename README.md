
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
df <- dv_readXtra("dvws")
#> Joining with `by = join_by(team, player_name)`
#> Joining with `by = join_by(team, player_name)`
#> Joining with `by = join_by(team, player_name)`
df %>% head()
#>                           match_id point_id time video_file_number video_time
#> 1 bfd71791e6a0dfb9116192a5851d0879        0 <NA>                 1        685
#> 2 bfd71791e6a0dfb9116192a5851d0879        0 <NA>                 1        685
#> 3 bfd71791e6a0dfb9116192a5851d0879        0 <NA>                 1        685
#> 4 bfd71791e6a0dfb9116192a5851d0879        0 <NA>                 1        685
#> 5 bfd71791e6a0dfb9116192a5851d0879        0 <NA>                 1        685
#> 6 bfd71791e6a0dfb9116192a5851d0879        0 <NA>                 1        686
#>                 code                    team player_number     player_name
#> 1           aP01>LUp Wright State University            NA            <NA>
#> 2            az1>LUp Wright State University            NA            <NA>
#> 3           *P07>LUp      University of Iowa            NA            <NA>
#> 4            *z2>LUp      University of Iowa            NA            <NA>
#> 5  a01ST-~~~16C~~~00 Wright State University             1 Maddie Lohmeier
#> 6 *05RT#~~~16CW~~00B      University of Iowa             5 Meghan Buzzerio
#>   player_id     skill              skill_type evaluation_code
#> 1      <NA>      <NA>                    <NA>            <NA>
#> 2      <NA>      <NA>                    <NA>            <NA>
#> 3      <NA>      <NA>                    <NA>            <NA>
#> 4      <NA>      <NA>                    <NA>            <NA>
#> 5      5033     Serve           Topspin serve               -
#> 6    -11992 Reception Topspin serve reception               #
#>                       evaluation attack_code attack_description set_code
#> 1                           <NA>        <NA>               <NA>     <NA>
#> 2                           <NA>        <NA>               <NA>     <NA>
#> 3                           <NA>        <NA>               <NA>     <NA>
#> 4                           <NA>        <NA>               <NA>     <NA>
#> 5 Negative, opponent free attack        <NA>               <NA>     <NA>
#> 6                   Perfect pass        <NA>               <NA>     <NA>
#>   set_description set_type start_zone end_zone end_subzone end_cone
#> 1            <NA>     <NA>         NA       NA        <NA>       NA
#> 2            <NA>     <NA>         NA       NA        <NA>       NA
#> 3            <NA>     <NA>         NA       NA        <NA>       NA
#> 4            <NA>     <NA>         NA       NA        <NA>       NA
#> 5            <NA>     <NA>          1        6           C       NA
#> 6            <NA>     <NA>          1        6           C       NA
#>   skill_subtype num_players num_players_numeric special_code timeout end_of_set
#> 1          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 2          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 3          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 4          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 5          <NA>        <NA>                  NA         <NA>   FALSE      FALSE
#> 6           Low        <NA>                  NA         <NA>   FALSE      FALSE
#>   substitution point home_team_score visiting_team_score home_setter_position
#> 1        FALSE FALSE               1                   0                   NA
#> 2        FALSE FALSE               1                   0                   NA
#> 3        FALSE FALSE               1                   0                   NA
#> 4        FALSE FALSE               1                   0                    2
#> 5        FALSE FALSE               1                   0                    2
#> 6        FALSE FALSE               1                   0                    2
#>   visiting_setter_position custom_code file_line_number home_p1 home_p2 home_p3
#> 1                       NA                          108      29       7      16
#> 2                        1                          109      29       7      16
#> 3                        1                          110      29       7      16
#> 4                        1                          111      29       7      16
#> 5                        1          00              112      29       7      16
#> 6                        1         00B              113      29       7      16
#>   home_p4 home_p5 home_p6 visiting_p1 visiting_p2 visiting_p3 visiting_p4
#> 1       8       1       5           1           3           9          14
#> 2       8       1       5           1           3           9          14
#> 3       8       1       5           1           3           9          14
#> 4       8       1       5           1           3           9          14
#> 5       8       1       5           1           3           9          14
#> 6       8       1       5           1           3           9          14
#>   visiting_p5 visiting_p6 start_coordinate mid_coordinate end_coordinate
#> 1          12          10               NA             NA             NA
#> 2          12          10               NA             NA             NA
#> 3          12          10               NA             NA             NA
#> 4          12          10               NA             NA             NA
#> 5          12          10              582             NA           7860
#> 6          12          10              582             NA           7860
#>   point_phase attack_phase start_coordinate_x start_coordinate_y
#> 1        <NA>         <NA>                 NA                 NA
#> 2        <NA>         <NA>                 NA                 NA
#> 3        <NA>         <NA>                 NA                 NA
#> 4        <NA>         <NA>                 NA                 NA
#> 5        <NA>         <NA>            3.18125          0.1666667
#> 6        <NA>         <NA>            3.18125          0.1666667
#>   mid_coordinate_x mid_coordinate_y end_coordinate_x end_coordinate_y
#> 1               NA               NA               NA               NA
#> 2               NA               NA               NA               NA
#> 3               NA               NA               NA               NA
#> 4               NA               NA               NA               NA
#> 5               NA               NA          2.35625         5.574074
#> 6               NA               NA          2.35625         5.574074
#>   home_player_id1 home_player_id2 home_player_id3 home_player_id4
#> 1           -2306          -49732          -66705           -2299
#> 2           -2306          -49732          -66705           -2299
#> 3           -2306          -49732          -66705           -2299
#> 4           -2306          -49732          -66705           -2299
#> 5           -2306          -49732          -66705           -2299
#> 6           -2306          -49732          -66705           -2299
#>   home_player_id5 home_player_id6 visiting_player_id1 visiting_player_id2
#> 1           -2303          -11992                5033                5035
#> 2           -2303          -11992                5033                5035
#> 3           -2303          -11992                5033                5035
#> 4           -2303          -11992                5033                5035
#> 5           -2303          -11992                5033                5035
#> 6           -2303          -11992                5033                5035
#>   visiting_player_id3 visiting_player_id4 visiting_player_id5
#> 1                5041                5046                5044
#> 2                5041                5046                5044
#> 3                5041                5046                5044
#> 4                5041                5046                5044
#> 5                5041                5046                5044
#> 6                5041                5046                5044
#>   visiting_player_id6 set_number team_touch_id          home_team
#> 1                5042          1             0 University of Iowa
#> 2                5042          1             0 University of Iowa
#> 3                5042          1             1 University of Iowa
#> 4                5042          1             1 University of Iowa
#> 5                5042          1             2 University of Iowa
#> 6                5042          1             3 University of Iowa
#>             visiting_team home_team_id visiting_team_id team_id
#> 1 Wright State University           96              158     158
#> 2 Wright State University           96              158     158
#> 3 Wright State University           96              158      96
#> 4 Wright State University           96              158      96
#> 5 Wright State University           96              158     158
#> 6 Wright State University           96              158      96
#>         point_won_by winning_attack            serving_team     phase
#> 1 University of Iowa          FALSE Wright State University      <NA>
#> 2 University of Iowa          FALSE Wright State University      <NA>
#> 3 University of Iowa          FALSE Wright State University      <NA>
#> 4 University of Iowa          FALSE Wright State University      <NA>
#> 5 University of Iowa          FALSE Wright State University     Serve
#> 6 University of Iowa          FALSE Wright State University Reception
#>   home_score_start_of_point visiting_score_start_of_point
#> 1                         0                             0
#> 2                         0                             0
#> 3                         0                             0
#> 4                         0                             0
#> 5                         0                             0
#> 6                         0                             0
#>                             filename       date     receiving_team
#> 1 &2017-08-25 20974 IOWA-WSU(VM).dvw 2017-08-25 University of Iowa
#> 2 &2017-08-25 20974 IOWA-WSU(VM).dvw 2017-08-25 University of Iowa
#> 3 &2017-08-25 20974 IOWA-WSU(VM).dvw 2017-08-25 University of Iowa
#> 4 &2017-08-25 20974 IOWA-WSU(VM).dvw 2017-08-25 University of Iowa
#> 5 &2017-08-25 20974 IOWA-WSU(VM).dvw 2017-08-25 University of Iowa
#> 6 &2017-08-25 20974 IOWA-WSU(VM).dvw 2017-08-25 University of Iowa
#>   receiving_team_id         set_won_by home_sets_won visiting_sets_won
#> 1                96 University of Iowa             3                 0
#> 2                96 University of Iowa             3                 0
#> 3                96 University of Iowa             3                 0
#> 4                96 University of Iowa             3                 0
#> 5                96 University of Iowa             3                 0
#> 6                96 University of Iowa             3                 0
#>         match_won_by set_won_by_id team_won_set match_won_by_id team_won_match
#> 1 University of Iowa            96        FALSE              96              0
#> 2 University of Iowa            96        FALSE              96              0
#> 3 University of Iowa            96         TRUE              96              1
#> 4 University of Iowa            96         TRUE              96              1
#> 5 University of Iowa            96        FALSE              96              0
#> 6 University of Iowa            96         TRUE              96              1
#>   home_setter_id visiting_setter_id setter_id     setter_position
#> 1           <NA>               <NA>      <NA>                <NA>
#> 2           <NA>               5033      5033 Rotation 1 (S in 1)
#> 3           <NA>               5033      <NA>                <NA>
#> 4         -49732               5033    -49732 Rotation 6 (S in 2)
#> 5         -49732               5033      5033 Rotation 1 (S in 1)
#> 6         -49732               5033    -49732 Rotation 6 (S in 2)
#>   setter_front_back                opponent sets_won match_won team_score
#> 1              <NA>      University of Iowa        0         0          0
#> 2              back      University of Iowa        0         0          0
#> 3              <NA> Wright State University        3         1          1
#> 4             front Wright State University        3         1          1
#> 5              back      University of Iowa        0         0          0
#> 6             front Wright State University        3         1          1
#>   opp_score last_name       Player
#> 1         1        NA      NA - NA
#> 2         1        NA      NA - NA
#> 3         0        NA      NA - NA
#> 4         0        NA      NA - NA
#> 5         1  Lohmeier 1 - Lohmeier
#> 6         0  Buzzerio 5 - Buzzerio
#>                                                      Match position
#> 1 2017-08-25-Wright State University vs University of Iowa     <NA>
#> 2 2017-08-25-Wright State University vs University of Iowa     <NA>
#> 3 2017-08-25-University of Iowa vs Wright State University     <NA>
#> 4 2017-08-25-University of Iowa vs Wright State University     <NA>
#> 5 2017-08-25-Wright State University vs University of Iowa        S
#> 6 2017-08-25-University of Iowa vs Wright State University       OH
```

Return a reception data table:

`rec_table(df, 'Iowa', 3)`

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

Get NCAA womens team or conference schedule

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
