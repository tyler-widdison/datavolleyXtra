#' Return datavolley plays object with added columns from a Hudl beach XML file.
#'
#' @references \url{https://github.com/openvolley/datavolley}
#' @param d: xml file path, run ('.') if local
#'
#' @return dv_readXtraBeach data.frame: the plays component of a XML object, as returned by \code{dv_read()}
#'
#' @examples
#' \dontrun{
#'   dv_readXtraBeach('.')
#'   }
#' @export

dv_readXtraBeach <- function(d) {

  dir <- dir(d, pattern = "xml$", full.names = TRUE)

  lx <- lapply(dir, function(filename) {
    tryCatch(
      datavolley::dv_read(filename, insert_technical_timeouts = FALSE),
      error = function(e) {
        message(paste0("Error reading file ", filename, ": ", e$message))
        return(NULL)
      })
  })

  data <- do.call(rbind, lapply(lx, function(dv) {
    if (is.null(dv)) {
      return(NULL)
    }
    out <- datavolley::plays(dv)
    out$filename <- basename(dv$meta$filename) #Return filename as a column
    out$league <- dv$meta$match$league #Some XML data has league, or tournament type
    out$phase <- dv$meta$match$phase #Some XML data has phase of tournament
    out$city <- dv$meta$more$city #Some XML data has the city
    out$weather <- dv$meta$comments$comment_1 #Some XML data has the weather
    return(out)
  }))
  # Add tournament info here
  data %>%
    # Problem files
    dplyr::filter(!grepl('Vienna', city) &
             filename != '2022-04-14-Capogrosso-Capogrosso-vs-Immers-VanWerkhoven.xml' &
             filename != '2022-04-15-Fuller-ODeaS-vs-KDunwinit-MWachirawit.xml' &
             filename != '2022-09-16-Canet-Rotar-vs-Roark-Henwood.xml'
           ) %>%
    # Change a few filenames, add date column
    dplyr::mutate(filename = ifelse(filename == '2022-05-22-Perusic-Schweiner-vs-Renato-Vitor-Felipe.xml', '2022-05-26-Perusic-Schweiner-vs-Renato-Vitor-Felipe.xml', filename),
           filename = ifelse(filename == 'Varenhorst-vandeVelde-vs-Virgen-Sarabia.xml', '2022-05-06-Varenhorst-vandeVelde-vs-Virgen-Sarabia.xml', filename),
           date = substr(filename, 1, 10), # Depending on what your file name is, the substr may need to change this line
           # Add tournament info
           tournament = dplyr::case_when(
             date >= as.Date('2022-03-15') & date <= as.Date('2022-03-20') ~ '01-Tlaxcala',
             date >= as.Date('2022-03-23') & date <= as.Date('2022-03-27') ~ '02-Rosarito',
             date >= as.Date('2022-03-30') & date <= as.Date('2022-04-03') ~ '03-Coolangatta',
             date >= as.Date('2022-04-14') & date <= as.Date('2022-04-18') & grepl('pema', city) ~ '04-Itapema',
             date >= as.Date('2022-04-14') & date <= as.Date('2022-04-18') & grepl('Thai', city) ~ '05-Songkhla',
             date >= as.Date('2022-05-05') & date <= as.Date('2022-05-08') ~ '06-Doha',
             date >= as.Date('2022-05-12') & date <= as.Date('2022-05-15') ~ '07-Madrid',
             date >= as.Date('2022-05-19') & date <= as.Date('2022-05-22') & grepl('Spain', city) ~ '07-Madrid',
             date >= as.Date('2022-05-19') & date <= as.Date('2022-05-22') & grepl('Ku', city) ~ '08-Kusadasi',
             date >= as.Date('2022-05-25') & date <= as.Date('2022-05-29') ~ '09-Ostrava',
             date >= as.Date('2022-06-01') & date <= as.Date('2022-06-05') & grepl('mala', city) ~ '10-Jurmala',
             date >= as.Date('2022-06-01') & date <= as.Date('2022-06-05') & grepl('Lith', city) ~ '11-Klaipeda',
             date >= as.Date('2022-06-10') & date <= as.Date('2022-06-19') ~ '12-Rome World Championships',
             date >= as.Date('2022-06-23') & date <= as.Date('2022-06-27') ~ '13-Bialystok',
             date >= as.Date('2022-07-06') & date <= as.Date('2022-07-10') ~ '14-Gstaad',
             date >= as.Date('2022-07-14') & date <= as.Date('2022-07-17') ~ '15-Espinho',
             date >= as.Date('2022-07-21') & date <= as.Date('2022-07-24') ~ '16-Agadir, Morocco',
             date >= as.Date('2022-07-28') & date <= as.Date('2022-07-31') ~ '17-Ljubljana',
             date >= as.Date('2022-08-10') & date <= as.Date('2022-08-14') & grepl('Port', city) ~ '19-Cortegaca',
             date >= as.Date('2022-08-10') & date <= as.Date('2022-08-14') & grepl('Germany', city) ~ '20-Hamburg',
             date >= as.Date('2022-08-16') & date <= as.Date('2022-08-21') & grepl('Germ', city) ~ '21-CEV European Championships - Munich',
             date >= as.Date('2022-08-24') & date <= as.Date('2022-08-28') & grepl('Mont', city) ~ '22-Montpellier',
             date >= as.Date('2022-08-24') & date <= as.Date('2022-08-28') & grepl('Bad', city) ~ '23-Baden',
             date >= as.Date('2022-09-14') & date <= as.Date('2022-09-18') & grepl('U19', city) ~ '24-Dikili (WC19)',
             date >= as.Date('2022-09-28') & date <= as.Date('2022-10-02') ~ '25-Paris',
             date >= as.Date('2022-10-13') & date <= as.Date('2022-10-16') ~ '26-Maldives',
             date >= as.Date('2022-10-22') & date <= as.Date('2022-10-25') ~ '27-Dubai 1st',
             date >= as.Date('2022-10-27') & date <= as.Date('2022-10-30') ~ '28-Dubai 2nd',
             date >= as.Date('2022-11-02') & date <= as.Date('2022-11-06') ~ '29-Cape Town',
             date >= as.Date('2022-11-09') & date <= as.Date('2022-11-13') ~ '30-Uberlandia',
             date >= as.Date('2022-11-23') & date <= as.Date('2022-11-27') ~ '31-Torquay-1',
             date >= as.Date('2022-11-29') & date <= as.Date('2022-12-03') ~ '32-Torquay-2',
             date >= as.Date('2023-01-25') & date <= as.Date('2023-01-30') ~ '33-Beach Pro Tour Finals 2022',
             date >= as.Date('2023-02-01') & date <= as.Date('2023-02-05') ~ '34-Doha',
             date >= as.Date('2023-03-16') & date <= as.Date('2023-03-19') & grepl('La Paz', city) ~ '34-La Paz',
             date >= as.Date('2023-03-16') & date <= as.Date('2023-03-19') & !grepl('La Paz', city) ~ '35-Mt. Maunganui Beach',
             date >= as.Date('2023-03-22') & date <= as.Date('2023-03-26') ~ '36-Tepic',
             date >= as.Date('2023-03-29') & date <= as.Date('2023-04-02') ~ '37-Coolangatta Beach',
             date >= as.Date('2023-04-06') & date <= as.Date('2023-04-09') ~ '38-Itapema',
             date >= as.Date('2023-04-13') & date <= as.Date('2023-04-16') ~ '39-Saquarema',
             date >= as.Date('2023-04-20') & date <= as.Date('2023-04-23') ~ '40-Satun',
             date >= as.Date('2023-04-26') & date <= as.Date('2023-04-30') ~ '41-Uberlandia',
             date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '42-Madrid',
             date >= as.Date('2023-05-31') & date <= as.Date('2023-06-04') ~ '43-Ostrava',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '44-Jurmala',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '45-Gstaad',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '46-Espinho',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '47-Edmonton',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '48-Montreal',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '49-Hamburg',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '50-Paris',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '51-World Champs',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '52-Goa',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '53-Maldives',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '54-Dubai',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '55-Haikou',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '56-Chiang Mai',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '57-Australlia',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '58-Nuvali',
             #date >= as.Date('2023-05-11') & date <= as.Date('2023-05-14') ~ '59-Finals Doah',
             TRUE ~ NA_character_)
           )
  }

  #get_fivb_finishes <- function() {
  ## Men
  #tribble(
  #  ~xml_team, ~finish,  ~tournament,
  #  "a",       2,        3.6,
  #  "b",       1,        8.5,
  #)
#}

# In development
