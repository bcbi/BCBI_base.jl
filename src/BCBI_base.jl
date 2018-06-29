module BCBI_base

export install_all,
       check_installed,
       using_all

const plotting_pkgs = [ "VegaLite", "PGFPlotsX", "PlotlyJS", "Gadfly"]

const datasets_pkg = ["RDatasets", "VegaDatasets"]

const external_pkgs = ["RCall", "PyCall", "Pandas", "PyPlot", "Seaborn"]

const problematic_pkgs = ["GLMNet", "EzXML", "Lasso"]

const predictmd_extra_deps = [  "Atom",
                                "BenchmarkTools",
                                "CSVFiles",
                                "CUDAapi",
                                "Combinatorics",
                                "Documenter",
                                "FluxJS",
                                "GLM",
                                "GPUArrays",
                                "Knet",
                                "Literate",
                                "MLBase",
                                "MLDatasets",
                                "Metalhead",
                                "NBInclude",
                                "NumericalIntegration",
                                "PGFPlots",
                                "PGFPlotsX",
                                "ProgressMeter",
                                "RDatasets",
                                "Requires",
                                "ValueHistories",
                                "Weave"]
                                
const base_pkgs = [ "MySQL",
                    "BioServices",
                    "ClassImbalance",
                    "Clustering",
                    "Compat",
                    "CSV",
                    "DataFrames",
                    "DecisionTree",
                    "GLM",
                    "HTTP",
                    "HypothesisTests",
                    "IJulia",
                    "JLD",
                    "JLD2",
                    "JuliaDB",
                    "LIBSVM",
                    "LightXML",
                    "MixedModels",
                    "Revise",
                    "ROCAnalysis",
                    "StatsBase",
                    "Query"
                    ]

""" 
    clone_pkgs
Dictionary of package name and URL to clone.
We use it for unregistered and packages that we wish to checkout the master branch.
For registered packages, we perform `Pkg.clone` instead of `Pkg.checkout` as the later may fail
if the lates tagged version cannot be resoved
"""                            
const clone_pkgs =Dict("ARules"=>"https://github.com/bcbi/ARules.jl",
                       "ScikitLearn"=>"https://github.com/cstjean/ScikitLearn.jl.git",
                       "BioMedQuery"=>"https://github.com/bcbi/BioMedQuery.jl.git",
                       "PredictMD"=>"https://github.com/bcbi/PredictMD.jl")

"""
    checkout_pkgs
Dictionary of package name to brach
"""
const checkout_pkgs=Dict("PredictMD"=>"master")

"""
    add(pkgs = BCBI_base.base_pkgs)

Call `Pkg.add` and `using` on list of desired packages
"""
function add(pkgs = BCBI_base.base_pkgs)

    Pkg.update()

    failed_pkgs = Vector{String}()

    for pkg in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")

        try
            println("* Adding")
            Pkg.add(pkg)
        catch
            warn("Pkg.add failed")
            push!(failed_pkgs, pkg)
            continue
        end

    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
    add_and_precompile(pkgs = BCBI_base.base_pkgs)

Call `Pkg.add` and `using` on list of desired packages
"""
function add_and_precompile(pkgs = BCBI_base.base_pkgs)

    Pkg.update()

    failed_pkgs = Vector{String}()

    for pkg in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")


        try
            println("* Adding")
            Pkg.add(pkg)
        catch
            warn("Pkg.add failed")
            push!(failed_pkgs, pkg)
            continue
        end

        try
            println("* Using")
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
            Pkg.rm(pkg)
        end

    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
    clone(pkgs = BCBI_base.clone_pkgs)

Call `Pkg.clone` and `using` on `Dict("name"->"url")` of desired packages
"""
function clone(pkgs = BCBI_base.clone_pkgs)

    failed_pkgs = Vector{String}()

    for (pkg, url) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")

        try
            v = Pkg.installed(pkg)
            if typeof(v) != VersionNumber
                println("* Clonning")
                Pkg.clone(url)
            end
        catch
            println("* Clonning")
            Pkg.clone(url)
        end

    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
    clone_and_precompile(pkgs = BCBI_base.clone_pkgs)

Call `Pkg.clone` and `using` on `Dict("name"->"url")` of desired packages
"""
function clone_and_precompile(pkgs = BCBI_base.clone_pkgs)

    failed_pkgs = Vector{String}()

    for (pkg, url) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")


        try
            v = Pkg.installed(pkg)
            if typeof(v) != VersionNumber
                println("* Clonning")
                Pkg.clone(url)
            end
        catch
            println("* Clonning")
            Pkg.clone(url)
        end

        try
            println("* Using")
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
            Pkg.rm(pkg)
        end

    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
    checkout(pkgs = Dict())

Call `Pkg.checkout` and `using` on `Dict("name"->"branch")` of desired packages. It assumes that 
package is already added
"""
function checkout(pkgs = BCBI_base.checkout_pkgs)
    
    failed_pkgs = Vector{String}()

    for (pkg, branch) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        println("* Checkout ", branch)

        try
            Pkg.checkout(pkg, branch)
        catch
            warn("checking out branch failed")
            push!(failed_pkgs, pkg)
        end
    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
checkout_and_precompile(pkgs = Dict())

Call `Pkg.checkout` and `using` on `Dict("name"->"branch")` of desired packages. It assumes that 
package is already added
"""
function checkout_and_precompile(pkgs = BCBI_base.checkout_pkgs)
    failed_pkgs = Vector{String}()

    for (pkg, branch) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        println("* Checkout ", branch)
        try
            Pkg.checkout(pkg, branch)
            println("* Using")
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
            Pkg.rm(pkg)
        end
    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
    install_all()
Run checkout/add/clone functions
"""
function install_all()
    add(base_pkgs)
    add(plotting_pkgs)
    add(datasets_pkg)
    add(external_pkgs)
    clone(clone_pkgs)
    checkout(checkout_pkgs)
end

"""
    check_installed()
Print and return list of missing "desired" packages
"""
function check_installed()
    desired = vcat(base_pkgs, plotting_pkgs, external_pkgs, datasets_pkg, collect(keys(clone_pkgs)), collect(keys(checkout_pkgs)))
    installed = collect(keys(Pkg.installed()))
    println("--------------------------------")
    println("Missing desired packages:")
    println("--------------------------------")
    miss_pkgs = setdiff(desired, installed)
    println(miss_pkgs)

    return miss_pkgs
end

"""
    using_all()
Run `using` an all lists of packages
"""
function using_all()
    desired = vcat(base_pkgs, plotting_pkgs, external_pkgs, datasets_pkg, collect(keys(clone_pkgs)), collect(keys(checkout_pkgs)))
    failed_pkgs = Vector{String}()
    for pkg in desired
        try
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
        end
    end
    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
    
    return failed_pkgs
end

"""
    clean_up_failing()
Removes packages that fail to precompile
"""
function clean_up()
    failed_pkgs = using_all()
    for pkg in failed_pkgs
        println("--------------------------------")
        println("Removing package: ", pkg)
        println("--------------------------------")
        Pkg.rm(pkg)
    end
end

end