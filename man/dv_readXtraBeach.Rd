% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/beach.R
\name{dv_readXtraBeach}
\alias{dv_readXtraBeach}
\title{Return datavolley plays object with added columns from a Hudl beach XML file.}
\usage{
dv_readXtraBeach(d)
}
\arguments{
\item{d:}{xml file path, run ('.') if local}
}
\value{
dv_readXtraBeach data.frame: the plays component of a XML object, as returned by \code{dv_read()}
}
\description{
Return datavolley plays object with added columns from a Hudl beach XML file.
}
\examples{
\dontrun{
  dv_readXtraBeach('.')
  }
}
\references{
\url{https://github.com/openvolley/datavolley}
}
