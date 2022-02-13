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
  out <- head_method(path)

  # if elipse use elipse method
  if (method == "eye") {
    #res <- eye_method_2(path) # FIXME: importing utils on py side not working
  }
  else {
    res <- head_method(path)
  }
}

#' measure using head methods
#'
#' @import reticulate
#' @noRd
head_method <- function(
  path = system.file(
    "inst/sample_images/cam1_05135_2018-10-21_09-36-20.JPG",
    package = "dphrl"
  )
  ) {
  # import daphruler
  dr <- reticulate::import("daphruler")

  # import and resize
  img_res <- dr$utils$import_image(path)

  # define output into different variables
  img <- img_res[["img"]]
  gray <- img_res[["gray"]]
  scf <- img_res[["scf"]]

  # create mask
  edges <- dr$utils$create_mask(gray)

  # create regionproperties
  props <- dr$utils$create_props(edges, gray)

  # erode mask and return new properties
  propsls <- dr$utils$erode_mask(edges, props, gray)

  # split up propsls
  props <- propsls[[1]]
  edges_res <- propsls[[2]]
  label_img <- propsls[[3]]

  # plot binary image
  binary2 <- dr$utils$plt_binary(edges_res, label_img, props)

  # FIXME: plot mask contour on image not working
  #img <- dr$utils$plt_contour(binary2, img)

  # plot elipse on image
  img <- dr$utils$plt_elipse(img, props)

  # plot major axis of fitted elipse
  img <- dr$utils$plt_majaxis(img, props)

  # plot minor axis of fitted elipse
  img <- dr$utils$plt_minaxis(img, props)

  # get major and minor axis
  major <-  props[[1]]$major_axis_length
  minor <-  props[[1]]$minor_axis_length

  # add perimeter of mask
  perimeter <-  props[[1]]$perimeter

  # add area of mask
  area <- props[[1]]$area

  # add solidity (proportion of the pixels in shape to the pixels in the convex hull)
  solidity <-  props[[1]]$solidity

  # Create ID for image with image number and base directory
  imgnum <- stringr::str_split(path, "/")[[1]][length(stringr::str_split(path, "/")[[1]])]
  imgdir <- stringr::str_split(path, "/")[[1]][length(stringr::str_split(path, "/")[[1]]) - 1]
  ID <- paste0(imgdir, "/", imgnum)

  # scale measurements back to original image size where necessary
  perimeter <- perimeter/scf
  area <- area / scf**2
  minor <- minor/scf
  major <- major/scf


  # create dictionary with results
  res = list()
  res[['ID']] <-  ID
  res[['perimeter']] <- perimeter
  res[['area']] <- area
  res[['minor']] <- minor
  res[['solidity']] <- solidity
  res[['full.Length']] <- major
  res[['image']] <- img

  return(res)


}
