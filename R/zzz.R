.onLoad <- function(libname, pkgname) {
  packageStartupMessage("Trying to find python and conda")
  # try finding and using installed python
  pyconf <- reticulate::py_discover_config()
  if (!(pyconf$conda & pyconf$anaconda)) {
    packageStartupMessage("installing miniconda...")
    reticulate::install_miniconda()
  }
  packageStartupMessage("Trying to find conda environment 'daphniaRuler'")
  # check if conda environment exists
  exi <- reticulate::conda_list()
  if (!pkgname %in% exi$name) {
    packageStartupMessage(sprintf("Creating conda environment '%s'", pkgname))
    # create virtual env
    reticulate::conda_create(envname = pkgname, python_version = "3.8.10")
    # upgrade pip
    packageStartupMessage("upgrading pip...")
    reticulate::conda_install(
      envname = pkgname,
      pip = TRUE,
      c("pip", "setuptools"),
      pip_options = "--upgrade"
    )

    packageStartupMessage("installing daphniaruler...")
    reticulate::conda_install(
      envname = pkgname,
      pip = TRUE,
      packages = "daphruler==0.4.1",
      pip_options =
        "-i https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/"
    )
    packageStartupMessage(sprintf("Activating conda environment '%s'", pkgname))
    # find path to conda env python
    condals <- reticulate::conda_list()
    pyPath <- condals[condals$name == pkgname, "python"]
    # set reticulate python to patj
    Sys.setenv(RETICULATE_PYTHON=pyPath)
    reticulate::use_condaenv(pkgname, required = TRUE)
  } else {
    packageStartupMessage(sprintf("Activating conda environment '%s'", pkgname))
    # find path to conda env python
    condals <- reticulate::conda_list()
    pyPath <- condals[condals$name == pkgname, "python"]
    # set reticulate python to patj
    Sys.setenv(RETICULATE_PYTHON=pyPath)
    reticulate::use_condaenv(pkgname, required = TRUE)
  }
  packageStartupMessage("done... have fun")
}
