#' Measure morphometric traits of a single image
#'
#' @import reticulate
#' @param path path to image either absolute or relative
#' @param find_eye try to find eye of daphnia? boolean
#' @param plot_image whether or not to plot resulting image. boolean
#'
measure_image <- function(
  path = system.file(
    "inst/sample_images/example1.JPG",
    package = "daphniaruler"
    ),
  find_eye = TRUE,
  plot_image = TRUE
) {
  # check if image file exists
  if (!file.exists(path)) stop(sprintf("file %s does not exist", path))
  # check if method either ellipse or head
  if (!is.logical(find_eye)) {
    stop(sprintf("find_eye musst be logical not %s", typeof(find_eye)))
  }
  # check if plot_image is bool
  if (!is.logical(plot_image)) {
    stop(sprintf("plot_image musst be logical not %s", typeof(find_eye)))
  }
  # transform path if necessary
  path <- ospath(path)
  # import daphruler
  dr <- reticulate::import("daphruler")
  # make measurement methods available
  py_run_string("from daphruler import measurement_methods")
  if (find_eye) {
    res <- dr$measurement_methods$eye_method_2(path)
  } else {
    res <- dr$measurement_methods$head_method(path)
  }

  if (plot_image) {
    pltimg(res$image)
  }


  return(res)
}

#' plot image array
#'
#' @noRd
pltimg <- function(arr) {
  nor <- arr / 256
  plot.new()
  rasterImage(
    nor,
    xleft = 1,
    xright = 0,
    ybottom = 0,
    ytop = 1
  )
}


#' transform path depending on platform
#'
#' @noRd
ospath <- function(path) {
  if (Sys.info()[["sysname"]] == "Windows") {
    new_path <- stringr::str_replace_all(path, "/", "\\\\")
    return(new_path)
  } else {
    return(path)
  }
}
