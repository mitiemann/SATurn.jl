# Abstract solver type
abstract type SATSolver end

# Simple backtracking solver (for testing)
struct BruteForceSolver <: SATSolver end

function solve(::Type{BruteForceSolver}, cnf::CNF)
    solution = Solution(cnf.num_vars)

    solution.assignment .= false
    for i in 0:(2^cnf.num_vars - 1)
        sol = digits(i, base = 2, pad = cnf.num_vars)
        solution.assignment .= sol

        if satisfies_formula(cnf, solution)
            solution.satisfiable = true
            break
        end
    end

    return solution
end
solve(::BruteForceSolver, cnf::CNF) = solve(Type{BruteForceSolver}, cnf)

mutable struct PicoSolver <: SATSolver
    pico::Ptr{Cvoid}

    function PicoSolver()
        ptr = PicoSat.init()
        pico = new(ptr)
        
        function finalize(solver)
            PicoSat.reset(solver.ptr)
            solver.ptr = C_NULL
            return solver
        end
        finalizer(finalize, pico)
    end
end

include("pico.jl")

