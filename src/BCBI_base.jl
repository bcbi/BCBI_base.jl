module BCBI_base


export install_registered,
       install_unregistered,
       install_checkedout

const registered_pkgs = [   "MySQL",
                            "StatsBase",
                            "DataFrames",
                            "CSV",
                            "Query",
                            "Clustering",
                            "DecisionTree",
                            "GLM",
                            "GLMNet",
                            "HypothesisTests",
                            # "LowRankModels", downgrades deps
                            "Lasso",
                            "MixedModels",
                            "JuliaDB",
                            "HTTP",
                            "BioServices",
                            "BioMedQuery",
                            "JLD",
                            "JLD2",
                            "EzXML",
                            "LightXML",
                            "RCall",
                            "PyCall",
                            # "Gadfly", downgrades deps
                            "PyPlot", #get WARNING: No working GUI backend found for matplotlib
                            "Seaborn",
                            "Pandas",
                            "Revise",
                            "IJulia"]

const unregistered_pkgs =[ "https://github.com/bcbi/ClassImbalance.jl.git",
                           "https://github.com/bcbi/ARules.jl"]


const dirty_pkgs = Dict("ScikitLearn" => "master")

function install_registered()

    Pkg.update()

    failed_pkgs = Vector{String}()

    for pkg in registered_pkgs
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
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
end

function install_unregistered()

    failed_pkgs = Vector{String}()

    for pkg in unregistered_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")


        try
            println("* Clonning")
            Pkg.clone(pkg)
        catch
            warn("Pkg.clone failed")
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
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
end

function install_checkedout()
    failed_pkgs = Vector{String}()

    for (pkg, branch) in dirty_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        Pkg.clone(pkg, branch)
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
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
end


end
