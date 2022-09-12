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

function add!(circuit::Circuit, gate::CommonGate)
    push!(circuit.gate_list, gate)
end

function add!(circuit::Circuit, gate::DenseGate)
    push!(circuit.gate_list, gate)
end

# function optimize(circuit::Circuit)
#     os = OpSum()
#     gates = []
#     for gate in circuit.gate_list
#         #os += (gate.name, gate.index)
#         if length(gate.data) > 0
#             push!(gates, gate.name, gate.index, gate.data)
#         else
#             push!(gates, gate.name, gate.index)
#         end
#     end
#     os += Tuple(gates)
#     return MPO(ComplexF64, os, circuit.state.sites)
# end

function optimize(circuit::Circuit)
    os = []
    for gate in circuit.gate_list
        if typeof(gate) == DenseGate
            d = []
            push!(d, gate.data)
            if length(gate.index) > 0
                push!(d, gate.index)
            end
            if length(gate.control) > 0
                push!(d, gate.control)
            end
            push!(os, Tuple(d))
        else
            g = []
            push!(g, gate.name)
            if gate.control > 0
                push!(g, gate.control)
            end
            push!(g, gate.index)
            if length(gate.data) > 0
                push!(g, gate.data)
            end
            push!(os, Tuple(g))
        end
    end
    return ops(os, circuit.state.sites)
end

# TODO: randomMPO()が正しいゲート（ユニタリ行列）を作成するか？
function createRandomGate(circuit::Circuit, depth::Int)
    return randomMPO(circuit.state.sites)
end

# function createRandomGate(circuit::Circuit, depth::Int)
#     os = OpSum()
#     gateType = ["X", "Y", "Z", "T", "H"]
#     dim = size(circuit.state.sites, 1)
#     #println("dim: $dim")
#     gates = []
#     for i = 1:depth
#         #println("(dim % i): $(i % (dim - 1) + 1)")
#         push!(gates, gateType[rand(1:5)], (i % (dim - 1) + 1))
#     end
#     os += Tuple(gates)
#     #print(gates)
#     return MPO(ComplexF64, os, circuit.state.sites)
# end

function apply(mpo::MPO, mps::MPS)
    return ITensors.apply(mpo, mps; cutoff=1e-15)
end

function apply(tensors::Vector{ITensor}, mps::MPS)
    return ITensors.apply(tensors, mps; cutoff=1e-15)
end

# # TODO: MPO から opsに変更したため動かなくなった。。
# function expect(mpo::MPO, mps::MPS)
#     return inner(mps', mpo, mps)
# end

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
