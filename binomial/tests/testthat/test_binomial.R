library(testthat)


context("test binomial")


#bin_choose
test_that("bin_choose works as expected", {
  expect_equal(bin_choose(5, 2), 5)
  expect_error(bin_choose(-3,1))
  expect_error(bin_choose(1,4))
  expect_length(bin_choose(4, 2), 2)
})

#bin_probability
test_that("bin_probability works as expected", {
  expect_equal(bin_probability(2, 5, 0.5), 0.3125)
  expect_error(bin_probability(3,-1,0.5))
  expect_length(bin_probability(3, 7, 0.5), 2)
})

#bin_distribution
test_that("bin_distribution works as expected", {
  expect_error(bin_distribution(1:5,3 ,0.2))
  expect_error(bin_cumulative(4,2))
  expect_length(bin_distribution(10, 0.5), 2)
  expect_error(bin_distribution(1:4,-3, 0.5))
})

#bin_cumulative
test_that("bin_cumulative works as expected", {
  expect_type(bin_cumulative(trials = 15, prob = 0.5),"list")
  expect_length(bin_cumulative(trials = 10, prob = 0.5),3)
  expect_error(bin_cumulative(1:3 , -3, 0.1))
})
