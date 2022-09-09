mutable struct Gate
    name::String
    control::Int
    index::Int
    # TODO: 型指定
    data::Any
end
Gate(name::String, index::Int) = Gate(name, 0, index, [])
Gate(name::String, control::Int, index::Int) = Gate(name, control, index, [])
Gate(name::String, index::Int, data::Any) = Gate(name, 0, index, data)

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
CX(control::Int, index::Int) = Gate("CX", control, index)
CNOT(control::Int, index::Int) = CX(control, index)
CRx(control::Int, index::Int, theta::Number) = Gate("CRx", control, index, (θ=theta,))
CRy(control::Int, index::Int, theta::Number) = Gate("CRy", control, index, (θ=theta,))
CRz(control::Int, index::Int, theta::Number) = Gate("CRz", control, index, (ϕ=theta,))
