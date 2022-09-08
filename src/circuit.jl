struct Circuit
    state::State
    gate_list::Vector{Gate}
end

function Circuit(dim::Int)
    # ITensorsの閾値設定
    if dim > 13
        ITensors.set_warn_order(dim + 1)
    end

    return Circuit(State(dim), Gate[])
end

function add!(circuit::Circuit, gate::Gate)
    push!(circuit.gate_list, gate)
end

function optimize(circuit::Circuit)
    os = OpSum()
    gates = []
    for gate in circuit.gate_list
        #os += (gate.name, gate.index)
        push!(gates, gate.name, gate.index)
    end
    os += Tuple(gates)
    return MPO(ComplexF64, os, circuit.state.sites)
end

# # TODO: randomMPO()が正しいゲート（ユニタリ行列）を作成するか？
# function createRandomGate(circuit::Circuit)
#     return randomMPO(circuit.state.sites)
# end

function createRandomGate(circuit::Circuit, depth::Int)
    os = OpSum()
    gateType = ["X", "Y", "Z", "T", "H"]
    dim = size(circuit.state.sites, 1)
    # print("dim: $dim")
    # print("(dim % i): $(dim % i)")
    gates = []
    for i = 1:depth
        push!(gates, gateType[rand(1:5)], (dim % i) + 1)
    end
    os += Tuple(gates)
    print(gates)
    return MPO(ComplexF64, os, circuit.state.sites)
end

function apply(mpo::MPO, mps::MPS)
    return ITensors.apply(mpo, mps; cutoff=1e-15)
end

function expect(mpo::MPO, mps::MPS)
    return inner(mps', mpo, mps)
end

function showStateVector(io::IO, psi::MPS)
    # 状態ベクトル表示
    V = ITensor(1.0)
    for (index, value) in enumerate(psi)
        #println(io, "$index : $(value)")
        V *= psi[index]
    end
    N = size(psi.data, 1)
    for (index, value) in enumerate(V)
        println(io, "|$(bitstring(index-1)[end-N+1:end])>: $(value)")
    end
end
showStateVector(psi::MPS) = showStateVector(stdout, psi)

# inverse()
# randomCircuit(size::Int, depth::Int=rand(1:10)) = Circuit(randomGateBlock(size, depth), size)
