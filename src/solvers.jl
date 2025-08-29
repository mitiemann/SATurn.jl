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

