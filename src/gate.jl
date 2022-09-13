abstract type Gate end

mutable struct CommonGate <: Gate
    name::String
    indexs::Vector{Int}
    # TODO: 型指定
    data::Any
end
CommonGate(name::String, index::Int) = CommonGate(name, [index], [])
CommonGate(name::String, indexs::Vector{Int}) = CommonGate(name, indexs, [])
CommonGate(name::String, control::Int, index::Int) = CommonGate(name, [control, index], [])
CommonGate(name::String, index::Int, data::Any) = CommonGate(name, [index], data)

mutable struct DenseGate <: Gate
    name::String
    indexs::Vector{Int}
    data::Matrix{ComplexF64}
end
DenseGate(name::String, index::Int, data::Matrix{ComplexF64}) = DenseGate(name, [index], data)
DenseGate(name::String, index::Int, data::Matrix{Int}) = DenseGate(name, [index], data)
#DenseGate(name::String, index::Int, data::Matrix{Float}) = DenseGate(name, 0, index, data)
#DenseGate(name::String, control::Int, index::Int, data::Matrix{ComplexF64}) = DenseGate(name, control, index, data)


# 1-Qubit gates
I(index::Int) = CommonGate("I", index)
X(index::Int) = CommonGate("X", index)
Y(index::Int) = CommonGate("Y", index)
Z(index::Int) = CommonGate("Z", index)
H(index::Int) = CommonGate("H", index)
S(index::Int) = CommonGate("S", index)
T(index::Int) = CommonGate("T", index)
P(index::Int) = CommonGate("P", index)
Rx(index::Int, theta::Number) = CommonGate("Rx", index, (θ=theta,))
Ry(index::Int, theta::Number) = CommonGate("Ry", index, (θ=theta,))
Rz(index::Int, theta::Number) = CommonGate("Rz", index, (θ=theta,))

# 2-Qubit gates
CX(control::Int, index::Int) = CommonGate("CX", control, index)
CNOT(control::Int, target::Int) = CX(control, target)
SWAP(control::Int, index::Int) = CommonGate("SWAP", control, index)

# TODO: ITensorsの定義から行列表示を持ってきたい
# TODO: CRxの名前だけで、 ITensorsからopsに変換したいが、現在では回転角とcontrol/targetの同時指定ができない
CRx(control::Int, target::Int, theta::Number) = DenseGate(
    "CRx",
    #[control, target],
    # target, controlの順で追加すること 
    [target, control],
    [
        1 0 0 0
        0 1 0 0
        0 0 cos(θ / 2) -im*sin(theta / 2)
        0 0 -im*sin(θ / 2) cos(theta / 2)
    ]
)
CRX(control::Int, target::Int, theta::Number) = CRx(control, target, theta)

CRy(control::Int, target::Int, theta::Number) = DenseGate(
    "CRy",
    #[control, target],
    [target, control],
    [
        1 0 0 0
        0 1 0 0
        0 0 cos(θ / 2) -sin(theta / 2)
        0 0 sin(θ / 2) cos(theta / 2)
    ]
)
CRY(control::Int, target::Int, theta::Number) = CRy(control, target, theta)

CRz(control::Int, target::Int, theta::Number) = DenseGate(
    "CRz",
    #[control, target],
    [target, control],
    [
        1 0 0 0
        0 1 0 0
        0 0 exp(-im * theta / 2) 0
        0 0 0 exp(im * theta / 2)
    ]
)
CRZ(control::Int, target::Int, theta::Number) = CRz(control, target, theta)

# 3-Qubit gates
Toffoli(index1::Int, index2::Int, index3::Int) = CommonGate("Toffoli", [index1, index2, index3])
Toffoli(indexs::Vector{Int}) = CommonGate("Toffoli", indexs)
CCNOT(indexs::Vector{Int}) = Toffoli(indexs)
CCX(indexs::Vector{Int}) = Toffoli(indexs)

Fredkin(indexs::Vector{Int}) = CommonGate("Fredkin", indexs)

