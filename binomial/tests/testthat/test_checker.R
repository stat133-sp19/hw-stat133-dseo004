context("test checker")

test_that("check_prob works as expected",{

  expect_true(check_prob(0.5))
  expect_length(check_prob(0.5), 2)
  expect_true(check_prob(1))
  expect_error(check_prob(-2))
  expect_
})

test_that("check_trials works as expected",{

  expect_true(check_trials(1))
  expect_true(check_trials(3))
  expect_length(check_trials(10),1)
  expect_error(check_trials(-2))
  expect_error(check_trials(0.5))
})

test_that("check_success works as expected",{

  expect_true(check_success(c(1,2,3),6))
  expect_true(check_success(0,5))
  expect_length(check_success(1,12),1)
  expect_error(check_success(8,2))

})
