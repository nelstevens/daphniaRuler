#' measure all images in a directory
#'
#' @import purrr
#' @import stringr
#' @importFrom tibblify tibblify
#' @import progress
#' @import futile.logger
#' @export
#' @param path path to directory. string. See Details for more info.
#' @param write_images write images to png? boolean
#' @param eye_method use eye method when possible? boolean
#' @param scaling_factor scale measurements to other unit. numeric. See Details for more info
#'
#' @details
#' path must contain images in either png or jpg format. note that subdirectories will be ignored (not recursive).
#' scaling_factor describes how many pixels occur in one other unit.
#' For example if one mm corresponds to 100 pixels the scaling factor would be 100.
#' You can calculate the scaling factor by taking images of a graticule and count how many
#' pixels are in a unit of length with an image analysis tool such as imageJ.
#'
#' @examples
#' \dontrun{
#' measure_directory("path/to/directory")
#' # scale images to other unit
#' measure_directory("path/to/directory", scaling_factor = 134)
#' }
#'
measure_directory <- function(
  path = "C:/Users/Nelson/Desktop/test_dr/test_images",
  write_images = TRUE,
  eye_method = TRUE,
  scaling_factor = NULL
) {
  if (!is.character(path)) stop(sprintf("path must be character not: %s", typeof(path)))
  if (!dir.exists(path)) stop(sprintf("The directory: %s does not exist", path))
  if (!is.logical(write_images)) stop(sprintf("write_images must be logical, not: %s", typeof(write_images)))
  if (!is.logical(eye_method)) stop(sprintf("eye_method must be logical, not: %s", typeof(eye_method)))
  if (!(is.null(scaling_factor) | is.numeric(scaling_factor))) stop(sprintf("scaling_factor must be NULL or numeric, not: %s", typeof(scaling_factor)))

  # get files
  fls <- list.files(path, pattern = "\\.(JPG|jpg|jpeg|JPEG|png|PNG)", full.names = TRUE, include.dirs = FALSE)


  # make results directory
  dir.create(paste0(path, "/results"), showWarnings = FALSE)
  #initiate progressbar
  pb <- progress::progress_bar$new(
    total = length(fls),
    format = "[:bar] :current/:total (:percent)"
  )
  # create logfile to log warnings and errors
  flog.appender(appender.file(paste0(path, "/results/log.txt")))

  # create output paths if write_images
  if (write_images) {
    out_pths <- map(
      fls,
      function(x) {
        splts <- str_split(x, "/", simplify = TRUE)
        nme <- str_replace(splts[length(splts)], "\\..*", "_result.png")
        newfname <- paste0(str_c(splts[1:length(splts) - 1], collapse = "/"), "/results/", nme)
      }
    )
    out <- map2(
      fls,
      out_pths,
      function(x, y) {
        pb$tick()
        han_measure(x, y, eye_method, scaling_factor)
      }
    )
  } else {
    out <- map(
      fls,
      function(x) {
        pb$tick()
        han_measure(path = x, eye_method = eye_method, scf = scaling_factor)
      }
    )
  }
  # tibblify
  tbl <- tibblify(out)
  # write to csv
  dname <- basename(path)
  write.csv2(tbl, paste0(path, "/results/", dname, "_results.csv"))

  return(out)
}

#' measure with calling handler
#'
#' @noRd
han_measure <- function(path, out_path = NULL, eye_method, scf) {
  withCallingHandlers(
    mul_measure(
      path = path,
      out_path = out_path,
      eye_method = eye_method,
      scf = scf
    ),
    warning = function(msg) {
      flog.warn(msg$message)
    },
    error = function(msg) {
      warn(msg$message)
      flog.warn(msg$message)
    }
  )
}


#' measure without plotting and exporting array
#'
#'
#' @noRd
mul_measure <- function(path, eye_method = TRUE, out_path = NULL, scf) {
  res <- measure_image(path, find_eye = eye_method, plot_image = FALSE, scaling_factor = scf)

  if (!is.null(out_path)) {
    pltimg(res$image, save = TRUE, path = out_path)
  }
  res <- res[names(res) != "image"]
  return(res)
}

