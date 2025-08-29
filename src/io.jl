# Really, this function should parse a string, no?
# We could then have
# - read_dimacs <- File -> String
# - parse_dimacs <- String -> CNF
# - print_dimacs <- CNF -> String
# - write_dimacs <- String -> File
function parse_dimacs(filename::String)
    clauses = SimpleClause[]
    num_vars = 0

    open(filename, "r") do file
        for line in eachline(file)
            # Skip comments and header lines
            if startswith(line, "c") || startswith(line, "p")
                continue
            end

            # Some files have '%' to dignify final empty clause
            if startswith(line, "%")
                continue
            end

            # Parse clause
            literals = SimpleLiteral[]
            numbers = map(x -> parse(Int, x), split(strip(line)))

            for num in numbers
                if num == 0  # End of clause
                    break
                end

                var = abs(num)
                sign = num > 0
                push!(literals, SimpleLiteral(var, sign))
            end

            if !isempty(literals)
                push!(clauses, SimpleClause(literals))
            end
        end
    end

    return SimpleCNF(clauses)
end
