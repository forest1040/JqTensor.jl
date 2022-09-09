mutable struct Gate
    name::String
    index::Int
    # TODO: 型指定
    data::Any
end
Gate(name::String, index::Int) = Gate(name, index, [])

# 1-Qubit gates
I(index::Int) = Gate("I", index)
X(index::Int) = Gate("X", index)
Y(index::Int) = Gate("Y", index)
Z(index::Int) = Gate("Z", index)
H(index::Int) = Gate("H", index)
S(index::Int) = Gate("S", index)
T(index::Int) = Gate("T", index)
P(index::Int) = Gate("P", index)
Rx(index::Int, theta::Number) = Gate("Rx", index, (θ=theta,))
Ry(index::Int, theta::Number) = Gate("Ry", index, (θ=theta,))
Rz(index::Int, theta::Number) = Gate("Rz", index, (θ=theta,))

# 2-Qubit gates
CX(control::Int, target::Int) = Gate("CX", control, target)
CNOT(control::Int, target::Int) = CX(control, target)
