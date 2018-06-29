using Base.Test
using BCBI_base

@testset "Test Adding and Precompiling Packages" begin
    println("--------------------------------")
    println("Testin Base Pkgs")
    println("--------------------------------")
    @test length(BCBI_base.add(BCBI_base.base_pkgs)) == 0
    println("--------------------------------")
    println("Testing Plotting Pkgs")
    println("--------------------------------")
    @test length(BCBI_base.add(BCBI_base.plotting_pkgs)) == 0
    println("--------------------------------")
    println("Testing Datasets Pkgs")
    println("--------------------------------")
    @test length(BCBI_base.add(BCBI_base.datasets_pkg)) == 0
    println("--------------------------------")
    println("Testing Python/R Pkgs")
    println("--------------------------------")
    @test length(BCBI_base.add(BCBI_base.external_pkgs)) == 0
    println("--------------------------------")
    println("Testing Clone Pkgs")
    println("--------------------------------")
    @test length(BCBI_base.clone(BCBI_base.clone_pkgs)) == 0
    println("--------------------------------")
    println("Testing Checkout Pkgs")
    println("--------------------------------")
    @test length(BCBI_base.checkout(BCBI_base.checkout_pkgs)) == 0
    println("--------------------------------")
    println("Precompiling Installed Pkgs")
    println("--------------------------------")
    @test length(using_all()) == 0
    clean_up()
    @test check_installed() == 0
end

