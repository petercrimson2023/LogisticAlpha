

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

# Function to multiply diagonally for a matrix and a vector
Diagonol_Multiply = function(X, W) {
  n = dim(X)[1]
  X_T = t(X)
  Scaled_X = X_T
  for(i in 1:n) {
    Scaled_X[, i] = X_T[, i] * W[i]
  }
  return(Scaled_X)
}

# Prediction function using the logit model
Logistic_Predict = function(X, Beta, thre = 0.5) {
  Miu = Logit(X, Beta)
  return(as.numeric(Miu > thre))
}

# Logistic regression estimation function
Logistic_Estimation = function(X, y) {
  n = dim(X)[1]
  p = dim(X)[2]

  X = cbind(rep(1, times = n), as.matrix(X))
  y = as.vector(y)

  # Check if dimensions of y and X are compatible
  if (length(y) != n) {
    print("Dimension Error")
    return (-1)
  }

  # Initialize parameters
  Beta_Old = rep(0, times = p + 1)
  delta = 1
  Times = 1

  # Newton-Raphson Iteration for coefficient estimation
  while (delta > 1e-7) {
    Miu = Logit(X, Beta_Old)
    Var_Logit = Miu * (1 - Miu)
    Scaled_X = Diagonol_Multiply(X, Var_Logit)
    J = Scaled_X %*% X # Fisher Information Matrix
    z = (y - Miu) / Var_Logit
    J_inv = solve(J)
    Beta_New = Beta_Old + as.vector(J_inv %*% Scaled_X %*% z)
    delta = max(abs(Beta_Old - Beta_New))
    Times = Times + 1
    Beta_Old = Beta_New
  }

  # Predict and calculate confusion matrix
  y_pred = Logistic_Predict(X, Beta_Old)
  TP_rate = sum(y == 1 & y_pred == 1) / n
  FP_rate = sum(y == 0 & y_pred == 1) / n
  TN_rate = sum(y == 0 & y_pred == 0) / n
  FN_rate = sum(y == 1 & y_pred == 0) / n
  confusion_matrix = matrix(c(TP_rate, FP_rate, FN_rate, TN_rate), nrow = 2, byrow = TRUE)
  colnames(confusion_matrix) <- c("Predicted Positive Rate", "Predicted Negative Rate")
  rownames(confusion_matrix) <- c("Actual Positive Rate", "Actual Negative Rate")

  # Calculate standard errors, Z-scores, and p-values
  Names = c("Intercept", colnames(X)[1:p + 1])
  StdErr = sqrt(diag(J_inv))
  Z_Score = Beta_Old / StdErr
  P_Value = 2 * pnorm(-abs(Z_Score))
  result_frame = data.frame(Estimate = Beta_Old, Std_Err = StdErr, Z_Score = Z_Score, p = P_Value)
  rownames(result_frame) = Names

  # Print results
  print("Coefficients:")
  print(result_frame)
  print(paste0("Iteration times: ", Times))
  print("Confusion Matrix:")
  print(confusion_matrix)
  print("Fisher Information Matrix")
  print(J)

  # Return a list of results
  return(list(Coefficients = result_frame, beta = Beta_Old, y_pred = y_pred, times = Times, J = J, J_inv = J_inv, delta = delta, confusion_matrix =
                confusion_matrix))

}
