using ITensors

N = 3
s = siteinds("Qubit", N)
ψ0 = productMPS(s, "0")
X1 = op("X", s[1])
X3 = op("X", s[3])
ψ1 = apply(X1, ψ0; cutoff=1e-15)
ψ2 = apply(X3, ψ1; cutoff=1e-15)

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ2)
    global V *= ψ2[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end

println("-----------------------------")

X1 = op([
        0 1
        1 0
    ], s[1])
X3 = op("X", s[3])
ψ1 = apply(X1, ψ0; cutoff=1e-15)
ψ2 = apply(X3, ψ1; cutoff=1e-15)

# 状態ベクトル表示
V = ITensor(1.0)
for (index, value) in enumerate(ψ2)
    global V *= ψ2[index]
end
for (index, value) in enumerate(V)
    println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
end

println("-----------------------------")

os = [([
            0 1
            1 0
        ], 1), ([
            0 1
            1 0
        ], 3)]
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
