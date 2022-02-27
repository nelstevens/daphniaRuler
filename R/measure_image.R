#' Measure morphometric traits of a single image
#'
#' @import reticulate
#' @param path path to image either absolute or relative
#' @param find_eye try to find eye of daphnia?
#'  if eye can't be found automatically falls back to only outline measurement. boolean
#' @param plot_image whether or not to plot resulting image. boolean
#'
#' @examples
#' \dontrun{
#' measure_image("path/to/image")
#' }
#' @export
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
    res <- tryCatch({
    dr$measurement_methods$eye_method_2(path)},
    error = function(m) {
      warning(sprintf("eye method failed with: %s \n using head_method instead", m))
      res <- tryCatch(
        dr$measurement_methods$head_method(path),
        error = function(m) {
          warning(sprintf("head_method also failed with: %s. skipping image", m))
        }
      )
      return(res)
    }
    )
  } else {
    res <- tryCatch(
      dr$measurement_methods$head_method(path),
      error = function(m) {
        warning(sprintf("head_method failed with: %s. skipping image", m))
      }
    )
    return(res)
  }

  if (plot_image) {
    pltimg(res$image)
  }


  return(res)
}

#' plot image array
#'
#' @importFrom grDevices dev.off png
#' @importFrom graphics par plot.new rasterImage
#'
#' @noRd
pltimg <- function(arr, save = FALSE, path = NULL) {
  nor <- arr / 256
  if (save) {
    png(
      path,
      width = dim(nor)[2],
      height = dim(nor)[1]
      )
  }
  par(mar = c(0,0,0,0), xaxs="i", yaxs="i")
  plot.new()
  rasterImage(
    nor,
    xleft = 1,
    xright = 0,
    ybottom = 0,
    ytop = 1
  )
  if (save) {
    dev.off()
  }
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
