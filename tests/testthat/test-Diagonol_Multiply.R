library(testthat)

# Test Case 1: Regular Case
test_that("Regular Case", {
  X = matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  W = c(2, 3)
  expected = matrix(c(2, 6, 6, 12), nrow = 2, ncol = 2)
  result = Diagonol_Multiply(X, W)
  expect_true(all.equal(result, expected))
})

# Test Case 2: Zero Weights
test_that("Zero Weights", {
  X = matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  W = c(0, 0)
  expected = matrix(rep(0, 4), nrow = 2, ncol = 2)
  result = Diagonol_Multiply(X, W)
  expect_true(all.equal(result, expected))
})

# Test Case 3: Negative Weights
test_that("Negative Weights", {
  X = matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  W = c(-1, -2)
  expected = matrix(c(-1, -3, -4, -8), nrow = 2, ncol = 2)
  result = Diagonol_Multiply(X, W)
  expect_true(all.equal(result, expected))
})

# Test Case 4: Single Element in X and W
test_that("Single Element in X and W", {
  X = matrix(5, nrow = 1, ncol = 1)
  W = 3
  expected = matrix(15, nrow = 1, ncol = 1)
  result = Diagonol_Multiply(X, W)
  expect_true(all.equal(result, expected))
})

# Test Case 5: Mismatched Dimensions
test_that("Mismatched Dimensions", {
  X = matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  W = c(1, 2, 3) # W has more elements than the number of rows in X
  expect_error(Diagonol_Multiply(X, W))
})
