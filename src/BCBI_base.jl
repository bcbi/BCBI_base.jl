module BCBI_base

export install_all,
       add_registered,
       clone_unregistered,
       checkout_special

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
                            "PyPlot", #get WARNING: No working GUI backend found for matplotlib
                            "Seaborn",
                            "Pandas",
                            "Revise",
                            "IJulia"]

const unregistered_pkgs =Dict( "ClassImbalance"=>"https://github.com/bcbi/ClassImbalance.jl.git",
                                "ARules"=>"https://github.com/bcbi/ARules.jl")


const dirty_pkgs = Dict("ScikitLearn" => "master",
                        "Gadfly" => "master")


function add_registered(pkg = BCBI_base.registered_pkgs)

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
end

function clone_unregistered(pkgs = BCBI_base.unregistered_pkgs)

    failed_pkgs = Vector{String}()

    for (pkg, url) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")


        try
            Pkg.installed(pkg)
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
end

function checkout_special(pkgs = Dict())
    failed_pkgs = Vector{String}()

    for (pkg, branch) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        println("* Add ")
        Pkg.add(pkg)
    end

    for (pkg, branch) in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        println("* Checkout ", branch)
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
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
end

function install_all()
    add_registered()
    clone_unregistered()
end

end
