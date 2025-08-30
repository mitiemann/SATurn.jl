# Represent literals as integers (positive = true, negative = false)
struct Literal
    var::Int
    sign::Bool  # true for positive, false for negative

    Literal(var, sign) = new(abs(var), sign)
end

Literal(var) = Literal(abs(var), var > 0)

Base.abs(l::Literal) = Literal(l.var, true)
Base.:(-)(l::Literal) = Literal(l.var, !l.sign)

# Clause represented as sorted array of literals
struct Clause
    literals::Vector{Literal}
    
    function Clause(lits::Vector{Literal})
        # Sort literals by variable number for consistency
        sort!(lits, by = l -> l.var)
        new(lits)
    end
end

Clause(lits::Vararg{Literal}) = Clause(collect(lits))

# CNF formula - collection of clauses
struct CNF
    clauses::Vector{Clause}
    num_vars::Int
    
    function CNF(clauses::Vector{Clause})
        # Find maximum variable number
        max_var = 0
        for clause in clauses
            for lit in clause.literals
                max_var = max(max_var, lit.var)
            end
        end
        new(clauses, max_var)
    end
end

# Solution type
mutable struct Solution
    satisfiable::Bool
    assignment::Vector{Union{Nothing, Bool}}  # Nothing for unassigned vars
    
    function Solution(sat::Bool, vars::Int)
        new(sat, fill(nothing, vars))
    end
end

Solution(vars::Int) = Solution(false, vars)
Solution(cnf::CNF) = Solution(cnf.num_vars)