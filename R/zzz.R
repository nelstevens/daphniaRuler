.onLoad <- function(libname, pkgname) {
  #make environment and install python if necessary
  tryCatch(
    {
      packageStartupMessage("trying to initialize virtual environment")
      reticulate::virtualenv_create(envname = pkgname, python = "3.6.8")
    },
    error = function(e) {
      boo <- askYesNo(
        "Python 3.6.8 is not installed on your system. Would you like to install it?",
        default = F
      )
      if (boo) {
        packageStartupMessage("installing python3.6.8")
        reticulate::install_python(version = "3.6.8")
        packageStartupMessage(sprintf("creating virtual environment: %s", pkgname))
        reticulate::virtualenv_create(envname = pkgname, python = "3.6.8")
      }
      else {
        stop("Please install python3.6.8 before proceeding")
      }
      cat(boo)
    }
  )
  packageStartupMessage("installing dependencies to virtual environment")
  virtualenv_install(envname = pkgname, "opencv-python")
  virtualenv_install(envname = pkgname, "scikit-image")
  virtualenv_install(envname = pkgname, "tqdm")
  virtualenv_install(envname = pkgname, "pandas")
  virtualenv_install(envname = pkgname, "utils")
}
