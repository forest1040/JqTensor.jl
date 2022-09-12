using ITensors

N = 2
s = ITensors.siteinds("Qubit", N)
ψ0 = ITensors.productMPS(s, "0")

os = [([
        0 1
        1 0
    ], 1)]
gates = ops(os, s)

ψ1 = ITensors.apply(gates, ψ0; cutoff=1e-15)

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ1)
    #println("$index : $(value)")
    global V *= ψ1[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end

println("--------------")

# CRz
theta = π
os = [([
        1 0 0 0
        0 1 0 0
        0 0 exp(-im * π / 2 * theta) 0
        0 0 0 exp(im * π / 2 * theta)
    ], 2, 1)]
gates = ops(os, s)

ψ2 = ITensors.apply(gates, ψ1; cutoff=1e-15)

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ2)
    #println("$index : $(value)")
    global V *= ψ2[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end

println("--------------")


mutable struct DGate
    name::String
    control::Int
    index::Int
    # TODO: 型指定
    data::Any # ::Matrix{ComplexF64}
end

CRz(control::Int, target::Int, theta::Number) = DGate(
    "CRz",
    control,
    target,
    [
        1 0 0 0
        0 1 0 0
        0 0 exp(-im * π / 2 * theta) 0
        0 0 0 exp(im * π / 2 * theta)
    ]
)



function create_gate(gate::DGate, sites::Vector{Index{Int}})
    os = []
    t = []
    push!(t, gate.data)
    push!(t, gate.index)
    push!(t, gate.control)
    push!(os, Tuple(t))
    return ops(os, sites)
end

gates = create_gate(CRz(1, 2, π), s)
ψ2 = ITensors.apply(gates, ψ1; cutoff=1e-15)
# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ2)
    #println("$index : $(value)")
    global V *= ψ2[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end
