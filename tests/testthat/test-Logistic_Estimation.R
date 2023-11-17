library(testthat)


# Test Case 1: Valid Inputs
test_that("Valid Inputs", {
  X <- matrix(rnorm(20), nrow = 10, ncol = 2)
  y <- rbinom(10, 1, 0.5)
  result <- Logistic_Estimation(X, y)
  glm_beta <- c(0.69761989,0.07691081, -1.38142749)
  expect_equal(result$Coefficients$Estimate,glm_beta,tolerance = 1e-6)
})

# Test Case 2: Mismatched Dimensions
test_that("Mismatched Dimensions", {
  X <- matrix(rnorm(20), nrow = 10, ncol = 2)
  y <- rbinom(9, 1, 0.5) # Length of y is 9, not 10
  result <- capture.output(output <- Logistic_Estimation(X, y))
  expect_true(grepl("Dimension Error",result))
  expect_equal(output, -1)
})

# Test Case 3: Single Predictor and Response
test_that("Single Predictor and Response", {
  X <- matrix(rnorm(10), nrow = 10, ncol = 1)
  y <- rbinom(10, 1, 0.5)
  result <- Logistic_Estimation(X, y)
  expect_type(result, "list")
  expect_equal(length(result$beta), 2) # Intercept + 1 predictor
})

# Test Case 4: Multiple Iterations
test_that("Multiple Iterations", {
  X <- matrix(rnorm(40), nrow = 20, ncol = 2)
  y <- rbinom(20, 1, 0.5)
  result <- Logistic_Estimation(X, y)
  expect_true(result$times > 1)
})


