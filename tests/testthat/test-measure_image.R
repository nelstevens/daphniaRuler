test_that("pltimage works", {
  vdiffr::expect_doppelganger("pltimg", pltimg(test_data$test_arra))
  expect_error(pltimg(test_data$test_arra, save = T, path = "./smpl.png"), NA)
})
test_that("ospath works", {
  if (Sys.info()[["sysname"]] == "Windows") {
    expect_equal(
      ospath("C:/Users/Nelson/Desktop/ruler/dphrl"),
      "C:\\Users\\Nelson\\Desktop\\ruler\\dphrl"
      )
  } else {
    expect_equal(
      ospath("/c/Users/Nelson/Desktop/ruler/dphrl"),
      "/c/Users/Nelson/Desktop/ruler/dphrl"
    )
  }
})

test_that("scale_measurement works", {
  res_in <- list(
    perimeter = 1200,
    area = 30000,
    minor = 202,
    full.Length = 423,
    tail.Length = 134,
    eye.Length = 416
  )
  expect_snapshot(scale_measurement(res_in, scf = 101, eym = T))
  expect_snapshot(scale_measurement(res_in, scf = 101, eym = F))
})

test_that("measure_image works", {
  # inexistent path leads to error
  expect_error(measure_image("/some/wrong/path"))
  # find eye must be logical
  expect_error(measure_image(corrpath, find_eye = "no"))
  expect_error(measure_image(corrpath, find_eye = 2))
  # plot image must be logical
  expect_error(measure_image(corrpath, plot_image = "no"))
  expect_error(measure_image(corrpath, plot_image = 2))
  # scaling_factor must be numerig
  expect_error(measure_image(corrpath, scaling_factor = "bogus"))
  # outputs a list
  expect_type(measure_image(corrpath), "list")
  expect_type(measure_image(corrpath, find_eye = FALSE), "list")

  expect_type(suppressWarnings(measure_image(corrpath_head)), "list")
  expect_type(measure_image(corrpath_head, find_eye = FALSE), "list")

  # expect warning on fall back to head_method
  expect_warning(measure_image(corrpath_head))
  
  # snapshot tests
  lst <- measure_image(corrpath, plot_image = FALSE)
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])
  lst <- measure_image(corrpath, plot_image = FALSE, find_eye = FALSE)
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])
  lst <- suppressWarnings(measure_image(corrpath_head, plot_image = FALSE))
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])
  lst <- measure_image(corrpath_head, plot_image = FALSE, find_eye = FALSE)
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(measure_image(corrpath_head, plot_image = FALSE, find_eye = FALSE), variant = Sys.info()[["sysname"]])
  lst <- measure_image(corrpath, plot_image = FALSE, scaling_factor = 103)
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])
  lst <- measure_image(corrpath, plot_image = FALSE, find_eye = FALSE, scaling_factor = 103)
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])
  lst <- suppressWarnings(measure_image(corrpath_head, plot_image = FALSE, scaling_factor = 103))
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])
  lst <- measure_image(corrpath_head, plot_image = FALSE, find_eye = FALSE, scaling_factor = 103)
  lst <- purrr::map_if(lst, \(x) {length(x) == 1 && is.numeric(x)}, \(x) {round(x, 2)})
  expect_snapshot(lst, variant = Sys.info()[["sysname"]])

})
