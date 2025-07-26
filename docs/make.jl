using SATurn
using Documenter

DocMeta.setdocmeta!(SATurn, :DocTestSetup, :(using SATurn); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers
const numbered_pages = [
    file for file in readdir(joinpath(@__DIR__, "src")) if
    file != "index.md" && splitext(file)[2] == ".md"
]

makedocs(;
    modules = [SATurn],
    authors = "Michael Tiemann <github@michaeltiemann.net>",
    repo = "https://github.com/mitiemann/SATurn.jl/blob/{commit}{path}#{line}",
    sitename = "SATurn.jl",
    format = Documenter.HTML(; canonical = "https://mitiemann.github.io/SATurn.jl"),
    pages = ["index.md"; numbered_pages],
)

deploydocs(; repo = "github.com/mitiemann/SATurn.jl")
