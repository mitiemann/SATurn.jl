# using Pkg; Pkg.activate(temp=true);
# Pkg.add("Revise"); using Revise
# Pkg.add("Cthulhu"); using Cthulhu

using Revise
using SATurn

methods(SATurn.SimpleLiteral)
SATurn.SimpleLiteral(5)
SimpleLiteral(-5)

nums = "63 -86 -98 0"
foo = map(x -> parse(Int, x), split(nums)) |> filter(x -> x != 0)

file = "test/dimacs/cnf/tieshirt.cnf"
cnf = parse_dimacs(file)

# open(file) do f 
#     clauses = SimpleClause[]
#     for line in eachline(f)
#         startswith(line, "c") && continue
#         startswith(line, "p") && continue
#         startswith(line, "%") && continue

#         literals = SimpleLiteral[]
#         nums = map(x -> parse(Int, x), split(strip(line)))
#         @show nums
#         @show typeof(nums)
#     end
# end

