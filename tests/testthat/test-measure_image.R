test_that("pltimage works", {
  vdiffr::expect_doppelganger("pltimg", pltimg(test_data$test_arra))
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

test_that("measure_image works", {
  corrpath <- system.file(
    "inst/sample_images/example1.JPG",
    package = "dphrl"
  )
  # inexistent path leads to error
  expect_error(measure_image("/some/wrong/path"))
  # find eye must be logical
  expect_error(measure_image(corrpath, find_eye = "no"))
  expect_error(measure_image(corrpath, find_eye = 2))
  # plot image must be logical
  expect_error(measure_image(corrpath, plot_image = "no"))
  expect_error(measure_image(corrpath, plot_image = 2))
  # outputs a list
  expect_type(measure_image(corrpath), "list")
})
