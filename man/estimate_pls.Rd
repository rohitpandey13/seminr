% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_pls.R
\name{estimate_pls}
\alias{estimate_pls}
\title{seminr estimate_pls() function}
\usage{
estimate_pls(data, measurement_model, structural_model,
             inner_weights = path_weighting)
}
\arguments{
\item{data}{A \code{dataframe} containing the indicator measurement data.}

\item{measurement_model}{A source-to-target matrix representing the outer/measurement model,
generated by \code{constructs}.}

\item{structural_model}{A source-to-target matrix representing the inner/structural model,
generated by \code{relationships}.}

\item{inner_weights}{A parameter declaring which inner weighting scheme should be used
path_weighting is default, alternately path_factorial can be used.}
}
\description{
The \code{seminr} package provides a natural syntax for researchers to describe
structural equation models.
}
\examples{
mobi <- mobi

#seminr syntax for creating measurement model
mobi_mm <- constructs(
             reflective("Image",        multi_items("IMAG", 1:5)),
             reflective("Expectation",  multi_items("CUEX", 1:3)),
             reflective("Quality",      multi_items("PERQ", 1:7)),
             reflective("Value",        multi_items("PERV", 1:2)),
             reflective("Satisfaction", multi_items("CUSA", 1:3)),
             reflective("Complaints",   single_item("CUSCO")),
             reflective("Loyalty",      multi_items("CUSL", 1:3))
           )
#seminr syntax for creating structural model
mobi_sm <- relationships(
  paths(from = "Image",        to = c("Expectation", "Satisfaction", "Loyalty")),
  paths(from = "Expectation",  to = c("Quality", "Value", "Satisfaction")),
  paths(from = "Quality",      to = c("Value", "Satisfaction")),
  paths(from = "Value",        to = c("Satisfaction")),
  paths(from = "Satisfaction", to = c("Complaints", "Loyalty")),
  paths(from = "Complaints",   to = "Loyalty")
)

mobi_pls <- estimate_pls(data = mobi,
                         measurement_model = mobi_mm,
                         structural_model = mobi_sm)

summary(mobi_pls)
plot_scores(mobi_pls)
}
\seealso{
\code{\link{relationships}} \code{\link{constructs}} \code{\link{paths}} \code{\link{interaction_term}}
         \code{\link{bootstrap_model}}
}
