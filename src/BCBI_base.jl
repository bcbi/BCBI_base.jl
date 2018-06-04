module BCBI_base

export install_all,
       check_installed,
       using_all

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
                            "IJulia",
                            "ClassImbalance"]

""" 
    clone_pkgs
Dictionary of package name and URL to clone.
We use it for unregistered and packages that we wish to checkout the master branch.
For registered packages, we perform `Pkg.clone` instead of `Pkg.checkout` as the later may fail
if the lates tagged version cannot be resoved
"""                            
const clone_pkgs =Dict("ARules"=>"https://github.com/bcbi/ARules.jl",
                       "ScikitLearn"=>"",
                       "Gadfly"=>"",
                       "BioMedQuery"=>"",
                       "Lasso"=>"")

"""
    checkout_pkgs
Dictionary of package name to brach
"""
const checkout_pkgs=Dict()


"""
    add(pkgs = BCBI_base.registered_pkgs)

Call `Pkg.add` and `using` on list of desired packages
"""
function add(pkgs = BCBI_base.registered_pkgs)

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
    checkout(pkgs = Dict())

Call `Pkg.add`, `Pkg.checkout` and `using` on `Dict("name"->"branch")` of desired packages
"""
function checkout(pkgs = BCBI_base.checkout_pkgs)
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
function install_all(;reg = registered_pkgs, unreg = clone_pkgs, dirty = checkout_pkgs)
    checkout(dirty)
    add(reg)
    clone(unreg)
end

"""
    check_installed()
Print and return list of missing "desired" packages
"""
function check_installed()
    desired = vcat(registered_pkgs, collect(keys(clone_pkgs)), collect(keys(checkout_pkgs)))
    installed = collect(keys(Pkg.installed()))
    println("--------------------------------")
    println("Missing desired packages:")
    println("--------------------------------")
    miss_pkgs = setdiff(desired, installed)
    println(miss_pkgs)
    miss_pkgs
end

"""
    using_all()
Run `using` an all lists of packages
"""
function using_all()
    desired = vcat(registered_pkgs, collect(keys(clone_pkgs)), collect(keys(checkout_pkgs)))
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
end

end