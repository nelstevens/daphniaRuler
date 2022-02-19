test_that(".onLoad activates corect conda enviroment and daphruler can be imported", {
  expect_true("daphniaruler" %in% reticulate::conda_list()$name)
  expect_true(grepl(packageName(), reticulate::py_config()$python))
  expect_error(reticulate::import("daphruler"), NA)
})
