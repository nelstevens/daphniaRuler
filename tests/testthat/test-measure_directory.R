test_that("measure_directory works", {
  expect_error(measure_directory(1.5))
  expect_error(measure_directory(10L))
  expect_error(measure_directory(TRUE))
  expect_error(measure_directory("wrong/directory"))
})
