## code to prepare `test-data` dataset goes here
test_data <- list()
test_data[["test_arra"]] <- measure_image()$image

usethis::use_data(test_data, overwrite = TRUE, internal = TRUE)
