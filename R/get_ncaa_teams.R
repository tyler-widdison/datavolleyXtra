#' Return datavolley plays object with added columns
#'
#' @references \url{https://github.com/openvolley/datavolley}
#' @param d: dvw file path, run ('.') if local
#'
#' @return dv_readExtra data.frame: the plays component of a datavolley object, as returned by \code{dv_read()} In addition to plays, it also returns the following: filename, date (possible it could be incorrect), receiving_team, receiving_team_id, set_won_by, home_sets_won, visiting_sets_won, match_won_by, set_won_by_id, team_won_set, match_won_by_id, team_won_match, home_setter_id, visting_setter_id, setter_id, setter_position, setter_front_back, opponent, sets_won, match_won, position
#'
#' @examples
#' /dontrun{
#'   dv_readExtra(datavolley::dv_example_file())
#'   }
#'
#' @export
#'

library(httr)
library(rvest)
library(stringr)
library(dplyr)

get_ncaaw_teams <- function(){
  # get all the team names and corresponding IDs from the NCAA website

  # Step 1: get the giant character vector that matches teams and id
  url <- "https://stats.ncaa.org/team/search"
  all_teams_messy <- rvest::read_html(url) %>%
    rvest::html_node("body") %>%
    rvest::html_text()

  # Step 2: split the character vector
  all_teams_matrix <- stringr::str_split(all_teams_messy, ",") %>%
    unlist() %>%
    matrix(ncol = 4, byrow = T)

  teams_and_conferences <- stringr::str_split_fixed(all_teams_matrix[,3], " - ", 2)

  team_names <- stringr::str_remove_all(teams_and_conferences[,1], '\\"label\\"\\:\\"') %>%
    stringr::str_remove_all('\\[') %>%
    stringr::str_replace_all('\\\\u0026', '&')

  team_conferences <- stringr::str_remove_all(teams_and_conferences[,2], '\\"')
  team_ids <- stringr::str_extract(all_teams_matrix[,2], "\\d+")

  # Step 3: reconstitute the teams/ids as a tibble
  teams_df <- tibble(
    Name = team_names,
    Conference = team_conferences,
    ID = team_ids
  )

  return(teams_df)
}


#get_team_future_schedule <- function(team_name, team_id, year){
#
#  # This function is to get all of the games a team has played that the NCAA website lists, whether or not there are results
#  # This is good for getting the future games in the current year,
#  # or games for sports that the NCAA website doesn't link to box scores (e.g., water polo)
#  # team_name is the name of the team on the NCAA website
#  # team_id is the id of the team on the NCAA website
#  # generally we get team_name and team_id from the team_mapping() function
#  # sport is the name of the sport as written on the NCAA website
#  # year is the academic year; note that for fall sports you need to add 1 to the sport year
#
#  url <- paste0("https://stats.ncaa.org/team/", team_id)
#
#  schedule_links <- read_html(url) %>% html_nodes("a")
#
#  schedule_link_detect <- html_text(schedule_links) %>% str_detect('Volleyball')
#
#  schedule_link <- html_attr(schedule_links, "href")[schedule_link_detect]
#
#  url2 <- paste0("https://stats.ncaa.org", schedule_link)[1]
#
#  if(is.numeric(year)){  # if year is numeric, have to convert to academic year
#    year <- paste0(year-1, "-", year %% 100)
#  }
#
#  if(!is.na(url2)){
#    year_options <- read_html(url2) %>% html_nodes("option")
#
#    year_detect <- html_text(year_options) %>% str_detect(year)
#
#    if(!any(year_detect)){
#      warning(paste("Cannot find the requested year.\nMake sure", team_name, "supported that sport in that year."))
#      url3 <- NA
#    } else {
#      year_link <- html_attr(year_options, "value")[year_detect]
#
#      url3 <- paste0("https://stats.ncaa.org/teams/", year_link)  # finally to the team
#    }
#
#  } else{
#    url3 <- NA
#  }
#
#  if(!is.na(url3)){
#    games <- read_html(url3) %>% html_nodes("table")
#
#    games_table <- games[2] %>% html_table() %>% .[[1]] %>% filter(nchar(Opponent) > 0)
#
#    if(nrow(games_table) == 0){
#      warning(paste0(team_name, " does not appear to have played any games in ", year, "."))
#      games_df <- NULL
#
#    } else {
#
#      games_df <- games_table %>%
#        mutate(Location = case_when(
#          !str_detect(Opponent, "\\@") ~ team_name,
#          str_detect(Opponent, "\\@ ") ~ str_trim(str_remove(Opponent, "\\@ ")),
#          str_detect(Opponent, "\\@(?=[^ ])") ~ str_trim(str_extract(Opponent, "\\@(?=[^ ]).*") %>% str_remove("\\@"))
#        ),
#        Opponent = case_when(
#          !str_detect(Opponent, "\\@") ~ str_trim(Opponent),
#          str_detect(Opponent, "\\@ ") ~ str_trim(str_remove(Opponent, "\\@ ")),
#          str_detect(Opponent, "\\@(?=[^ ])") ~ str_trim(str_remove(Opponent, "\\@(?=[^ ]).*"))
#        ),
#        Date = lubridate::parse_date_time(Date, orders = c("m/d/Y H:M p", "m/d/Y", "m/d/Y(H)"))
#        )
#
#      games_df <- games_df %>% mutate(Team = team_name,
#                                      Attendance = if_else(is.na(as.numeric(str_remove(Attendance, ","))), NA_real_, as.numeric(str_remove(Attendance, ",")))) %>%
#        select(Date, Team, Opponent, Result, Attendance, Location)
#
#    }
#
#  } else {
#    games_df <- NULL
#  }
#
#  return(games_df)
#}
