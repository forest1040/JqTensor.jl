mutable struct State
    sites::Vector{Index{Int}}
    State(dim::Int) = new(siteinds("Qubit", dim))
end

function create_zero_state(sites::Vector{Index{Int}})
    return productMPS(ComplexF64, sites, "0")
end
