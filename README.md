# BCBI Metapackage
This package is a collection of Julia packages used by the Brown Center for Biomedical Informatics (BCBI). The package serves as a mechanism for installing the various Julia packages most frequently used at BCBI.

## Installation
```julia
Pkg.clone("https://github.com/bcbi/BCBI_base.jl.git")
```

## Other Dependencies
* The MySQL.jl package depends on a working MySQL installation; instructions can be obtained [here](https://dev.mysql.com/doc/refman/5.7/en/installing.html). For simplicity, macOS users may prefer to install MySQL using [Homebrew](https://brew.sh/).

* The RCall.jl package depends on a working installation of R, which can be obtained [here](https://www.r-project.org/). MacOS users may opt to use [Homebrew](https://brew.sh/) for ease of installation.

* The ScikitLearn.jl package requires a working version of Python and the Scikit-Learn package for Python. The Anaconda distribution of Python is recommended, which can be obtained [here](https://www.continuum.io/downloads).


     
