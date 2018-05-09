module BCBI_base


export add_and_precompile

const base_pkgs = Vector{String}("MySQL",
                            "StatsBase",
                            "DataFrames",
                            "CSV",
                            "Query",
                            "Clustering",
                            "DecisionTree",
                            "GLM",
                            "GLMNet",
                            "HypothesisTests",
                            "LowRankModels",
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
                            "ScikitLearn",
                            "Gadfly",
                            "PyPlot",
                            "Seaborn",
                            "Pandas",
                            "Revise")


function add_and_precompile()

    failed_pkgs = Vector{String}()

    for pkg in base_pkgs
        println("--------------------------------")
        println("Adding package: ", pkg)
        println("--------------------------------")


        try
            Pkg.add(pkg)
        catch
            warn("Pkg.add failed")
            push!(failed_pkgs, pkg)
            continue
        end

        println("--------------------------------")
        println("Precompiling package: ", pkg)
        println("--------------------------------")
        try
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
