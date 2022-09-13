using ITensors
using JqTensor

N = 3
# Qubit設定
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
#print(psi0)

println("RX ------------------------")

JqTensor.add!(circuit, JqTensor.Rx(1, 1.0))
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)

println("SWAP ------------------------")

JqTensor.add!(circuit, JqTensor.X(1))
JqTensor.add!(circuit, JqTensor.SWAP(1, 3))
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)

println("CRz ------------------------")

circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
JqTensor.add!(circuit, JqTensor.X(1))
JqTensor.add!(circuit, JqTensor.CRz(1, 2, π))
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)

println("DenseGate ------------------------")

circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
g = JqTensor.DenseGate(
    "test",
    [1],
    [
        0 1
        1 0
    ]
)
JqTensor.add!(circuit, g)
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)

println("Toffoli ------------------------")

circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
JqTensor.add!(circuit, JqTensor.X(1))
JqTensor.add!(circuit, JqTensor.X(2))
JqTensor.add!(circuit, JqTensor.Toffoli(1, 2, 3))
gates = JqTensor.optimize(circuit)
psi = JqTensor.apply(gates, psi0)
showStateVector(psi)
