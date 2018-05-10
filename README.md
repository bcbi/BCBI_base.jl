# BCBI Metapackage BCBI_v0.0.1

| Travis CI | Coverage | License | 
|-----------|----------|---------|
|[![Build Status](https://travis-ci.org/bcbi/BCBI_base.jl.svg?branch=bcbi_v0.0.1)](https://travis-ci.org/bcbi/BCBI_base.jl)|[![codecov.io](http://codecov.io/github/bcbi/BCBI_base.jl/coverage.svg?branch=bcbi_v0.0.1)](http://codecov.io/githubbcbi/BCBI_base.jl?branch=bcbi_v0.0.1)|[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/bcbi/BCBI_base.jl/bcbi_v0.0.1/LICENSE.md)|

This package is a collection of Julia packages used by the Brown Center for Biomedical Informatics (BCBI) inside the Ursa Stronghold environment. The package serves as a mechanism for installing the various Julia packages most frequently used at BCBI.

## About URSA Environment:
* Version: bcbi_v0.0.1
* To activate" `module load conda/bcbi_v0.0.1`

## Installation

```julia
Pkg.clone("https://github.com/bcbi/BCBI_base.jl.git")
Pkg.checkout("BCBI_base", "bcbi_v0.0.1")
```

## Usage

```julia
using BCBI_base
# Install list of registered packages
add()
# Install list of unregistered packages
clone()
```

## Informatio

To print the list of registered or unregistered packages:


```julia
using BCBI_base
println(BCBI_base.registered_pkgs)
println(BCBI_base.unregistered_pkgs)
```

## Other Dependencies
* The MySQL.jl package depends on a working MySQL installation; instructions can be obtained [here](https://dev.mysql.com/doc/refman/5.7/en/installing.html). For simplicity, macOS users may prefer to install MySQL using [Homebrew](https://brew.sh/).

* The RCall.jl package depends on a working installation of R, which can be obtained [here](https://www.r-project.org/). MacOS users may opt to use [Homebrew](https://brew.sh/) for ease of installation.

* The ScikitLearn.jl package requires a working version of Python and the Scikit-Learn package for Python. The Anaconda distribution of Python is recommended, which can be obtained [here](https://www.continuum.io/downloads).

