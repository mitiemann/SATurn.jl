module SATurn

include("types.jl")
include("util.jl")

function parse_dimacs(filename::String)
    clauses = Clause[]
    num_vars = 0
    
    open(filename, "r") do file
        for line in eachline(file)
            # Skip comments and header lines
            if startswith(line, "c") || startswith(line, "p")
                continue
            end
            
            # Parse clause
            literals = Literal[]
            numbers = map(x -> parse(Int, x), split(strip(line)))
            
            for num in numbers
                if num == 0  # End of clause
                    break
                end
                
                var = abs(num)
                sign = num > 0
                push!(literals, Literal(var, sign))
            end
            
            if !isempty(literals)
                push!(clauses, Clause(literals))
            end
        end
    end
    
    return CNF(clauses)
end

end
