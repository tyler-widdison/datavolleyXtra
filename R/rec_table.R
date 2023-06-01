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
#' @importFrom DT datatable formatPercentage formatStyle formatRound styleColorBar
#' @importFrom magrittr "%>%"
#' @export

#' @return data table with simple reception statistics
#'
#' @examples
#' \dontrun{
#'   rec_table(data, 'Yale', 3)
#'   }
#'
#' @export

rec_table <- function(data, team_name, rotation) {
  exp_so <- data %>%
    dplyr::filter(skill == 'Reception') %>%
    dplyr::group_by(evaluation_code, skill) %>%
    dplyr::summarise(x_so = sum(point_won_by == team, na.rm = T) / dplyr::n())

  data <- data %>%
    dplyr::left_join(exp_so)

  table <- data %>%
    dplyr::filter(skill == 'Reception' & grepl(team_name, team) & grepl(paste0("Rotation ", rotation), setter_position)) %>%
    dplyr::group_by(setter_position, Player) %>%
    dplyr::summarise(n = dplyr::n(),
              xs = sum(x_so),
              so = sum(point_won_by == team, na.rm = T),
              pp = sum(evaluation_code == '#'),
              gp = sum(evaluation_code == '+'),
              mp = sum(evaluation_code == '!'),
              np = sum(evaluation_code == '-'),
              op = sum(evaluation_code == '/'),
              er = sum(evaluation_code == '='),
              .groups = 'drop') %>%
    janitor::adorn_totals() %>%
    dplyr::group_by(setter_position, Player) %>%
    dplyr::summarise(Att = sum(n),
              `SO%` = sum(so) / Att,
              `Exp SO%` = sum(xs) / Att,
              Index = ((sum(pp) *4) +
                         (sum(gp) *3) +
                         (sum(mp) *2) +
                         (sum(np) *1) +
                         (sum(er) *0) +
                         (sum(op) *0.5)) / Att,
              `ER%` = sum(er) / Att) %>%
    dplyr::filter(Att > 10) %>%
    dplyr::ungroup() %>%
    dplyr::select(-setter_position) %>%
    dplyr::mutate(Player = ifelse(Player == '-', 'Total', Player)) %>%
    dplyr::arrange(Player, desc(`SO%`))

  rot <- data %>%
    dplyr::filter(skill == 'Reception' & grepl(team_name, team) & grepl(paste0("Rotation ", rotation), setter_position)) %>%
    dplyr::distinct(setter_position) %>%
    purrr::pluck(1)

    DT::datatable(table,
                options = list(dom = 't'),
                class = 'display nowrap compact cell-border stripe',
                rownames = F,
                caption = rot,
                ) %>%
    DT::formatPercentage('Exp SO%', 1) %>%
    DT::formatRound('Index', 2) %>%
    DT::formatPercentage('SO%', 1) %>%
    DT::formatPercentage('ER%', 1) %>%

    DT::formatStyle('Exp SO%',
                    background = DT::styleColorBar(c(.30,table$`Exp SO%`), 'darkseagreen1'),
                    backgroundSize = '95% 50%',
                    backgroundRepeat = 'no-repeat',
                    backgroundPosition = 'center') %>%

    DT::formatStyle('SO%',
                    background = DT::styleColorBar(c(.30,table$`SO%`), 'lightblue'),
                    backgroundSize = '95% 50%',
                    backgroundRepeat = 'no-repeat',
                    backgroundPosition = 'center') %>%

    DT::formatStyle(c(1:7), `border-right` = 'solid 1px')
}
