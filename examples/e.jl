using ITensors

N = 3
s = ITensors.siteinds("Qubit", N)
ψ0 = ITensors.productMPS(s, "1")

os = [([
        1 0 0 0
        0 1 0 0
        0 0 cos(π / 2) -sin(π / 2)
        0 0 sin(π / 2) cos(π / 2)
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

os = [([
        cos(π / 2) -sin(π / 2)
        sin(π / 2) cos(π / 2)
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
