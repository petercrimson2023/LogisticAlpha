library(testthat)

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

# Test Case 1: Regular Case (Above Threshold)
test_that("Regular Case (Above Threshold)", {
  X = matrix(c(1, 2, 3, 4), ncol = 2)
  Beta = c(0.5, -0.5)
  expected = c(0, 0)
  result = Logistic_Predict(X, Beta)
  expect_true(all.equal(result, expected))
})

# Test Case 2: Regular Case
test_that("Regular Case (Below Threshold)", {
  X = matrix(c(-1, -2, -3, -4), ncol = 2)
  Beta = c(0.5, -0.5)
  expected = c(1, 1)
  result = Logistic_Predict(X, Beta)
  expect_true(all.equal(result, expected))
})

# Test Case 3: Custom Threshold
test_that("Custom Threshold", {
  X = matrix(c(1, 2, 3, 4), ncol = 2)
  Beta = c(0.5, -0.5)
  thre = 0.7
  expected = c(0, 0)
  result = Logistic_Predict(X, Beta, thre)
  expect_true(all.equal(result, expected))
})

# Test Case 4: Extreme Values in X
test_that("Extreme Values in X", {
  X = matrix(c(100, 200, 300, 400), ncol = 2)
  Beta = c(1, 1)
  expected = c(1, 1)
  result = Logistic_Predict(X, Beta)
  expect_true(all.equal(result, expected))
})

# Test Case 5: Single Element in X and Beta
test_that("Single Element in X and Beta", {
  X = matrix(1, ncol = 1)
  Beta = 1
  expected = 1
  result = Logistic_Predict(X, Beta)
  expect_true(all.equal(result, expected))
})
