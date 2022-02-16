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
