library(testthat)
context("test auxiliary functions")

test_that("aux_mean works as expected",{
  expect_equal(aux_mean(10,0.2),2)
  expect_length(aux_mean(15,0.5),1)
  expect_error(aux_mean(4,9))
})

test_that("aux_variance works as expected",{
  expect_equal(aux_variance(10,0.2),1.8)
  expect_length(aux_variance(10,0.5), 1)
  expect_error(aux_variance(-2, 0.4))
})

test_that("aux_mode works as expected",{
  expect_equal(aux_mode(20,0.2), 2)
  expect_length(aux_mode(10,0.5),1)
  expect_error(aux_mode(-8, 0.3))
})

test_that("aux_skewness works as expected",{
  expect_error(aux_skewness(8, 2))
  expect_length(aux_skewness(10,0.2),1)
  expect_type(aux_skewness(10,0.3), 'double')
})

test_that("aux_kurtosis works as expected",{
  expect_length(aux_kurtosis(12,0.5),1)
  expect_type(aux_kurtosis(10,0.2),"double")
  expect_error(aux_kurtosis(10, -0.2))
})
