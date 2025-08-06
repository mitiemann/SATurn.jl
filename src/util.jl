# Check if assignment satisfies a clause
function satisfies(clause::Clause, assignment::Vector{Union{Nothing, Bool}})
    # Check if any literal in clause is satisfied
    for lit in clause.literals
        var = lit.var
        if assignment[var] === nothing
            continue  # Unassigned, can't determine
        end
        
        if (lit.sign && assignment[var]) || (!lit.sign && !assignment[var])
            return true  # Clause satisfied
        end
    end
    
    return false  # No literal satisfied
end

# Check if assignment satisfies entire formula
function satisfies_formula(cnf::CNF, assignment::Vector{Union{Nothing, Bool}})
    for clause in cnf.clauses
        if !satisfies(clause, assignment)
            return false
        end
    end
    return true
end
