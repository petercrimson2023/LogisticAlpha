library(testthat)

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


# Test Case 1: Regular values
test_that("Regular values", {
  X <- matrix(c(1, 2, 3, 4), ncol = 2)
  beta <- c(0.5, -0.5)
  expected <- c(0.2689414, 0.2689414)
  result <- Logit(X, beta)
  expect_true(all.equal(result, expected,tolerance = 1e-7))
})

# Test Case 2: Extreme positive values
test_that("Extreme positive values", {
  X <- matrix(c(100, 200, 300, 400), ncol = 2)
  beta <- c(1, 1)
  result <- Logit(X, beta)
  expect_true(length(result) == 2)
})

# Test Case 3: Extreme negative values
test_that("Extreme negative values", {
  X <- matrix(c(-100, -200, -300, -400), ncol = 2)
  beta <- c(1, 1)
  result <- Logit(X, beta)
  expect_true(length(result) == 2)
})

# Test Case 4: Zero values in X
test_that("Zero values in X", {
  X <- matrix(rep(0, 4), ncol = 2)
  beta <- c(1, 1)
  expected <- rep(0.5, 2)
  result <- Logit(X, beta)
  expect_true(all.equal(result, expected))
})

# Test Case 5: Zero coefficients in beta
test_that("Zero coefficients in beta", {
  X <- matrix(c(1, 2, 3, 4), ncol = 2)
  beta <- c(0, 0)
  expected <- rep(0.5, 2)
  result <- Logit(X, beta)
  expect_true(all.equal(result, expected))
})

# Test Case 6: Large X matrix
test_that("Large X matrix", {
  X <- matrix(runif(10000), ncol = 50)
  beta <- runif(50)
  result <- Logit(X, beta)
  expect_true(length(result) == 200)
})

# Test Case 7: Single element in X and beta
test_that("Single element in X and beta", {
  X <- matrix(1, ncol = 1)
  beta <- 1
  expected <- 0.7310586
  result <- Logit(X, beta)
  expect_true(all.equal(result, expected,tolerance = 1e-7))
})


test_that("X with NaN or Inf values", {
  X <- matrix(c(1, NaN, 3, Inf), ncol = 2)
  beta <- c(1, 1)
  expect_error(Logit(X, beta))
})
