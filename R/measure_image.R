#' Measure morphometric traits of a single image
#'
#' @import reticulate
#' @param path path to image either absolute or relative
#' @param method what method of measurement to use either eye or head
#'
measure_image <- function(
  path = system.file(
    "python/The-Daphnia-ruler/tests/test_dirs/test_images/sample1.JPG",
    package = "dphrl"
    ),
  method = "eye"
) {
  # check if image file exists
  if (!file.exists(path)) stop(sprintf("file %s does not exist", path))
  # check if method either ellipse or head
  if (!(method %in% c("eye", "head"))) {
    stop(sprintf("%s is not a valid measurement method!", method))
  }
  # use virtualenv
  use_virtualenv("dphrl", required = TRUE) # FIXME: dont hardcode
  # source measurement_methods
  source_python(
    system.file(
      "python/The-Daphnia-ruler/measurement_methods_r.py",
      package = "dphrl"
    )
  )
  # if elipse use elipse method
  if (method == "eye") {
    browser()
    res <- eye_method_2(path) # FIXME: importing utils on py side not working
  }
  else {

  }
}
