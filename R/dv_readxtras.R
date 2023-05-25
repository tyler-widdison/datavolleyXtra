#' Return datavolley plays object with added columns
#'
#' @references \url{https://github.com/openvolley/datavolley}
#' @param: dvw directory  path, run ('.') if local
#'
#' @return data.frame: the plays component of a datavolley object, as returned by \code{dv_read()} In addition to plays, it also returns the following: filename, date (possible it could be incorrect), receiving_team, receiving_team_id, set_won_by, home_sets_won, visiting_sets_won, match_won_by, set_won_by_id, team_won_set, match_won_by_id, team_won_match, home_setter_id, visting_setter_id, setter_id, setter_position, setter_front_back, opponent, sets_won, match_won, position
#'
#' @examples
#' \dontrun{
#'   dv_readXtra('.')
#'   }
#' @export
dv_readXtra <- function(d) {
  playerFunction <- function(data) {
    # function to add player positions
    positions <- data %>%
      dplyr::filter(skill == "Attack" | skill == "Dig" | skill == "Set") %>%
      dplyr::group_by(player_name, team) %>%
      dplyr::summarise(tot_att = dplyr::n(),
                       atk_att = sum(skill == "Attack"),
                       dig_att = sum(skill == "Dig"),
                       set_att = sum(skill == "Set"),
                       l_atk_att = sum(attack_code %in% c("X5", "V5", "X9"), na.rm = T),
                       r_atk_att = sum(attack_code %in% c("X6", "X4", "V6", "X3"), na.rm = T),
                       m_atk_att = sum(attack_code %in% c("X1", "X2", "XM", "XL", "CF", "CB", "X7"), na.rm = T),
                       s_atk_att = sum(attack_code == "PP", na.rm = T),
                       .groups = "drop") %>%
      dplyr::mutate(atk_att_p = atk_att / tot_att,
                    dig_att_p = dig_att / tot_att,
                    set_att_p = set_att / tot_att,
                    l_atk_p = l_atk_att / atk_att,
                    r_atk_p = r_atk_att / atk_att,
                    m_atk_p = m_atk_att / atk_att,
                    s_atk_p = s_atk_att / atk_att,
                    position = dplyr::case_when(
                      set_att_p > 0.60 ~ "S",
                      dig_att > 0.49 & dig_att > atk_att~ "DS/L",
                      atk_att_p > 0.20 & l_atk_p > r_atk_p ~ "OH",
                      atk_att_p > 0.20 & m_atk_p > 0.70 ~ "MB",
                      atk_att_p > 0.20 & r_atk_p > l_atk_p ~ "OPP"
                    ))

    data <- data %>%
      dplyr::left_join(positions) %>%
      dplyr::select(-c(tot_att:s_atk_p))
  }

  dir <- dir(d, pattern = "dvw$", full.names = TRUE)
  lx <- lapply(d, function(filename) {
    tryCatch(
      datavolley::dv_read(filename, insert_technical_timeouts = FALSE),
      error = function(e) {
        message(paste0("Error reading file ", filename, ": ", e$message))
        return(NULL)
      })
  })

  px <- do.call(rbind, lapply(lx, function(dv) {
    out <- datavolley::plays(dv)
    # For the lx[[1]]$meta$filename
    out$filename <- basename(dv$meta$filename)
    # For the lx[[1]]$meta$match$date
    out$date <- dv$meta$match$date
    # for the meta$more$referees
    out$referees <- dv$more$referees
    # Ovlytics
    out <- ovlytics::ov_augment_plays(out, to_add = c('winners', 'setters', 'receiving_team'))
    # Add a few more columns
    out <- out %>%
      dplyr::mutate(opponent = dplyr::case_when(team == home_team ~ visiting_team,team == visiting_team ~ home_team),
                    sets_won = ifelse(home_team == team, home_sets_won, visiting_sets_won),
                    match_won = ifelse(home_team == team | visiting_team == team & team_won_match == T, 1, 0),
        team_won_match = ifelse(team_won_match == T, 1, 0),
        team_score = ifelse(team_id == home_team_id, home_team_score, visiting_team_score),
        opp_score = ifelse(team_id == visiting_team_id, home_team_score, visiting_team_score),
        setter_position = as.character(setter_position),
        setter_position = dplyr::case_when(
          setter_position == '1' ~ 'Rotation 1 (S in 1)',
          setter_position == '6' ~ 'Rotation 2 (S in 6)',
          setter_position == '5' ~ 'Rotation 3 (S in 5)',
          setter_position == '4' ~ 'Rotation 4 (S in 4)',
          setter_position == '3' ~ 'Rotation 5 (S in 3)',
          setter_position == '2' ~ 'Rotation 6 (S in 2)',
          TRUE ~ setter_position)
        )

  out <- playerFunction(out)
  # Return the data to px
  return(out)
  }))
}
