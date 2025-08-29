module PicoSat

using libpicosat_jll

const lib = libpicosat

const UNKNOWN = 0
const SATISFIABLE = 10
const UNSATISFIABLE = 20

reset(p::Ptr{Cvoid}) =
    ccall((:picosat_reset, lib), Cvoid, (Ptr{Cvoid},), p)
adjust(p::Ptr{Cvoid}, N::Integer) =
    ccall((:picosat_adjust, lib), Cvoid, (Ptr{Cvoid}, Cint), p, N)
add(p::Ptr{Cvoid}, v::Integer) =
    ccall((:picosat_add, lib), Cint, (Ptr{Cvoid}, Cint), p, v)
assume(p::Ptr{Cvoid}, v::Integer) =
    ccall((:picosat_assume, lib), Cint, (Ptr{Cvoid}, Cint), p, v)
sat(p::Ptr{Cvoid}, limit::Integer = -1) =
    ccall((:picosat_sat, lib), Cint, (Ptr{Cvoid}, Cint), p, limit)
deref(p::Ptr{Cvoid}, v::Integer) =
    ccall((:picosat_deref, lib), Cint, (Ptr{Cvoid}, Cint), p, v)
failed(p::Ptr{Cvoid}, v::Integer) =
    ccall((:picosat_failed_assumption, lib), Cint, (Ptr{Cvoid}, Cint), p, v)
push(p::Ptr{Cvoid}) =
    ccall((:picosat_push, lib), Cint, (Ptr{Cvoid},), p)
pop(p::Ptr{Cvoid}) =
    ccall((:picosat_pop, lib), Cint, (Ptr{Cvoid},), p)
var_count(p::Ptr{Cvoid}) =
    ccall((:picosat_variables, lib), Cint, (Ptr{Cvoid},), p)
clause_count(p::Ptr{Cvoid}) =
    ccall((:picosat_added_original_clauses, lib), Cint, (Ptr{Cvoid},), p)
inc_max_var(p::Ptr{Cvoid}) =
    ccall((:picosat_inc_max_var, lib), Cint, (Ptr{Cvoid},), p)

end