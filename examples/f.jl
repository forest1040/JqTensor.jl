using ITensors

N = 2
s = ITensors.siteinds("Qubit", N)
ψ0 = ITensors.productMPS(s, "0")

os = [("X", 1),([
    1 0 0 0
    0 1 0 0
    0 0 exp(-im * π / 2 * 2) 0
    0 0 0 exp(im * π / 2 * 2)
    ], 2, 1)]
gates = ops(os, s)

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

println("-----------------------------")

os = [("X", 1),([
    exp(-im * π / 2 * 2) 0
    0 exp(im * π / 2 * 2)
    ], 2)]
gates = ops(os, s)

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
