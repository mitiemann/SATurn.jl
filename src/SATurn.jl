module SATurn

using DataStructures

export AbstractLiteral, SimpleLiteral
export AbstractClause, SimpleClause
export AbstractCNF, SimpleCNF
export parse_dimacs

include("types.jl")
include("util.jl")
include("io.jl")
include("pico.jl")

end
