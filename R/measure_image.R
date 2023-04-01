#' Measure morphometric traits of a single image
#'
#' @import reticulate
#' @param path path to image either absolute or relative. string. See Details for more info.
#' @param find_eye try to find eye of daphnia?
#'  if eye can't be found automatically falls back to only outline measurement. boolean
#' @param plot_image whether or not to plot resulting image. boolean
#' @param scaling_factor scale measurements to other unit. numeric. See Details for more info
#'
#' @details
#' Currently only png and jpg formats are allowed as input images.
#' scaling_factor describes how many pixels occur in one other unit.
#' For example if one mm corresponds to 100 pixels the scaling factor would be 100.
#' You can calculate the scaling factor by taking images of a graticule ans see how many
#' pixels are in a unit of length with an image analysis tool such as imageJ.
#' @examples
#' \dontrun{
#' measure_image("path/to/image")
#' # scale images to other unit
#' measure_image("path/to/image", scaling_factor = 134)
#' }
#' @export
#'
measure_image <- function(
  path,
  find_eye = TRUE,
  plot_image = TRUE,
  scaling_factor = NULL
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
  if (!(is.null(scaling_factor) | is.numeric(scaling_factor))) stop(sprintf("scaling_factor must be NULL or numeric, not: %s", typeof(scaling_factor)))
  # transform path if necessary
  path <- ospath(path)
  # import daphruler
  dr <- reticulate::import("daphruler")
  # make measurement methods available
  if (find_eye) {
    res <- tryCatch({
    dr$eye_method_2(path)},
    error = function(m) {
      warning(sprintf("eye method failed for: %s using head_method instead", path))
      res <- tryCatch(
        dr$head_method(path),
        error = function(m) {
          warning(sprintf("head_method also failed for: %s. skipping image", path))
        }
      )
      return(res)
    }
    )
  } else {
    res <- tryCatch(
      dr$head_method(path),
      error = function(m) {
        warning(sprintf("head_method failed for: %s. skipping image", path))
      }
    )
  }

  if (plot_image) {
    pltimg(res$image)
  }
  if (!is.null(scaling_factor)) {
    res <- scale_measurement(
      res,
      scaling_factor,
      find_eye
    )
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

#' scale measurements
#'
#' @noRd
scale_measurement <- function(res, scf, eym) {
  res$perimeter <- res$perimeter / scf
  res$area <- res$area / scf^2
  res$minor <- res$minor / scf
  res$full.Length <- res$full.Length / scf
  if (eym) res$tail.Length <- res$tail.Length / scf
  if (eym) res$eye.Length <- res$eye.Length / scf

  return(res)
}
