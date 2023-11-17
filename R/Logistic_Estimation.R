#' Perform Logistic Regression Estimation
#'
#' This function performs logistic regression estimation using the
#' Newton-Raphson method. It estimates coefficients, calculates standard errors,
#' Z-scores, p-values, and generates a confusion matrix. The function also allows
#' printing the results.
#'
#' @param X A numeric matrix where each row represents an observation and each column
#' represents a predictor variable.
#' @param y A numeric vector of binary response variables (0 or 1) corresponding
#' to each row of X.
#' @param print_result Logical, indicating whether to print the results. Defaults to FALSE.
#'
#' @return A list containing various components:
#'   - Coefficients: A data frame of logistic regression coefficients, standard errors,
#'     Z-scores, and p-values.
#'   - beta: The final estimated coefficients.
#'   - y_pred: Predicted values based on the logistic model.
#'   - times: The number of iterations taken in the Newton-Raphson process.
#'   - J: The Fisher Information Matrix.
#'   - J_inv: The inverse of the Fisher Information Matrix.
#'   - delta: The final delta value in the iteration process.
#'   - confusion_matrix: A confusion matrix of the model.
#'
#' @export
#' @examples
#' set.seed(1)
#' X = matrix(rnorm(100), ncol = 5)
#' y =rbinom(20, 1, 0.5)
#' result =Logistic_Estimation(X, y)
#' print(result$Coefficients)
#' print(result$confusion_matrix)
#'
#'
#' X =matrix(rnorm(50), ncol = 5)
#' y =rbinom(10, 1, 0.5)
#' result =Logistic_Estimation(X, y, print_result = TRUE)
#' print(result$Coefficients)
#' print(result$confusion_matrix)


# Logistic regression estimation function
Logistic_Estimation = function(X, y,print_result = FALSE) {
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

    while (delta > 1e-7 && Times < 500 && !(NaN %in% Beta_Old))
    {
      #print(Times)
      Miu = Logit(X, Beta_Old)
      Var_Logit = Miu * (1 - Miu)
      Scaled_X = Diagonol_Multiply(X, Var_Logit)
      J = Scaled_X %*% X # Fisher Information Matrix
      z = (y - Miu) / Var_Logit

      qr_decomp = qr(J)
      J_inv = qr.solve(qr_decomp)

      #J_inv = solve(J)

      Beta_New = Beta_Old + as.vector(J_inv %*% Scaled_X %*% z)
      delta = max(abs(Beta_Old - Beta_New))
      Times = Times + 1
      Beta_Old = Beta_New

    }

    if (NaN %in% Beta_Old) {
      print("Error: The model does not converge.")
      return(-1)
    }

  # Predict and calculate confusion matrix
  y_pred = Logistic_Predict(X, Beta_Old)
  TP_rate = sum(y == 1 & y_pred == 1) / n
  FP_rate = sum(y == 0 & y_pred == 1) / n
  TN_rate = sum(y == 0 & y_pred == 0) / n
  FN_rate = sum(y == 1 & y_pred == 0) / n
  confusion_matrix = matrix(c(TP_rate, FP_rate, FN_rate, TN_rate), nrow = 2, byrow = TRUE)
  colnames(confusion_matrix) =c("Predicted Positive Rate", "Predicted Negative Rate")
  rownames(confusion_matrix) =c("Actual Positive Rate", "Actual Negative Rate")

  # Calculate standard errors, Z-scores, and p-values
  if (is.null(colnames(X))) {
    Names = c("Intercept", paste0("Var_", 1:p))
  } else {
    Names = c("Intercept", colnames(X)[1:p + 1])
  }
  StdErr = sqrt(diag(J_inv))
  Z_Score = Beta_Old / StdErr
  P_Value = 2 * pnorm(-abs(Z_Score))
  result_frame = data.frame(Estimate = Beta_Old, Std_Err = StdErr, Z_Score = Z_Score, p = P_Value)
  rownames(result_frame) = Names

  # Print results

  if (print_result) {
    print("Coefficients:")
    print(result_frame)
    print(paste0("Iteration times: ", Times-1))
    print("Confusion Matrix:")
    print(confusion_matrix)
    print("Fisher Information Matrix")
    print(J)
  }

  # Return a list of results
  return(list(Coefficients = result_frame, beta = Beta_Old, y_pred = y_pred, times = Times-1, J = J, J_inv = J_inv, delta = delta, confusion_matrix =
                confusion_matrix))

}
