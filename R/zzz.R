.onLoad <- function(libname, pkgname) {
  # # if python not installed warn and ask to install
  # if (!reticulate::py_available()) {
  #   instl <- askYesNo(
  #     msg = "Python is not installed do you want to install it?"
  #   )
  #   if (instl) {
  #       reticulate::install_python("3.6.8")
  #   }
  #   else {
  #     stop("you cannot use this package without python installed!\nplease install it.")
  #   }
  # }
  # reticulate::configure_environment(pkgname)
  # # get user platform
  # pltf <- unname(Sys.info()["sysname"])
  #
  # # when on linux activate venv
  # if (pltf == "Linux") {
  #   cat(
  #     sprintf(
  #       "activating Linux virtualenvironment: %s",
  #       system.file("python/envs/linux", package = "dphrl")
  #     )
  #   )
  #   # FIXME: activate env
  # }
  # else if (pltf == "Windows") {
  #   cat(
  #     sprintf(
  #       "activating windows virtual environment: %s",
  #       system.file("python/envs/windows", package = "dphrl")
  #     )
  #   )
  #   # FIXME: activate env
  # }
  #make environment
  browser()
  tryCatch(
    reticulate::virtualenv_create(envname = pkgname, python = "3.6.8"),
    error = function(e) {
      boo <- askYesNo(
        "Python 3.6.8 is not installed on your system. Would you like to install it?",
        default = F
      )
      if (boo) {
        reticulate::install_python(version = "3.6.8")
        reticulate::virtualenv_create(envname = pkgname, python = "3.6.8")
      }
      else {
        stop("Please install python3.6.8 before proceeding")
      }
      cat(boo)
    }
  )
  # virtualenv_install(envname = pkgname, "opencv-python")
  # virtualenv_install(envname = pkgname, "scikit-image")
  # virtualenv_install(envname = pkgname, "tqdm")
  # virtualenv_install(envname = pkgname, "pandas")
  # virtualenv_install(envname = pkgname, "utils")
}
