#' Measure morphometric traits of a single image
#'
#' @import reticulate
#' @param path path to image either absolute or relative
#' @param method what method of measurement to use either eye or head
#'
measure_image <- function(
  path = system.file(
    "inst/sample_images/cam1_05135_2018-10-21_09-36-20.JPG",
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
  # use_virtualenv("dphrl", required = TRUE) # FIXME: dont hardcode
  # import daphnia ruler
  dr <- reticulate::import("daphruler")

  # # if elipse use elipse method
  # if (method == "eye") {
  #   browser()
  #   res <- eye_method_2(path) # FIXME: importing utils on py side not working
  # }
  # else {
  #
  # }
}
