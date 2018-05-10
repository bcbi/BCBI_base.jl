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
add_registered()
# Install list of unregistered packages
clone_unregistered()
```

## List of packages

| Registered | Unregistered | Checkedout (master) |
|------------|--------------|---------------------|
|MySQL|ClassImbalance|ScikitLearn|
|StatsBase|ARules|Gadfly|
|DataFrames|||
|CSV|||
|Query|||
|Clustering|||
|DecisionTree|||
|GLM|||
|GLMNet|||
|HypothesisTests|||
|Lasso|||
|MixedModels|||
|JuliaDB|||
|HTTP|||
|BioServices|||
|BioMedQuery|||
|JLD|||
|JLD2|||
|EzXML|||
|LightXML|||
|RCall|||
"PyCall|||
|PyPlot"|||
|Seaborn|||
|Pandas|||
|Revise|||
|IJulia"|||

To print the list of packages installed by this version:


```julia
using BCBI_base
println(BCBI_base.registered_pkgs)
println(BCBI_base.unregistered_pkgs)
println(BCBI_base.dirty_pkgs)
```

## Special instances

1. Currently for two packages  needed to be checkedout to their master branch.

    * ScikitLearn - latest tag v0.4.0, caps DataFrames to version v0.10.1.
    * Gadfly - latest tag v0.6.5, caps DataFrames to version < v0.11

    This process was done manually through terminal/git. Because Pkg.add() and
    triggers Pkg.resolve() before being able to checkout the master branch  

2. PyPlot and Seaborn give:`WARNING: No working GUI backend found for matplotlib`


## Other Dependencies
* The MySQL.jl package depends on a working MySQL installation; instructions can be obtained [here](https://dev.mysql.com/doc/refman/5.7/en/installing.html). For simplicity, macOS users may prefer to install MySQL using [Homebrew](https://brew.sh/).

* The RCall.jl package depends on a working installation of R, which can be obtained [here](https://www.r-project.org/). MacOS users may opt to use [Homebrew](https://brew.sh/) for ease of installation.

* The ScikitLearn.jl package requires a working version of Python and the Scikit-Learn package for Python. The Anaconda distribution of Python is recommended, which can be obtained [here](https://www.continuum.io/downloads).

## Checkedout packages
