#' measure all images in a directory
#'
#' @import purrr
#' @import stringr
#' @importFrom tibblify tibblify
#' @import progress
#' @import futile.logger
#' @export
#' @param path path to directory
#' @param write_images write images to png? boolean
#' @param eye_method use eye method when possible? boolean
#'
measure_directory <- function(
  path = "C:/Users/Nelson/Desktop/test_dr/test_images",
  write_images = TRUE,
  eye_method = TRUE
) {
  if (!is.character(path)) stop(sprintf("path must be character not: %s", typeof(path)))
  if (!dir.exists(path)) stop(sprintf("The directory: %s does not exist", path))
  if (!is.logical(write_images)) stop(sprintf("write_images must be logical, not: %s", typeof(write_images)))
  if (!is.logical(eye_method)) stop(sprintf("eye_method must be logical, not: %s", typeof(eye_method)))

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
        withCallingHandlers(
          mul_measure(
            path = x,
            out_path = y,
            eye_method = eye_method
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
    )
  } else {
    out <- map(
      fls,
      function(x) {
        pb$tick()
        withCallingHandlers(
          mul_measure(
            path = x,
            eye_method = eye_method
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
    )
  }
  # tibblify
  tbl <- tibblify(out)
  # write to csv
  dname <- basename(path)
  write.csv2(tbl, paste0(path, "/results/", dname, "_results.csv"))

  return(out)
}

#' measure without plotting and exporting array
#'
#'
#' @noRd
mul_measure <- function(path, eye_method = TRUE, out_path = NULL) {
  res <- measure_image(path, find_eye = eye_method, plot_image = FALSE)

  if (!is.null(out_path)) {
    pltimg(res$image, save = TRUE, path = out_path)
  }
  res <- res[names(res) != "image"]
  return(res)
}
