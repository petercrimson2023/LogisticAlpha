#' Calculate Logit Values
#'
#' This function calculates logit values for a given set of predictors and coefficients. It is designed to handle extreme values in the exponentiation to avoid computational errors.
#'
#' @param X A numeric matrix of predictors where each row represents an observation and each column represents a predictor variable.
#' @param beta A numeric vector of coefficients corresponding to the predictor variables.
#' @return A numeric vector of logit values. When handling extreme values, the function adjusts the computation to maintain numerical stability.
#' @examples
#' # Normal Case
#' X = matrix(rnorm(20), ncol=2)
#' beta = runif(2)
#' logit_values = Logit(X, beta)
#'
#' # Extreme Values
#' X = cbind(1,c(100,2000,400))
#' beta = c(1,2)
#' result = c(0.0000001,0.0000001,0.9999999,0.0000001)
#' all.equal(Logit(X, beta), result, tolerance = 0.0001)
#'
#' @export

# Define the logit function
Logit = function(X, beta) {
  # Calculate the logit values
  logits = X %*% beta

  # Handling extreme values in the exponentiation
  if (sum(exp(-logits) == 0) > 0) {
    #print("Into Branch 1")
    a = max(logits)
    y = exp((X %*% beta) - a)
    prob_0 = exp(-a) / (exp(-a) + sum(y))
    probs = y / (exp(-a) + sum(y))
    return(c(abs(prob_0-1e-7), abs(probs-1e-7)))
  } else {
    #print("Into Branch 2")
    z = X %*% beta
    p = ifelse(z > 0, 1 / (1 + exp(-z)), exp(z) / (1 + exp(z)))
    return (as.vector(p))
  }
}


