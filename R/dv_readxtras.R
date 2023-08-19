#' Return datavolley plays object with added columns
#'
#' @references \url{https://github.com/openvolley/datavolley}
#' @param: dvw directory
#'
#' @return data.frame: the plays component of a datavolley object, as returned by \code{dv_read()} In addition to plays, it also returns the following: filename, date, receiving_team, receiving_team_id, set_won_by, home_sets_won, visiting_sets_won, match_won_by, set_won_by_id, team_won_set, match_won_by_id, team_won_match, home_setter_id, visting_setter_id, setter_id, setter_position, setter_front_back, opponent, sets_won, match_won, position, reception_quality, set_player
#'
#' @examples
#' \dontrun{
#'   dv_readXtra("dvws")
#'   }
#' @export
dv_readXtra <- function(d = getwd()) {
  if (file.info(d)$isdir) {
    lx <- lapply(
      dir(d, pattern = "dvw$", full.names = TRUE),
      function(filename) {
        tryCatch(
          datavolley::dv_read(filename, insert_technical_timeouts = FALSE),
          error = function(e) {
            message(paste0("Error reading file ", filename, ": ", e$message))
            return(NULL)
          }
        )
      }
    )
  } else {
    lx <- tryCatch(
      datavolley::dv_read(d, insert_technical_timeouts = FALSE),
      error = function(e) {
        message(paste0("Error reading file ", d, ": ", e$message))
        return(NULL)
      }
    )
  }

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
    # Get rallys within a point
    rallys <- out %>%
      dplyr::mutate(x = dplyr::row_number()) %>%
      dplyr::filter(skill == 'Attack') %>%
      dplyr::group_by(match_id, point_id) %>%
      dplyr::mutate(rally_id = seq_along(point_id)) %>%
      dplyr::ungroup() %>%
      dplyr::distinct(x, rally_id)
    # Add rally no to data
    out <- out %>%
      dplyr::mutate(x = dplyr::row_number()) %>%
      dplyr::left_join(rallys) %>%
      tidyr::fill(rally_id, .direction = 'up') %>%
      dplyr::select(-x)
    # Add reception quality to each point_id
    rq <- out %>% dplyr::filter(skill == "Reception") %>% dplyr::group_by(match_id, point_id) %>%
      dplyr::summarise(reception_quality = if (dplyr::n() == 1) .data$evaluation_code else NA_character_) %>% dplyr::ungroup() #https://snippets.openvolley.org/data-augmentation.html
    # Add dig quality to each rally_id inside a point_id
    dq <- out %>% dplyr::filter(skill == "Dig") %>% dplyr::group_by(match_id, point_id, rally_id) %>%
      dplyr::summarise(dig_quality = if (dplyr::n() == 1) .data$evaluation_code else NA_character_) %>% dplyr::ungroup()
    # Add dig quality to each rally_id inside a point_id
    aq <- out %>% dplyr::filter(skill == "Attack") %>% dplyr::group_by(match_id, point_id, rally_id) %>%
      dplyr::summarise(attack_quality = if (dplyr::n() == 1) .data$evaluation_code else NA_character_) %>% dplyr::ungroup()

    # Join back to data
    out <- out %>% dplyr::left_join(rq, by = c("match_id", "point_id")) %>% dplyr::left_join(dq, by = c("match_id", "point_id", "rally_id")) %>% dplyr::left_join(aq, by = c("match_id", "point_id", "rally_id"))
    # Add a few more columns
    out <- out %>%
      dplyr::mutate(# Return the opponent team
                    opponent = dplyr::case_when(team == home_team ~ visiting_team, team == visiting_team ~ home_team),
                    # Return the number of sets won by a team
                    sets_won = ifelse(home_team == team, home_sets_won, visiting_sets_won),
                    # Return if a team won a match
                    match_won = ifelse(home_team == team | visiting_team == team & team_won_match == T, 1, 0),
                    team_won_match = ifelse(team_won_match == T, 1, 0),
                    # Return a teams score
                    team_score = ifelse(team_id == home_team_id, home_team_score, visiting_team_score),
                    # Return the opponents score
                    opp_score = ifelse(team_id == visiting_team_id, home_team_score, visiting_team_score),
                    # Change type of setter position
                    setter_position = as.character(setter_position),
                    # Create column for easy rotation interpretation
                    setter_position = dplyr::case_when(
                    setter_position == '1' ~ 'Rotation 1 (S in 1)',
                    setter_position == '6' ~ 'Rotation 2 (S in 6)',
                    setter_position == '5' ~ 'Rotation 3 (S in 5)',
                    setter_position == '4' ~ 'Rotation 4 (S in 4)',
                    setter_position == '3' ~ 'Rotation 5 (S in 3)',
                    setter_position == '2' ~ 'Rotation 6 (S in 2)',
                    TRUE ~ setter_position),
                    # Create a column for player last name info
                    Player = sprintf("%02d - %s", player_number, stringr::word(player_name, -1)),
                    # Create a column with easy match information
                    Match = paste0(date, "-", team, " vs ", opponent),
                    # Return the player which set the ball
                    set_player = dplyr::case_when(skill == 'Attack' & lag(skill) == 'Set' & team == lag(team) ~ lag(player_name))
                    )

    # function to add player positions
    playerFunction <- function(data) {
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

  out <- playerFunction(out)
  # Return the data to px
  return(out)
  }))
}
