#' Diagonal Multiplication of a Matrix and a Vector
#'
#' Internally used function that performs a diagonal multiplication of a matrix `X` and a vector `W`. This operation multiplies each column of `X` by the corresponding element in `W`.
#'
#' @param X A numeric matrix where each column represents a variable and each row represents an observation.
#' @param W A numeric vector of the same length as the number of rows in `X`.
#' @return A numeric matrix with the same dimensions as `X`, where each column of `X` has been element-wise multiplied by the corresponding value in `W`.
#' @noRd
#'
#' @examples
#' X = matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
#' W = c(-1, -2)
#' expected = matrix(c(-1, -3, -4, -8), nrow = 2, ncol = 2)
#' result = Diagonol_Multiply(X, W)


# Function to multiply diagonally for a matrix and a vector
Diagonol_Multiply = function(X, W) {
  n = dim(X)[1]
  X_T = t(X)
  Scaled_X = X_T
  if (length(W) != n) {
    stop("Error: The number of rows in X must be equal to the length of W.")
  }
  for(i in 1:n) {
    Scaled_X[, i] = X_T[, i] * W[i]
  }
  return(Scaled_X)
}
