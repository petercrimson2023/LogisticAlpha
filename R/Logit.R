#' Calculate Logit Values
#'
#' This function calculates logit values for a given set of predictors and coefficients. It is designed to handle extreme values in the exponentiation to avoid computational errors.
#'
#' @param X A numeric matrix of predictors where each row represents an observation and each column represents a predictor variable.
#' @param beta A numeric vector of coefficients corresponding to the predictor variables.
#' @return A numeric vector of logit values. When handling extreme values, the function adjusts the computation to maintain numerical stability.
#' @examples
#' X <- matrix(rnorm(20), ncol=2)
#' beta <- runif(2)
#' logit_values <- Logit(X, beta)
#' @export

# Define the logit function
Logit = function(X, beta) {
  # Calculate the logit values
  logits <- X %*% beta

  # Handling extreme values in the exponentiation
  if (sum(exp(-logits) == 0) > 0) {
    a = max(logits)
    y <- exp((X %*% beta) - a)
    prob_0 <- exp(-a) / (exp(-a) + sum(y))
    probs <- y / (exp(-a) + sum(y))
    return(c(prob_0, probs))
  } else {
    z = X %*% beta
    p = ifelse(z > 0, 1 / (1 + exp(-z)), exp(z) / (1 + exp(z)))
    return (as.vector(p))
  }
}
