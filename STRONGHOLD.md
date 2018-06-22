## About URSA Environment:
* Version: bcbi_v0.0.0
* To activate `module load conda/bcbi_v0.0.0`
* [Environment set up details](https://github.com/brown-data-science/stronghold_environments/blob/master/bcbi_v0.0.0.md)

## Installation

```julia
Pkg.clone("https://github.com/bcbi/BCBI_base.jl.git")

#before tagging - it was a branch
Pkg.checkout("BCBI_base", "bcbi_v0.0.0")
```

## Environment variables

The following environment variables are exepected in the path. Verify that they ar part on `ENV`. 
If not they can be set up 'environment' wide or included as part of `.juliarc.jl`

```bash
export LD_LIBRARY_PATH = /opt/browncis/conda/envs/$CONDA_DEFAULT_ENV/lib
export JULIA_PKGDIR = /opt/browncis/conda/envs/$CONDA_DEFAULT_ENV/lib/julia/packages
export PYTHON = /opt/browncis/conda/envs/$CONDA_DEFAULT_ENV/bin/python
export CONDA_JL_HOME = /opt/browncis/conda/envs/$CONDA_DEFAULT_ENV/lib/julia/packages/v0.6/Conda/deps/usr
```

## Workarounds

1. For the following packages `Pkg.add()` didn't work out of the box and requiered workarounds.
    * Rmath - Problem with gcc flags. Have to call `make` manually
    * ScikitLearn - Tagged version caps DataFrames
    * Gadfly - Tagged version caps DataFrames
    * BioMedQuery - Tagged version uses HTTParse, which is failing
    * Lasso - Tagged version had dependency conflicts


2. PyPlot and Seaborn give:`WARNING: No working GUI backend found for matplotlib`


## How it was used in the build server

In Julia's REPL
```julia
using BCBI_base
Pkg.add("Rmath")
```

:exclamation: Building Rmath failed but was fixed by running:
```bash
make -C $(JULIA_PKGDIR)/v0.6/Rmath/deps/src/Rmath-julia-0.2.0/ CFLAGS=-v 
```

Rmath was then rebuilt in julia

```julia
Pkg.build("Rmath")
````
:exclamation: Rmath is needed by Gadfly and thus it was pre-installed to apply the fix

Back to Julia's REPL

```julia
using BCBI_base

install_all()
check_installed()
````

:warning: In the build server, "/opt/browncis/conda" is a sym-link tp "/opt/conda". All packages that use BinDeps.jl will write
a deps.jl file pointing to the later path. However, in the workstations only "/opt/browncis/conda" exists. Therefore, we run the following post-process command included in `postprocess_julia_deps.sh` to change all paths encountered in relevant files

```
find $JULIA_PKGDIR/v0.6 -name "deps.jl" -type f -exec sed -i "s+/opt/conda/envs/$CONDA_DEFAULT_ENV+/opt/browncis/conda/envs/$CONDA_DEFAULT_ENV+g" {} +
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

* All Python related packages were pointed to the "root environment" Python. Therefore, Scikit-Learn, Seaborn, and others were pre-installed.


## How it was used in the work station

```
module load conda/bcbi_v0.0.0
julia
```

```julia
using BCBI_base
using_all()
```

:pray: that it all works
