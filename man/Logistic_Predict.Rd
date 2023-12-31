% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Logistic_Predict.R
\name{Logistic_Predict}
\alias{Logistic_Predict}
\title{Logistic Model Prediction}
\usage{
Logistic_Predict(X, Beta, thre = 0.5)
}
\arguments{
\item{X}{A numeric matrix where each row represents an observation and each column represents a predictor variable.}

\item{Beta}{A numeric vector of coefficients for the logistic regression model.}

\item{thre}{The threshold for predicting the binary outcome; defaults to 0.5. Observations with predicted probabilities greater than this threshold are classified as 1, and others as 0.}
}
\value{
A numeric vector of predicted binary outcomes (0 or 1) for each observation.
}
\description{
Predicts outcomes using a logistic model. Given a matrix of predictors, coefficients, and a threshold, it computes predictions based on the logistic model.
}
\examples{
X <- matrix(rnorm(20), ncol=2)
Beta <- runif(2)
predictions <- Logistic_Predict(X, Beta)

X = matrix(c(1, 2, 3, 4), ncol = 2)
Beta = c(0.5, -0.5)
expected = c(0, 0)
result = Logistic_Predict(X, Beta)
all.equal(result, expected,tolerance = 0.0001)
}
