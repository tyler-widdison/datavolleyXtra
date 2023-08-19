
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

This `dv_readXtra` is meant to provide a bit of a lazier way of reading
dvw files. Add as many files as you want so long as you have the correct
path.

``` r
library(datavolleyXtra)
#> Loading required package: magrittr
df <- dv_readXtra("dvws")
#> Joining with `by = join_by(team, player_name)`
#> Joining with `by = join_by(team, player_name)`
#> Joining with `by = join_by(team, player_name)`
```

------------------------------------------------------------------------

#### Additions

- set_player

- Player

- opponent

- reception_quality

- dig_quality

- setter_position

- filename

- date

- \+ more!

------------------------------------------------------------------------

## Return reception table

``` r
rec_table(df, 'Rutgers')
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>
Reception by Rotation
</caption>
<thead>
<tr>
<th style="text-align:left;">
Player
</th>
<th style="text-align:right;">
Att
</th>
<th style="text-align:left;">
SO%
</th>
<th style="text-align:right;">
Index
</th>
<th style="text-align:left;">
ER%
</th>
</tr>
</thead>
<tbody>
<tr grouplength="2">
<td colspan="5" style="border-bottom: 1px solid;">
<strong>Rotation 1 (S in 1)</strong>
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
01 - Kojadinovic
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
25.0%
</td>
<td style="text-align:right;">
2.25
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
05 - Fletcher
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
30.8%
</td>
<td style="text-align:right;">
2.81
</td>
<td style="text-align:left;">
7.7%
</td>
</tr>
<tr grouplength="3">
<td colspan="5" style="border-bottom: 1px solid;">
<strong>Rotation 2 (S in 6)</strong>
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
03 - McLetchie
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
0.0%
</td>
<td style="text-align:right;">
1.90
</td>
<td style="text-align:left;">
20.0%
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
15 - Swackenberg
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
20.0%
</td>
<td style="text-align:right;">
0.80
</td>
<td style="text-align:left;">
40.0%
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
16 - Hill
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
50.0%
</td>
<td style="text-align:right;">
1.50
</td>
<td style="text-align:left;">
16.7%
</td>
</tr>
<tr grouplength="1">
<td colspan="5" style="border-bottom: 1px solid;">
<strong>Rotation 4 (S in 4)</strong>
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
16 - Hill
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
33.3%
</td>
<td style="text-align:right;">
1.67
</td>
<td style="text-align:left;">
11.1%
</td>
</tr>
<tr grouplength="2">
<td colspan="5" style="border-bottom: 1px solid;">
<strong>Rotation 5 (S in 3)</strong>
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
05 - Fletcher
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
42.9%
</td>
<td style="text-align:right;">
2.29
</td>
<td style="text-align:left;">
14.3%
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
17 - Cieslik
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
20.0%
</td>
<td style="text-align:right;">
2.40
</td>
<td style="text-align:left;">
20.0%
</td>
</tr>
<tr grouplength="3">
<td colspan="5" style="border-bottom: 1px solid;">
<strong>Rotation 6 (S in 2)</strong>
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
04 - Kamshilina
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
25.0%
</td>
<td style="text-align:right;">
2.00
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
05 - Fletcher
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
66.7%
</td>
<td style="text-align:right;">
2.75
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
17 - Cieslik
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
0.0%
</td>
<td style="text-align:right;">
3.00
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr grouplength="1">
<td colspan="5" style="border-bottom: 1px solid;">
<strong>Rutgers</strong>
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">

- </td>
  <td style="text-align:right;">
  93
  </td>
  <td style="text-align:left;">
  36.6%
  </td>
  <td style="text-align:right;">
  2.13
  </td>
  <td style="text-align:left;">
  12.9%
  </td>
  </tr>
  </tbody>
  </table>
