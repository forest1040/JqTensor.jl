using ITensors
using JqTensor

N = 8
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
gates = JqTensor.createRandomGate(circuit, 10)
psi = JqTensor.apply(gates, psi0)
#println("psi: $psi")
showStateVector(psi)

# psi = createRandomCircuit(N, 10)
# showStateVector(psi)
