#' Matching Hudl's team XML files to final finishes by event
#'
#' @return get_team_schedule data.frame: 'url', 'date', 'home', 'away', 'location'
#'
#' @examples
#' \dontrun{
#'   get_team_schedule('Yale', 813, 2019)
#'   }
#'
#' @export

get_fivb_finishes <- function() {
  # Men
  tribble(
    ~xml_team, ~finish,  ~tournament,
    "a",       2,        3.6,
    "b",       1,        8.5,
  )
}

# In development
