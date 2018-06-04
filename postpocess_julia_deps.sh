#!/bin/bash

#replaces all instances of /opt/conda/ for /opt/browncis/conda/ so deps are found in the workstations
find $JULIA_PKGDIR/v0.6 -name "deps.jl" -type f -exec sed -i "s+/opt/conda/envs/$CONDA_DEFAULT_ENV+/opt/browncis/conda/envs/$CONDA_DEFAULT_ENV+g" {} +