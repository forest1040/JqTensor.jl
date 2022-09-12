using ITensors
using JqTensor

N = 2
# Qubit設定
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
#print(psi0)

# ゲート作成
#JqTensor.add!(circuit, JqTensor.Rx(1, π))
JqTensor.add!(circuit, JqTensor.Rx(1, 1.0))
gates = JqTensor.optimize(circuit)

# ゲート適用
println("start apply")
psi = JqTensor.apply(gates, psi0)
#println("psi: $psi")
println("end apply")

# 状態ベクトル表示
showStateVector(psi)

println("------------------------")

# CRx
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
JqTensor.add!(circuit, JqTensor.X(1))
#JqTensor.add!(circuit, JqTensor.X(2))
JqTensor.add!(circuit, JqTensor.CRz(1, 2, π))
#JqTensor.add!(circuit, JqTensor.CNOT(1, 2))
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)

println("------------------------")

# DenseGate
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
JqTensor.add!(circuit, JqTensor.X(1))
#JqTensor.add!(circuit, JqTensor.X(2))
JqTensor.add!(circuit, JqTensor.DenseGate(
    "test",
    2,
    [
        0 1
        1 0
    ]
))
#JqTensor.add!(circuit, JqTensor.CNOT(1, 2))
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)
