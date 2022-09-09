using ITensors
using JqTensor

N = 3
# Qubit設定
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
#print(psi0)

# ゲート作成
JqTensor.add!(circuit, JqTensor.H(1))
JqTensor.add!(circuit, JqTensor.H(2))
#JqTensor.add!(circuit, JqTensor.H(3))
gates = JqTensor.optimize(circuit)

# 期待値
expect_value = JqTensor.expect(gates, psi0)
println("expect_value: $expect_value")

# ゲート適用
println("start apply")
psi = JqTensor.apply(gates, psi0)
#println("psi: $psi")
println("end apply")

# 状態ベクトル表示
showStateVector(psi)
