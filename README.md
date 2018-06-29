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

    One set at a time
    ```julia
    BCBI_base.add(BCBI_base.base_pkgs)
    BCBI_base.add(BCBI_base.plotting_pkgs)
    BCBI_base.add(BCBI_base.datasets_pkg)
    BCBI_base.add(BCBI_base.external_pkgs)
    BCBI_base.clone(BCBI_base.clone_pkgs)
    BCBI_base.checkout(BCBI_base.checkout_pkgs)
    ```

    Alternatively, if you are confident things won't fail
    ```julia
    install_all()
    ````

* Check that installed packages precompile correctly

    It is best to call this from a new/fresh julia session

    ```julia
    using_all()
    ```

* Remove packages that are not working (recommended)

    ```julia
    BCBI_base.clean_up()
    ```

* Get list of missing "desired" packages

    ```julia
    check_installed()
    ```

## List of packages

| Base | Plotting | DataSets | R/Python | Cloned
|------------|--------------|---------------------|---------------------|---------------------|
|MySQL|PGFPlotsX|RDataSets|RCall|ARules=>https://github.com/bcbi/ARules.jl|
|BioServices|PlotlyJS|VegaDatasets|PyCall|ScikitLearn=>https://github.com/cstjean/ScikitLearn.jl.git|
|ClassImbalance|||Pandas|Gadfly=>https://github.com/GiovineItalia/Gadfly.jl.git|
|Clustering|||Pandas|BioMedQuery=>https://github.com/bcbi/BioMedQuery.jl.git|
|Compat|||Seaborn|Lasso=>https://github.com/simonster/Lasso.jl.git|
|CSV||||PredictMD=>https://github.com/bcbi/PredictMD.jl|
|DataFrames|||||
|DecisionTree|||||
|EzXML|||||
|GLM|||||
|GLMNet|||||
|HTTP|||||
|HypothesisTests|||||
|IJulia|||||
|JLD|||||
|JLD2|||||
|JuliaDB|||||
|Lasso|||||
|LIBSVM|||||
|LightXML|||||
|MixedModels|||||
|Revise|||||
|ROCAnalysis|||||
|StatsBase|||||
|Query|||||


* To print the list of packages installed by this version:


    ```julia
    using BCBI_base
    println(BCBI_base.base_pkgs)
    println(BCBI_base.plotting_pkgs)
    println(BCBI_base.external_pkgs)
    println(BCBI_base.datasets_pkgs)
    println(BCBI_base.clone_pkgs)
    println(BCBI_base.checkout_pkgs)
    ```


## Other Dependencies

* The MySQL.jl package depends on a working MySQL installation; instructions can be obtained [here](https://dev.mysql.com/doc/refman/5.7/en/installing.html). For simplicity, macOS users may prefer to install MySQL using [Homebrew](https://brew.sh/).

* The RCall.jl package depends on a working installation of R, which can be obtained [here](https://www.r-project.org/). MacOS users may opt to use [Homebrew](https://brew.sh/) for ease of installation.
