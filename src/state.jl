mutable struct State
    sites::Vector{Index{Int}}
    State(dim::Int) = new(siteinds("Qubit", dim))
end

function createZeroState(sites::Vector{Index{Int}})
    return productMPS(ComplexF64, sites, "0")
end

function createRandomState(sites::Vector{Index{Int}})
    return randomMPS(ComplexF64, sites)
end
