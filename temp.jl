# using Pkg; Pkg.activate(temp=true);
# Pkg.add("Revise"); using Revise
# Pkg.add("Cthulhu"); using Cthulhu

using Revise
using SATurn

file = "test/dimacs/cnf/eq2.cnf"
cnf = parse_dimacs(file)

sol = Solution(cnf)

# c tie=1
# c shirt=2
# p cnf 2 3
# 1 2 0
# -1 2 0
# -1 -2 0

sol.assignment[1] = false
sol.assignment[2] = true

satisfies_formula(cnf, sol)

