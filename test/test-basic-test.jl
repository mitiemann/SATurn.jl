@testset "SATurn.jl" begin
    file_prefix = "dimacs/cnf/"
    files = readdir(file_prefix)

    for f in files
        cnf = parse_dimacs(file_prefix * f)
        sol = solve(BruteForceSolver, cnf)

        @test sol.satisfiable == satisfies_formula(cnf, sol)
    end
end
