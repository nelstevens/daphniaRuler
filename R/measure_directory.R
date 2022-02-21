#' measure all images in a directory
#'
#' @param path path to directory
#'
measure_directory <- function(path) {
  if (!is.character(path)) stop(sprintf("path must be character not: %s", typeof(path)))
  if (!dir.exists(path)) stop(sprintf("The directory: %s does not exist", path))

  # transform path for python
  pth_py <- ospath(path)
}
