.onLoad <- function(libname, pkgname) {
  packageStartupMessage("Trying to find python...")
  # try finding and using installed python
  pythonpath <- reticulate::py_discover_config()
  tryCatch({
    reticulate::use_python(pythonpath$python)
  },
  error = function(mgs) {
    stop("No usable python installation found. please install python that reticulate can acess. Maybe reticualte::install_miniconda() will work.")
  })
  packageStartupMessage("Trying to find conda environment 'daphniaRuler'")
  # check if conda environment exists
  exi <- reticulate::conda_list()
  if (!pkgname %in% exi$name) {
    packageStartupMessage("Creating conda environment 'daphniaRuler'")
    # create virtual env
    reticulate::conda_create(envname = pkgname, python_version = "3.6.13")
    # upgrade pip
    packageStartupMessage("upgrading pip...")
    reticulate::virtualenv_install(
      envname = pkgname,
      c("pip", "setuptools"),
      pip_options = "--upgrade"
    )

    # install daphniaruler dependencies
    packageStartupMessage("installing daphniaruler python dependencies...")
    reticulate::virtualenv_install(
      envname = pkgname,
      packages = c(
        "astroid==2.3.3",
        "attrs==21.2.0",
        "cycler==0.10.0",
        "decorator==4.4.1",
        "imageio==2.6.1",
        "iniconfig==1.1.1",
        "isort==4.3.21",
        "kiwisolver==1.1.0",
        "lazy-object-proxy==1.4.3",
        "matplotlib==3.1.2",
        "mccabe==0.6.1",
        "networkx==2.4",
        "numpy==1.17.4",
        "opencv-python==4.1.2.30",
        "packaging==21.0",
        "pandas==0.25.3",
        "Pillow==6.2.1",
        "pluggy==1.0.0",
        "py==1.10.0",
        "pylint==2.4.4",
        "pyparsing==2.4.5",
        "pytest==6.2.5",
        "python-dateutil==2.8.1",
        "pytz==2019.3",
        "PyWavelets==1.1.1",
        "scikit-image==0.16.2",
        "scipy==1.3.3",
        "six==1.13.0",
        "toml==0.10.2",
        "tqdm==4.40.2",
        "typed-ast==1.4.0",
        "wrapt==1.11.2"
      ),
      ignore_installed = TRUE
    )
    packageStartupMessage("installing daphniaruler...")
    reticulate::virtualenv_install(
      envname = pkgname,
      packages = "daphruler==0.3.1",
      pip_options = "-i https://test.pypi.org/simple/"
    )
    packageStartupMessage("Activating conda environment 'daphniaRuler'")
    reticulate::use_condaenv(pkgname)
  } else {
    packageStartupMessage("Activating conda environment 'daphniaRuler'")
    reticulate::use_condaenv(pkgname)
  }
  packageStartupMessage("done... have fun")
}
