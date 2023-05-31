#' measure all images in a directory
#'
#' @import reticulate
#' @export
#' @param path path to directory. string. See Details for more info.
#' @param write_images write images to png? boolean
#' @param eye_method use eye method when possible? boolean
#' @param scaling_factor scale measurements to other unit. boolean. See Details for more info
#'
#' @details
#' path must contain images in either png or jpg format. note that subdirectories will be ignored (not recursive).
#' scaling_factor describes how many pixels occur in one other unit.
#' editme!
#'
#' @examples
#' \dontrun{
#' measure_directory("path/to/directory")
#' # scale images to other unit
#' measure_directory("path/to/directory", scaling_factor = FALSE)
#' }
#'
measure_directory <- function(
  path,
  write_images = TRUE,
  eye_method = TRUE,
  scaling_factor = FALSE
) {
  if (!is.character(path)) stop(sprintf("path must be character not: %s", typeof(path)))
  if (!dir.exists(path)) stop(sprintf("The directory: %s does not exist", path))
  if (!is.logical(write_images)) stop(sprintf("write_images must be logical, not: %s", typeof(write_images)))
  if (!is.logical(eye_method)) stop(sprintf("eye_method must be logical, not: %s", typeof(eye_method)))
  if (!is.logical(scaling_factor)) stop(sprintf("scaling_factor must be logical, not: %s", typeof(scaling_factor)))

  # import daphniaruler function
  dr <- reticulate::import("daphruler")
  # call daphniaruler
  dr$daphniaruler(
    path = path,
    noImages = !write_images,
    eyeMethod = eye_method,
    scaleMM = scaling_factor
  )
}
