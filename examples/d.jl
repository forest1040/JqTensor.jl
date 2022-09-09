using ITensors

N = 3
s = siteinds("Qubit", N)
ψ0 = productMPS(s, "0")

os = OpSum()
os += ("CX", 1, 2)
gates = MPO(os, s)
print(gates)

ψ = apply(gates, ψ0; cutoff=1e-15)
r = inner(ψ1, p)

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ)
    #println("$index : $(value)")
    global V *= ψ[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end
