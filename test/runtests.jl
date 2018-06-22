using Base.Test
using BCBI_base

@testset "Add" begin
    BCBI_base.add()
    failed_pkgs = Vector{String}()

    for pkg in BCBI_base.base_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        try
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
        end
    end

    println("--------------------------------")
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    @test length(failed_pkgs) == 0
end

@testset "Clone" begin
    BCBI_base.clone()
    failed_pkgs = Vector{String}()

    for (pkg, url) in BCBI_base.clone_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        try
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
        end
    end

    println("--------------------------------")
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    @test length(failed_pkgs) == 0
end
warn("Not running tests on checkout()")

@testset "Checkout" begin
    BCBI_base.checkout()
    failed_pkgs = Vector{String}()

    for (pkg, url) in BCBI_base.checkout_pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        try
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
        end
    end

    println("--------------------------------")
    println("Failed packages: ")
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    @test length(failed_pkgs) == 0
end

@test length(check_installed()) == 2

#Printout for reference
Pkg.installed()

