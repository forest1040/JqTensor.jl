using ITensors

N = 3
s = ITensors.siteinds("Qubit", N)
ψ0 = ITensors.productMPS(s, "0")

os = [("X", 1), ("CX", 1, 2)]
gates = ops(os, s)

mpo = MPO(gates)
print("mpo: $mpo")
# r = ITensors.inner(ψ0', mpo, ψ0)
# print("r: $r")

ψ = ITensors.apply(mpo, ψ0; cutoff=1e-15)

ψ = ITensors.apply(gates, ψ0; cutoff=1e-15)

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ)
    #println("$index : $(value)")
    global V *= ψ[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end
