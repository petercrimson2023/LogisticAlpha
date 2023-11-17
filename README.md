
<!-- badges: start -->
[![R-CMD-check](https://github.com/petercrimson2023/LogisticAlpha/actions/workflows/R-CMD-check.yaml/badge.svg?branch=Master)](https://github.com/petercrimson2023/LogisticAlpha/actions/workflows/R-CMD-check.yaml)

[![Codecov test coverage](https://codecov.io/gh/petercrimson2023/LogisticAlpha/branch/Master/graph/badge.svg?branch=Master)](https://app.codecov.io/gh/petercrimson2023/LogisticAlpha?branch=Master)

[![R-CMD-check](https://github.com/petercrimson2023/LogisticAlpha/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/petercrimson2023/LogisticAlpha/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


# R Package for Logistic Regression Analysis

This R package provides a set of functions for performing logistic regression analysis, including computation of logit values, logistic prediction, and logistic regression estimation. It is designed for users who need robust and efficient tools for statistical analysis in R.

## Functions Included

1. **`Logit`**: Calculates logit values based on input matrix `X` and coefficient vector `beta`. Handles extreme values in the exponentiation to avoid computational errors.

2. **`Diagonol_Multiply`**: Performs a diagonal multiplication of a matrix `X` and a vector `W`, useful in logistic regression calculations.

3. **`Logistic_Predict`**: Predicts outcomes using the logistic model. Takes a matrix `X`, coefficient vector `Beta`, and a threshold `thre` to return predictions.

4. **`Logistic_Estimation`**: Estimates logistic regression parameters using the Newton-Raphson method. It returns a comprehensive list of results including coefficients, confusion matrix, Fisher Information Matrix, and more.

## Usage 

### Sample data


set.seed(123)
X = matrix(rnorm(100), ncol=2)
y = rbinom(50, 1, 0.5)


### Logistic Regression Estimation


result = Logistic_Estimation(X, y)


#### View results

print(result$Coefficients)

## Installation 

### Using devtools::install_github() 

install.packages("devtools")

library(devtools)

install_github("https://github.com/petercrimson2023/LogisticAlpha/",ref="Master")








