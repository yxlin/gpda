% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/density.R
\name{n1PDF_plba0}
\alias{n1PDF_plba0}
\alias{n1PDF_plba1}
\title{Approximate Node 1 Likelihood of the pLBA Model}
\usage{
n1PDF_plba0(x, A, b, mean_v, sd_v, t0, mean_w, rD, swt, n = 1024,
  nthread = 32, gpuid = 0, h = NA, debug = FALSE)

n1PDF_plba1(x, A, b, mean_v, sd_v, t0, mean_w, rD, swt, n = 1024,
  nthread = 32, gpuid = 0, h = NA, debug = FALSE)
}
\arguments{
\item{x}{vector of quantiles.}

\item{A}{starting point variability. This must be a scalar in plba1. It 
must be a two-element vector in plba2 and plba3.}

\item{b}{threshold. Must be a scalar for plba1. Must be a two-element vector
for plba2.}

\item{mean_v}{mean drift rate stage 1. This must be a two-element vector.}

\item{sd_v}{standard deviation of drift rate stage 1. This must be a
two-element vector.}

\item{t0}{non-decision time.}

\item{mean_w}{mean drift rate stage 2. This must be a two-element vector.}

\item{rD}{an internal psychological delay time for drift rate.}

\item{swt}{an external switch time when task information changes.}

\item{n}{number of simulations. This must be a power of two.}

\item{nthread}{numbers of launched GPU threads. Default is a wrap.}

\item{gpuid}{select which GPU to conduct model simulation, if running on 
multiple GPU machines.}

\item{h}{kernel bandwidth}

\item{debug}{a debugging switch.}
}
\value{
a likelihood vector.
}
\description{
This is the approximated density function for 2-accumualtor \emph{piecewise}
LBA model, drawing drift rates from truncated normal distributions.
}
\details{
\code{n1PDF_plba0} is the node-one probability density function for the naive
piecewise LBA model. It draws stage-one drift rates from the truncated normal 
distributions with means, \code{mean_v} and standard deviations, \code{sd_v}. 
After switch, it redraws drift rates from the same truncated normal 
distributions. See the last paragraph in Section 3.1, page 13 (Holmes, 
Trueblood, & Heathcote, 2016).

\code{n1PDF_plba1} is the node-one probability density function for two-stage
piecewise LBA model. It draws stage-one drift rate from truncated normal
distributions with means, \code{mean_v} and standard deviations, \code{sd_v}.
After switch, it redraws drift rate from different truncated normal 
distributions  with means, \code{mean_w} and standard deviations, 
\code{sd_v}.
}
\examples{
rm(list=ls())
n <- 2^20
x <- seq(0, 3, length.out = 1e3);
#########################30
## plba0 vs plba1 -------30
#########################30
den0 <- ppda::n1PDF_plba0(x, A = 1.5, b = 2.7, mean_v = c(3.3, 2.2), 
  sd_v = c(1, 1), t0 = .08, mean_w = c(1.5, 1.2), rD = .3, swt = .5, n = n, 
  h = .01, debug = FALSE)

den1 <- ppda::n1PDF_plba1(x, A = 1.5, b = 2.7, mean_v = c(3.3, 2.2), 
  sd_v = c(1, 1), t0 = .08, mean_w = c(1.5, 1.2), rD = .3, swt = .5, n = n, 
  h = .01, debug = FALSE)

## Use the second GPU card, if there is any
## den2 <- ppda::n1PDF_plba1(x, A = 1.5, b = 2.7, mean_v = c(3.3, 2.2), 
##   sd_v = c(1, 1), t0 = .08, mean_w = c(1.5, 1.2), rD = .3, swt = .5, n = n, 
##   h = .01, gpuid = 1, debug = FALSE)

palette1 <- palette()
plot(x, den0, type="l", col = palette1[1], xlab = "Quantiles", 
        ylab = "Density")
lines(x, den1, lwd = 1, col = palette1[2])
## lines(data, den2, lwd = 1, col = palette1[3])

#########################30
## plba2          -------30
#########################30
\dontrun{
den2 <- ppda::n1PDF_plba2(x, nsim=n, b=c(2.7, 2.7), A=c(1.5,1.5),
mean_v=c(3.3, 2.2), mean_w=c(1.5, 1.2),
sd_v=c(1, 1), rD=.3, swt=.5, t0=.08)
plot(x, den2, type="l")


#########################30
## plba3          -------30
#########################30
pvec1 <- c(A1 = 1.51, A2 = 1.51, B1 = 1.2, B2 = 1.2,   C1 = .3, C2 = .3,
  v1 = 3.32, v2 = 2.24, w1 = 1.51, w2 = 3.69, sv1 = 1, sv2 = 1,
  sw1 = 1, sw2 = 1, rD = 0.1, tD = .1, swt = 0.5, t0 = 0.08)

pvec2 <- c(A1 = 1.51, A2 = 1.51, B1 = 1.2, B2 = 1.2, C1 = .3, C2 = .3,
  v1 = 3.32, v2 = 2.24, w1 = 1.51, w2 = 3.69, sv1 = 1, sv2 = 1,
  sw1 = 1, sw2 = 1, rD = 0.1, tD = .15, swt = 0.5, t0 = 0.08)
pvec3 <- c(A1 = 1.51, A2 = 1.51, B1 = 1.2, B2 = 1.2, C1 = .3, C2 = .3,
  v1 = 3.32, v2 = 2.24, w1 = 1.51, w2 = 3.69, sv1 = 1, sv2 = 1,
  sw1 = 1, sw2 = 1, rD = 0.15, tD = .1, swt = 0.5, t0 = 0.08)

den3 <- ppda::n1PDF_plba3(x, nsim = n, B = pvec1[3:4], A =pvec1[1:2],
  C = pvec1[5:6], mean_v = pvec1[7:8],
  mean_w = pvec1[9:10], sd_v = pvec1[11:12],
  sd_w = pvec1[13:14], rD = pvec1[15], tD = pvec1[16],
  swt = pvec1[17], t0 = pvec1[18])

plot(x, den3, type="l")
}
}
\references{
Holmes, W., Trueblood, J. S., & Heathcote, A. (2016). A new
framework for modeling decisions about changing information: The Piecewise
Linear Ballistic Accumulator model \emph{Cognitive Psychology}, 85,
1--29.  \url{http://dx.doi.org/10.1016/j.cogpsych.2015.11.002}.
}
