% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/measure_image.R
\name{measure_image}
\alias{measure_image}
\title{Measure morphometric traits of a single image}
\usage{
measure_image(path, find_eye = TRUE, plot_image = TRUE, scaling_factor = NULL)
}
\arguments{
\item{path}{path to image either absolute or relative. string. See Details for more info.}

\item{find_eye}{try to find eye of daphnia?
if eye can't be found automatically falls back to only outline measurement. boolean}

\item{plot_image}{whether or not to plot resulting image. boolean}

\item{scaling_factor}{scale measurements to other unit. numeric. See Details for more info}
}
\description{
Measure morphometric traits of a single image
}
\details{
Currently only png and jpg formats are allowed as input images.
scaling_factor describes how many pixels occur in one other unit.
For example if one mm corresponds to 100 pixels the scaling factor would be 100.
You can calculate the scaling factor by taking images of a graticule ans see how many
pixels are in a unit of length with an image analysis tool such as imageJ.
}
\examples{
\dontrun{
measure_image("path/to/image")
# scale images to other unit
measure_image("path/to/image", scaling_factor = 134)
}
}
