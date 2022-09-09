mutable struct Gate
    name::String
    index::Int
    data::Any
end
Gate(name::String, index::Int) = Gate(name, index, [])

# 1bit
I(index::Int) = Gate("I", index)
X(index::Int) = Gate("X", index)
Y(index::Int) = Gate("Y", index)
Z(index::Int) = Gate("Z", index)
H(index::Int) = Gate("H", index)
S(index::Int) = Gate("S", index)
T(index::Int) = Gate("T", index)
P(index::Int) = Gate("P", index)
Rx(index::Int, theta::Number) = Gate("Rx", index, (θ=theta,))

# 2bit
