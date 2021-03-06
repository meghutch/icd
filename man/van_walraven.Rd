% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/score.R
\name{van_walraven}
\alias{van_walraven}
\alias{van_walraven.data.frame}
\alias{van_walraven_from_comorbid}
\title{Calculate van Walraven Elixhauser Score}
\usage{
van_walraven(
  x,
  visit_name = NULL,
  return_df = FALSE,
  stringsAsFactors = getOption("stringsAsFactors"),
  ...
)

\method{van_walraven}{data.frame}(
  x,
  visit_name = NULL,
  return_df = FALSE,
  stringsAsFactors = getOption("stringsAsFactors"),
  ...
)

van_walraven_from_comorbid(x, visit_name = NULL, hierarchy = FALSE)
}
\arguments{
\item{x}{data frame containing a column of visit or patient identifiers, and
a column of ICD-9 codes. It may have other columns which will be ignored.
By default, the first column is the patient identifier and is not counted.
If \code{visit_name} is not specified, the first column is used.}

\item{visit_name}{The name of the column in the data frame which contains the
patient or visit identifier. Typically this is the visit identifier, since
patients come leave and enter hospital with different ICD-9 codes. It is a
character vector of length one. If left empty, or \code{NULL}, then an
attempt is made to guess which field has the ID for the patient encounter
(not a patient ID, although this can of course be specified directly). The
guesses proceed until a single match is made. Data frames may be wide with
many matching fields, so to avoid false positives, anything but a single
match is rejected. If there are no successful guesses, and \code{visit_id}
was not specified, then the first column of the data frame is used.}

\item{return_df}{single logical value, if \code{TRUE}, a two column data
frame will be returned, with the first column named as in input data frame
(i.e., \code{visit_name}), containing all the visits, and the second column
containing the Charlson Comorbidity Index.}

\item{stringsAsFactors}{Single logical value, describing whether the resulting data frame should have strings, e.g.
\code{visit_id} converted to factor. Default is to follow the current session option. This is identical to the
argument used in, among other base functions \code{as.data.frame}.}

\item{...}{arguments passed on to other functions}

\item{hierarchy}{single logical value that defaults to \code{TRUE}, in
which case the hierarchy defined for the mapping is applied. E.g. in
Elixhauser, you can't have uncomplicated and complicated diabetes both
flagged.}
}
\description{
van Walraven Elixhauser score is calculated from the Quan revision of
Elixhauser's ICD-9 mapping. This function allows for the hierarchical
exclusion of less severe versions of comorbidities when their more severe
version is also present via the \code{hierarchy} argument. For the Elixhauser
comorbidities, this is diabetes v. complex diabetes and solid tumor v.
metastatic tumor
}
\section{Methods (by class)}{
\itemize{
\item \code{data.frame}: van Walraven scores from data frame of visits
and ICD-9 codes
}}

\examples{
mydf <- data.frame(
  visit_name = c("a", "b", "c"),
  icd9 = c("412.93", "441", "042")
)
van_walraven(mydf)
# or calculate comorbidities first:
cmb <- icd9_comorbid_quan_elix(mydf, short_code = FALSE, hierarchy = TRUE)
vwr <- van_walraven_from_comorbid(cmb)
stopifnot(identical(van_walraven(mydf), vwr))

# alternatively return as data frame in 'tidy' format
van_walraven(mydf, return_df = TRUE)
}
\references{
van Walraven C, Austin PC, Jennings A, Quan H, Forster AJ. A
  Modification to the Elixhauser Comorbidity Measures Into a Point System for
  Hospital Death Using Administrative Data. Med Care. 2009; 47(6):626-633.
  \url{http://www.ncbi.nlm.nih.gov/pubmed/19433995}
}
\author{
wmurphyrd
}
