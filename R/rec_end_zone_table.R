#' Return a reception table by end zone
#'
#' @param data: dataset
#' @param team_name: teamname desired in dataset. Can use short names, but will return other teams with smiliar short names IE 'Texas' will return multiple teams if more than one 'Texas' team exists
#' @author Tyler Widdison
#' @description
#' @importFrom dplyr filter mutate summarise group_by lead rename select n
#' @importFrom janitor adorn_totals
#' @importFrom purrr pluck
#' @importFrom scales percent
#' @importFrom kableExtra kable_styling pack_rows footnote kable
#' @importFrom stringr str_detect
#' @importFrom DT datatable formatPercentage formatStyle formatRound styleColorBar
#' @importFrom magrittr "%>%"
#' @export

#' @return team_name can be string partial. data table with simple reception statistics by rotation. Returns reception attempts > 3
#'
#' @examples
#' \dontrun{
#'   dv_readXtra(df, 'Rutgers')
#'   }
#' @export
rec_end_zone <- function(data, team_name) {
  tib <- df %>%
    mutate(nxt_nxt_skil = lead(skill,2),
           nxt_nxt_grade = lead(evaluation_code,2),
           nxt_nxt_team = lead(team,2),
           end_zone = ifelse(end_zone == 7, 5,
                             ifelse(end_zone == 9, 1,
                                    ifelse(end_zone == 8, 6, end_zone)))
    ) %>%
    filter(skill == 'Reception' & nxt_nxt_skil == 'Attack' & str_detect(team, team_name) & nxt_nxt_team == team & end_zone %in% c(1, 5, 6)) %>%
    group_by(setter_position, end_zone) %>%
    summarise(att = dplyr::n(),
              so = sum(point_won_by == team, na.rm = T),
              pp = sum(evaluation_code == '#'),
              gp = sum(evaluation_code == '+'),
              mp = sum(evaluation_code == '!'),
              np = sum(evaluation_code == '-'),
              op = sum(evaluation_code == '/'),
              er = sum(evaluation_code == '='),
              fbso_num = (sum(nxt_nxt_grade == '#', na.rm = T) - sum(nxt_nxt_grade %in% c('=', '/'), na.rm = T)),
              .groups = 'drop'
    ) %>%
    janitor::adorn_totals() %>%
    mutate(`Rec att` = att,
           `SO%` = scales::percent(so / att,2),
           `Index` = round(((pp * 4) + (gp * 3) + (mp * 2) + (np * 1) + (op * 0.5) + (er * 0)) / att,2),
           `FBSO Eff` = round(fbso_num / att, 3)) %>%
    select(setter_position, end_zone, `Rec att`, `SO%`:`FBSO Eff`) %>%
    rename(`Rec zone` = end_zone)

  tib[, 2:6] %>%
    kableExtra::kable(label = NA, booktabs = T, linesep = '', caption = paste0(team_name, " reception by end zone")) %>%
    kableExtra::kable_styling(latex_options = c("striped", "condensed"), full_width = F) %>%
    kableExtra::pack_rows(index = table(tib$setter_position))
}
