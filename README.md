
# dphrl

<!-- badges: start -->
[![R-CMD-check](https://github.com/nelstevens/daphniaRuler/workflows/R-CMD-check/badge.svg)](https://github.com/nelstevens/daphniaRuler/actions)
[![Codecov test coverage](https://codecov.io/gh/nelstevens/daphniaRuler/branch/main/graph/badge.svg)](https://codecov.io/gh/nelstevens/daphniaRuler?branch=main)
<!-- badges: end -->

Automatically collect morphometric traits of Daphnia and other zooplankton species by leveraging python. Simply take images of individual specimen and point the daphniaruler towards a single image or a directory of images.

## Installation

You can install the daphnia ruler via github using remotes:

``` r
remotes::install_github("nelstevens/daphniaRuler")
```

## Usage
For detailed usage see: tbd

### Measure single images:

``` r
library(daphniaruler)
measure_image("path/to/image")
```
The daphniaruler will output a list with all measured traits and plot measurements over the image.
![](man/figures/example1_out.png)

### Measure a directory: tbd
