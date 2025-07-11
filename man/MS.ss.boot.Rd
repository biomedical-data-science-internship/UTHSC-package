% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multiplicative_stratified_boot.R
\name{MS.ss.boot}
\alias{MS.ss.boot}
\title{Estimate Sample Size for a Multiplicative Stratified RMST Model via Simulation}
\usage{
MS.ss.boot(
  pilot_data,
  time_var,
  status_var,
  arm_var,
  strata_var,
  target_power,
  linear_terms = NULL,
  L,
  n_sim = 1000,
  alpha = 0.05,
  parallel.cores = 1,
  patience = 5,
  n_start = 50,
  n_step = 25,
  max_n_per_arm = 2000
)
}
\arguments{
\item{pilot_data}{A \code{data.frame} with pilot study data.}

\item{time_var}{A character string for the time-to-event variable.}

\item{status_var}{A character string for the event status variable.}

\item{arm_var}{A character string for the treatment arm variable.}

\item{strata_var}{A character string for the stratification variable.}

\item{target_power}{A single numeric value for the target power (e.g., 0.80).}

\item{linear_terms}{Optional vector of covariates for the model.}

\item{L}{The numeric truncation time for RMST.}

\item{n_sim}{Number of bootstrap simulations per search step.}

\item{alpha}{The significance level.}

\item{parallel.cores}{Number of cores for parallel processing.}

\item{patience}{Number of consecutive non-improving steps in the search before terminating.}

\item{n_start}{Starting sample size per stratum for the search.}

\item{n_step}{Increment for the sample size search.}

\item{max_n_per_arm}{Maximum sample size per stratum to try.}
}
\value{
A \code{list} containing:
\item{results_data}{A \code{data.frame} with the target power and required N.}
\item{results_plot}{A \code{ggplot} object showing the search path.}
\item{results_summary}{A \code{data.frame} with the estimated treatment effect.}
}
\description{
Performs sample size estimation based on a multiplicative model for RMST
for stratified trials, using iterative bootstrap simulations.
}
\details{
This function iteratively searches for the sample size required to
achieve a \code{target_power}. At each step of the search, it runs a full bootstrap simulation
(as described in \code{MS.power.boot}) to estimate the power for the
current sample size. The search proceeds until the target power is met or
other stopping criteria are satisfied. This process can be very computationally
intensive.
}
\note{
\code{status_var} should be \code{1}/\code{0}. \code{arm_var} should be \code{1}/\code{0}. \code{strata_var}
is a mandatory argument.
}
\examples{
\dontrun{
pilot_df_strat_effect <- data.frame(
 time = c(rexp(60, 0.15), rexp(60, 0.08)), # Effect
 status = rbinom(120, 1, 0.7),
 arm = rep(0:1, each = 60),
 region = factor(rep(c("A", "B", "C"), each = 40))
)
ss_results <- MS.ss.boot(
 pilot_data = pilot_df_strat_effect,
 time_var = "time", status_var = "status", arm_var = "arm", strata_var = "region",
 target_power = 0.80, L = 10,
 n_sim = 100, # Low n_sim for example
 n_start = 100,
 n_step = 50, patience = 2
)
print(ss_results$results_data)
}
}
