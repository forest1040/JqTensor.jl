using ITensors

N = 3

# ITensorsの閾値設定
if N > 13
    ITensors.set_warn_order(N + 1)
end

# Qubit設定
s = ITensors.siteinds("Qubit", N)

# 初期状態
ψ0 = ITensors.productMPS(ComplexF64, s, "0")

# ゲート作成
#println("CX(0, 1)")
os = ITensors.OpSum()
os += ("Rx", 1, (θ=π,)) # Juliaは1オリジン
#os += ("CX", 1)
#os += ("SWAP", 1, 2)
gates = ITensors.MPO(ComplexF64, os, s)

# ゲート適用
ψ = ITensors.apply(gates, ψ0; cutoff=1e-15)

# 期待値
r = ITensors.inner(ψ0', gates, ψ0)
println("inner: $r\n\n")

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ)
    #println("$index : $(value)")
    global V *= ψ[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end
