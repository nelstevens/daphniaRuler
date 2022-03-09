test_that("measure_directory works", {
  expect_error(measure_directory(1.5))
  expect_error(measure_directory(10L))
  expect_error(measure_directory(TRUE))
  expect_error(measure_directory("wrong/directory"))
  expect_error(measure_directory(corrpath_dir, eye_method = "one"))
  expect_error(measure_directory(corrpath_dir, write_images = "one"))
  expect_error(measure_directory(corrpath_dir, scaling_factor = "bogus"))
  # expect warning with eye method
  expect_warning(measure_directory(corrpath_dir, write_images = F))
  # outputs a list
  expect_type(suppressWarnings(measure_directory(corrpath_dir, write_images = F)), "list")
  expect_type(measure_directory(corrpath_dir, eye_method = FALSE, write_images = F), "list")
  # snapshot test
  expect_snapshot(measure_directory(corrpath_dir, write_images = F, eye_method = F), variant = Sys.info()[["sysname"]])
  expect_snapshot(suppressWarnings(measure_directory(corrpath_dir, write_images = F, eye_method = T)), variant = Sys.info()[["sysname"]])
  expect_snapshot(measure_directory(corrpath_dir, write_images = T, eye_method = F), variant = Sys.info()[["sysname"]])
  expect_snapshot(suppressWarnings(measure_directory(corrpath_dir, write_images = T, eye_method = T)), variant = Sys.info()[["sysname"]])
})
