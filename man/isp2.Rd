% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reduce.R
\name{isp2}
\alias{isp2}
\title{Test if an integer is a power of 2}
\usage{
isp2(n)
}
\arguments{
\item{n}{an interger.}
}
\value{
a boolean TRUE or FALSE
}
\description{
This is a convenient function to test if an integer number is a power of 2.
Because  the number of model simulation must be a power of 2 in 
\code{rlba} and \code{rplba}, this function helps to check this limitation.
}
