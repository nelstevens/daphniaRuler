test_that("pltimage works", {
  vdiffr::expect_doppelganger("pltimg", pltimg(test_data$test_arra))
})
