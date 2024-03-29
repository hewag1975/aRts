% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/maps.R
\name{FeatureList}
\alias{FeatureList}
\title{Helper function creating a list of OSM features to be queries}
\usage{
FeatureList(maptype = "building", layers = NULL)
}
\arguments{
\item{x, }{object of class \code{stars}, the picture to be processed.}

\item{...}{further arguments passed to \code{supercells()}}
}
\value{
A nested \code{list} with layers and key-value-lists per layer.
}
\description{
Helper function creating a list of OSM features to be queries
}
\examples{
FeatureList(maptype = "building")
FeatureList(maptype = "street")
FeatureList(maptype = NULL, layers = c("buildings"))

}
