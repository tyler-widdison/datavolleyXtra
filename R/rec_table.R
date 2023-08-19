#' Return a simple reception table
#'
#' @param data: dataset
#' @param team_name: teamname desired in dataset. Can use short names, but will return other teams with smiliar short names IE 'Texas' will return multiple teams
#' @param rotation: desired rotation
#' @author Tyler Widdison
#' @description
#' @importFrom dplyr filter mutate summarise left_join group_by
#' @importFrom janitor adorn_totals
#' @importFrom purrr pluck
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

rec_table <- function(data, team_name) {
  tib <- data %>%
    dplyr::filter(skill == 'Reception' & stringr::str_detect(team, team_name)) %>%
    dplyr::group_by(setter_position, Player) %>%
    dplyr::summarise(n = dplyr::n(),
                     so = sum(point_won_by == team, na.rm = T),
                     pp = sum(evaluation_code == '#'),
                     gp = sum(evaluation_code == '+'),
                     mp = sum(evaluation_code == '!'),
                     np = sum(evaluation_code == '-'),
                     op = sum(evaluation_code == '/'),
                     er = sum(evaluation_code == '='),
                     .groups = 'drop') %>%
    janitor::adorn_totals(name = team_name) %>%
    dplyr::group_by(setter_position, Player) %>%
    dplyr::summarise(Att = sum(n),
                     `SO%` = scales::percent(sum(so) / Att, accuracy = .1),
                     Index = round(((sum(pp) * 4) +
                                (sum(gp) * 3) +
                                (sum(mp) * 2) +
                                (sum(np) * 1) +
                                (sum(er) * 0) +
                                (sum(op) * 0.5)) / Att,2),
                     `ER%` = scales::percent(sum(er) / Att, accuracy = .1),
                     .groups = 'drop') %>%
    dplyr::filter(Att > 3)

  tib[, 2:6] %>%
    kableExtra::kable(booktabs = T, longtable = T, linesep = '', caption = 'Reception by Rotation') %>%
    kableExtra::kable_styling(latex_options = c("striped", "condensed"), full_width = F) %>%
    kableExtra::pack_rows(index = table(tib$setter_position))
  }
