module BCBI_base

export install_all,
       add_registered,
       clone_unregistered,
       checkout_branch

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
                            # "RCall", /libR.so appears to be too old. RCall.jl requires R 3.4.0 or later.
                            "PyCall",
                            "PyPlot", #get WARNING: No working GUI backend found for matplotlib
                            "Seaborn",
                            "Pandas",
                            "Revise",
                            "IJulia"]

const unregistered_pkgs =Dict( "ClassImbalance"=>"https://github.com/bcbi/ClassImbalance.jl.git",
                                "ARules"=>"https://github.com/bcbi/ARules.jl")


const dirty_pkgs = Dict("ScikitLearn" => "master",
                        "Gadfly" => "master")

function add_registered()

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

function clone_unregistered()

    failed_pkgs = Vector{String}()

    for (pkg, url) in unregistered_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")


        try
            println("* Clonning")
            pkgsym = Symbol(pkg)
            eval(:(Pkg.$pkgsym))
        catch
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
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
end

function checkout_branch()
    failed_pkgs = Vector{String}()

    for (pkg, branch) in dirty_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        Pkg.checkout(pkg, branch)
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

function install_all()
    add_registered()
    clone_unregistered()
    checkout_branch()
end

end
