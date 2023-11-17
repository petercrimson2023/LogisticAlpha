#' Logistic Model Prediction
#'
#' Predicts outcomes using a logistic model. Given a matrix of predictors, coefficients, and a threshold, it computes predictions based on the logistic model.
#'
#' @param X A numeric matrix where each row represents an observation and each column represents a predictor variable.
#' @param Beta A numeric vector of coefficients for the logistic regression model.
#' @param thre The threshold for predicting the binary outcome; defaults to 0.5. Observations with predicted probabilities greater than this threshold are classified as 1, and others as 0.
#' @return A numeric vector of predicted binary outcomes (0 or 1) for each observation.
#' @examples
#' X <- matrix(rnorm(20), ncol=2)
#' Beta <- runif(2)
#' predictions <- Logistic_Predict(X, Beta)
#'
#' X = matrix(c(1, 2, 3, 4), ncol = 2)
#' Beta = c(0.5, -0.5)
#' expected = c(0, 0)
#' result = Logistic_Predict(X, Beta)
#' all.equal(result, expected,tolerance = 0.0001)
#' @export


# Prediction function using the logit model
Logistic_Predict = function(X, Beta, thre = 0.5) {
  Miu = Logit(X, Beta)
  return(as.numeric(Miu > thre))
}
