# BCBI Metapackage bcbi_v0.0.0

| Travis CI | Coverage | License |
|-----------|----------|---------|
|[![Build Status](https://travis-ci.org/bcbi/BCBI_base.jl.svg?branch=bcbi_v0.0.0)](https://travis-ci.org/bcbi/BCBI_base.jl)|[![codecov.io](http://codecov.io/github/bcbi/BCBI_base.jl/coverage.svg?branch=bcbi_v0.0.0)](http://codecov.io/githubbcbi/BCBI_base.jl?branch=bcbi_v0.0.0)|[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/bcbi/BCBI_base.jl/bcbi_v0.0.0/LICENSE.md)|

This package is a collection of Julia packages used by the Brown Center for Biomedical Informatics (BCBI) inside the Ursa Stronghold environment. The package serves as a mechanism for installing the various Julia packages most frequently used at BCBI.

## About URSA Environment:
* Version: bcbi_v0.0.0
* To activate" `module load conda/bcbi_v0.0.0`
* [Environment set up details]

## Installation

```julia
Pkg.clone("https://github.com/bcbi/BCBI_base.jl.git")
Pkg.checkout("BCBI_base", "bcbi_v0.0.0")
```

## Environment variables

The following environment variables are exepected in the path. Verify that they ar part on `ENV`. 
If not they can be set up 'environment' wide or included as part of `.juliarc.jl`


## Workarounds

1. For the following packages `Pkg.add()` didn't work out of the box and requiered workarounds.
    * Rmath - Problem with gcc flags. Have to call make manually
    * ScikitLearn - Tagged version caps DataFrames
    * Gadfly - Tagged version caps DataFrames
    * BioMedQuery - Tagged version uses HTTParse, which is failing
    * Lasso - Tagged version had dependency conflicts


2. PyPlot and Seaborn give:`WARNING: No working GUI backend found for matplotlib`




## How it was used

In Julia's REPL
```julia
using BCBI_base
Pkg.add("Rmath")
```

:warning: Building Rmath failed but was fixed by running:
```bash
make -C $(JULIA_PKGDIR)/v0.6/Rmath/deps/src/Rmath-julia-0.2.0/ CFLAGS=-v 
```
:warning: Rmath is needed by Gadfly and thus we pre-installed it to apply fix


Then rebuilding the package back in julia

```julia
Pkg.build("Rmath")
Pkg.add("ScikitLearn")
Pkg.add("Gadfly")

quit()
````

In terminal
```bash
cd $JULIA_PKGDIR/v0.6
cd ScikitLearn
git checkout master
cd ..
cd Gadfly
git checkout master
```
:warning: These packages are updated directly through git and not through Julia's package manager because before checking out the master branch there are dependency conflicts that cause `Pkg.resolve()` to fail. We then have to call `Pkg.update()` to trigger uptades to dependencies

In Julia's REPL

```julia
Pkg.update()
```

```julia
using BCBI_base

install_all(dirty = Dict("BioMedQuery" => "master")
check_installed()
````

## General Usage

* Install all packages

```julia
install_all()
````

* Install list of registered packages

```julia
add()
```

* Install list of unregistered packages

```julia
clone()
```

* Checkout

```julia
checkout()
```

* Missing "desired" packages

```julia
check_installed()
```

* Check that all packages precompile

```julia
using_all()
```

## List of packages

| Registered | Unregistered | Checkedout (master) |
|------------|--------------|---------------------|
|BioServices|ARules|BioMedQuery|
|ClassImbalance||Gadfly|
|Clustering||Lasso|
|CSV||ScikitLearn|
|DataFrames|||
|DecisionTree|||
|EzXML|||
|GLM|||
|GLMNet|||
|HTTP|||
|HypothesisTests|||
|IJulia|||
|JLD|||
|JLD2|||
|JuliaDB|||
|LightXML|||
|MixedModels|||
|MySQL|||
|Pandas|||
|PyCall|||
|PyPlot|||
|RCall|||
|Revise|||
|Seaborn|||
|StatsBase|||
|Query|||


To print the list of packages installed by this version:


```julia
using BCBI_base
println(BCBI_base.registered_pkgs)
println(BCBI_base.clone_pkgs)
println(BCBI_base.checkout_pkgs)
```


## Other Dependencies
* The MySQL.jl package depends on a working MySQL installation; instructions can be obtained [here](https://dev.mysql.com/doc/refman/5.7/en/installing.html). For simplicity, macOS users may prefer to install MySQL using [Homebrew](https://brew.sh/).

* The RCall.jl package depends on a working installation of R, which can be obtained [here](https://www.r-project.org/). MacOS users may opt to use [Homebrew](https://brew.sh/) for ease of installation.

* The ScikitLearn.jl package requires a working version of Python and the Scikit-Learn package for Python. The Anaconda distribution of Python is recommended, which can be obtained [here](https://www.continuum.io/downloads).
