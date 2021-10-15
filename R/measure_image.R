#' Measure morphometric traits of a single image
#'
#' @import reticulate
#'
measure_image <- function() {
  browser()
  # use virtualenv
  use_virtualenv("dphrl", required = TRUE) # FIXME: dont hardcode
  source_python(
    system.file(
      "python/The-Daphnia-ruler/measurement_methods_r.py",
      package = "dphrl"
    )
  )
}
