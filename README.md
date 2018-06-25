# BCBI Metapackage

| Travis CI | Coverage | License |
|-----------|----------|---------|
|[![Build Status](https://travis-ci.org/bcbi/BCBI_base.jl.svg?branch=master)](https://travis-ci.org/bcbi/BCBI_base.jl)|[![codecov.io](http://codecov.io/github/bcbi/BCBI_base.jl/coverage.svg?branch=master)](http://codecov.io/githubbcbi/BCBI_base.jl?branch=master)|[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/bcbi/BCBI_base.jl/bcbi_v0.0.0/LICENSE.md)|

This package is a collection of Julia packages used by the Brown Center for Biomedical Informatics (BCBI). The package serves as a mechanism for installing the various Julia packages most frequently used at BCBI.


## Installation

```julia
Pkg.clone("https://github.com/bcbi/BCBI_base.jl.git")
```

## URSA/STRONGHOLD

See [instructions](https://github.com/bcbi/BCBI_base.jl/blob/master/STRONGHOLD.md)

## General Usage

* Import package

```julia
using BCBI_base
```

* Install all packages

```julia
install_all()
````

* Install list of registered packages

```julia
BCBI_base.add()
```

* Install list of unregistered packages

```julia
BCBI_base.clone()
```

* Checkout

```julia
BCBI_base.checkout()
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
println(BCBI_base.base_pkgs)
println(BCBI_base.clone_pkgs)
println(BCBI_base.checkout_pkgs)
```


## Other Dependencies
* The MySQL.jl package depends on a working MySQL installation; instructions can be obtained [here](https://dev.mysql.com/doc/refman/5.7/en/installing.html). For simplicity, macOS users may prefer to install MySQL using [Homebrew](https://brew.sh/).

* The RCall.jl package depends on a working installation of R, which can be obtained [here](https://www.r-project.org/). MacOS users may opt to use [Homebrew](https://brew.sh/) for ease of installation.
