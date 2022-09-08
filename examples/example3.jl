using ITensors
using JqTensor

N = 5
# Qubit設定
circuit = Circuit(N)
psi0 = createZeroState(circuit.state.sites)
#print(psi0)

# ゲート作成
gates = JqTensor.createRandomGate(circuit, 10)

# 期待値
expect_value = JqTensor.expect(gates, psi0)
println("expect_value: $expect_value")

# ゲート適用
psi = JqTensor.apply(gates, psi0)
#println("psi: $psi")

# 状態ベクトル表示
showStateVector(psi)
