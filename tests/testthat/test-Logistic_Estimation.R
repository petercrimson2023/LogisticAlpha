library(testthat)


# Test Case 1: Valid Inputs
test_that("Valid Inputs", {
  set.seed(123)
  X <- matrix(rnorm(20), nrow = 10, ncol = 2)
  y <- rbinom(10, 1, 0.5)
  temp_df = data.frame(x1=X[,1], x2=X[,2], y=y)
  glm_result <- glm(y ~ x1 + x2, data = temp_df, family = binomial(link = "logit"))
  glm_beta <- as.vector(glm_result$coefficients)
  result <- Logistic_Estimation(X, y)
  expect_equal(result$Coefficients$Estimate,glm_beta,tolerance = 1e-6)
})

# Test Case 2: Mismatched Dimensions
test_that("Mismatched Dimensions", {
  set.seed(123)
  X <- matrix(rnorm(20), nrow = 10, ncol = 2)
  y <- rbinom(9, 1, 0.5) # Length of y is 9, not 10
  result <- capture.output(output <- Logistic_Estimation(X, y))
  expect_true(grepl("Dimension Error",result))
  expect_equal(output, -1)
})

# Test Case 3: Single Predictor and Response
test_that("Single Predictor and Response", {
  set.seed(123)
  X <- matrix(rnorm(10), nrow = 10, ncol = 1)
  y <- rbinom(10, 1, 0.5)
  result <- Logistic_Estimation(X, y)
  expect_type(result, "list")
  expect_equal(length(result$beta), 2) # Intercept + 1 predictor
})

# Test Case 4: Multiple Iterations
test_that("Multiple Iterations", {
  set.seed(123)
  X <- matrix(rnorm(40), nrow = 20, ncol = 2)
  y <- rbinom(20, 1, 0.5)
  result <- Logistic_Estimation(X, y)
  expect_true(result$times > 1)
})

# Test Case 5: Non Convergence
test_that("Non Convergence", {
  set.seed(38)
  X = matrix(rnorm(100), ncol = 5)
  y = rbinom(20, 1, 0.5)
  result = Logistic_Estimation(X, y)
  expect_true(result == -1)
}
)

#
# set.seed(38)
# X = matrix(rnorm(100), ncol = 5)
# y = rbinom(20, 1, 0.5)
# result = Logistic_Estimation(X, y)
# result$Coefficients$Estimate
#
#
