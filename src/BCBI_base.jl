module BCBI_base

export install_all,
       add_registered,
       clone_unregistered,
       checkout_special,
       check_installed

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

"""
    add_registered(pkgs = BCBI_base.registered_pkgs)

Call `Pkg.add` and `using` on list of desired packages
"""
function add_registered(pkgs = BCBI_base.registered_pkgs)

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

"""
    clone_unregistered(pkgs = BCBI_base.unregistered_pkgs)

Call `Pkg.clone` and `using` on `Dict("name"->"url")` of desired packages
"""
function clone_unregistered(pkgs = BCBI_base.unregistered_pkgs)

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
end

"""
    checkout_special(pkgs = Dict())

Call `Pkg.add`, `Pkg.checkout` and `using` on `Dict("name"->"branch")` of desired packages
"""
function checkout_special(pkgs = BCBI_base.dirty_pkgs)
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

"""
    install_all()
Run checkout/add/clone functions
"""
function install_all(;reg = registered_pkgs, unreg = unregistered_pkgs, dirty = dirty_pkgs)
    checkout_special(dirty)
    add_registered(reg)
    clone_unregistered(unreg)
end

"""
    check_installed()
Print and return list of missing "desired" packages
"""
function check_installed()
    desired = vcat(registered_pkgs, collect(keys(unregistered_pkgs)), collect(keys(dirty_pkgs)))
    installed = collect(keys(Pkg.installed()))
    println("--------------------------------")
    println("Missing desired packages:")
    println("--------------------------------")
    miss_pkgs = setdiff(desired, installed)
    println(miss_pkgs)
    miss_pkgs
end

end
