#' Return a reception dashboard with your data
#'
#' @param data: dataset
#' @author Tyler Widdison
#' @description Simple reception dashboard meant for indoor volleyball breaking down the reception of teams by rotation with the ability to filter by opponents. Best used if datavolleyXtra::dv_readXtra() is ran
#' @importFrom dplyr filter group_by summarise n mutate arrange desc select
#' @importFrom janitor adorn_totals
#' @importFrom DT DTOutput datatable formatRound formatPercentage formatStyle renderDT
#' @importFrom shinyWidgets pickerInput updatePickerInput
#' @importFrom shinydashboardPlus dashboardPage dashboardHeader dashboardSidebar
#' @importFrom shiny fluidRow column shinyApp reactive observeEvent
#' @importFrom magrittr "%>%"
#' @export

#' @return data read from datavolleyXtra::dv_readXtra()

#' @examples
#' \dontrun{
#'   df <- datavolleyXtra::dv_readXtra("DVWs")
#'   rec_app(df)
#'   }
#' @export


# Body -----------------------------------------------------------

rec_app <- function(data) {
body <- shinydashboard::dashboardBody(
  shiny::fluidRow(
      shiny::column(12,
                    shiny::fluidRow(shiny::column(4,shinydashboard::box(DT::DTOutput(outputId = "rec_tbl_1"), width = NULL, status = 'primary', solideHeader = T)),
                             shiny::column(4,shinydashboard::box(DT::DTOutput(outputId = "rec_tbl_2"), width = NULL, status = 'primary', solideHeader = T)),
                             shiny::column(4,shinydashboard::box(DT::DTOutput(outputId = "rec_tbl_3"), width = NULL, status = 'primary', solideHeader = T))),
                    shiny::fluidRow(shiny::column(4,shinydashboard::box(DT::DTOutput(outputId = "rec_tbl_4"), width = NULL, status = 'primary', solideHeader = T)),
                             shiny::column(4,shinydashboard::box(DT::DTOutput(outputId = "rec_tbl_5"), width = NULL, status = 'primary', solideHeader = T)),
                             shiny::column(4,shinydashboard::box(DT::DTOutput(outputId = "rec_tbl_6"), width = NULL, status = 'primary', solideHeader = T)))
                    )))

# Shiny -------------------------------------------------------------------
shiny::shinyApp(
  ui <-
    shinydashboardPlus::dashboardPage(
      shinydashboardPlus::dashboardHeader(title = 'Reception dashboard'),
      shinydashboardPlus::dashboardSidebar(
        # Select inputs
        shinyWidgets::pickerInput(inputId = 'team', label = 'Select Team', choices = unique(na.omit(data$team))),
        shinyWidgets::pickerInput(inputId = 'opponent', label = 'Select Match', choices = NULL, selected = NULL, multiple = T, options = list(`actions-box` = TRUE))),
  body),


# Server ------------------------------------------------------------------


server <- function(input, output, session) {

  server_data <- shiny::reactive({
    data %>%
      dplyr::filter(skill == 'Reception' & team == input$team & Match %in% input$opponent)
    })

  filtered_team <- shiny::reactive({
    data$Match[data$team == input$team]
  })

  shiny::observeEvent(filtered_team(), {
    shinyWidgets::updatePickerInput(session, inputId = 'opponent', label = 'Select Match', choices = unique(sort(filtered_team())), selected = unique(sort(filtered_team())))
  })

  rec_table <- function(rotation) {server_data() %>%
      dplyr::filter(setter_position == rotation) %>%
      dplyr::group_by(match_id, setter_position, Player) %>%
      dplyr::summarise(n = dplyr::n(),
                #xs = sum(x_so),
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
                #`Exp SO%` = sum(xs) / Att,
                Index = ((sum(pp) * 4) +
                           (sum(gp) * 3) +
                           (sum(mp) * 2) +
                           (sum(np) * 1) +
                           (sum(er) * 0) +
                           (sum(op) * 0.5)) / Att,
                `ER%` = sum(er) / Att,
                .groups = 'drop') %>%
      dplyr::filter(Att > 3) %>%
      dplyr::select(-setter_position) %>%
      dplyr::mutate(Player = ifelse(Player == '-', 'Total', Player)) %>%
      dplyr::arrange(Player, dplyr::desc(Att))

  }

  rec_table_dt <- function(data, title) {
    DT::datatable(data,
                  class = 'display nowrap compact cell-border stripe',
                  rownames = F,
                  caption = title,
                  options = list(dom = 't')) %>%
      #DT::formatPercentage('Exp SO%', 1) %>%
      DT::formatRound('Index', 2) %>%
      DT::formatPercentage('SO%', 1) %>%
      DT::formatPercentage('ER%', 1) %>%

      #DT::formatStyle('Exp SO%',
      #                background = styleColorBar(c(.30,data$`Exp SO%`), 'darkseagreen1'),
      #                backgroundSize = '95% 50%',
      #                backgroundRepeat = 'no-repeat',
      #                backgroundPosition = 'center') %>%


      DT::formatStyle('SO%',
                      background = DT::styleColorBar(c(.30,data$`SO%`), 'lightblue'),
                      backgroundSize = '95% 50%',
                      backgroundRepeat = 'no-repeat',
                      backgroundPosition = 'center') %>%

      DT::formatStyle(c(1:6), `border-right` = 'solid 1px')
  }


  output$rec_tbl_1 <- DT::renderDT({
    rot_1 <- rec_table('Rotation 1 (S in 1)')
    rec_table_dt(rot_1, 'Rotation 1 (S in 1)')
  })

  output$rec_tbl_2 <- DT::renderDT({
    rot_2 <- rec_table('Rotation 2 (S in 6)')
    rec_table_dt(rot_2, 'Rotation 2 (S in 6)')
  })

  output$rec_tbl_3 <- DT::renderDT({
    rot_3 <- rec_table('Rotation 3 (S in 5)')
    rec_table_dt(rot_3, 'Rotation 3 (S in 5)')
  })

  output$rec_tbl_6 <- DT::renderDT({
    rot_4 <- rec_table('Rotation 4 (S in 4)')
    rec_table_dt(rot_4, 'Rotation 4 (S in 4)')
  })

  output$rec_tbl_5 <- DT::renderDT({
    rot_5 <- rec_table('Rotation 5 (S in 3)')
    rec_table_dt(rot_5, 'Rotation 5 (S in 3)')
  })

  output$rec_tbl_4 <- DT::renderDT({
    rot_6 <- rec_table('Rotation 6 (S in 2)')
    rec_table_dt(rot_6, 'Rotation 6 (S in 2)')
  })


})
}
