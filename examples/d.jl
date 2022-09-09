using ITensors

N = 3
s = ITensors.siteinds("Qubit", N)
ψ0 = ITensors.productMPS(s, "1")

# op("CRx", s, (1, 2); θ=x)
#os = [("X", 1), ("CRx", (θ=π,), 1, 2)]

os = ITensors.OpSum() + ("CRz", (ϕ=π,), 1, 2)
os2 = ITensors.OpSum() + ("CRz", 1, 2, (ϕ=π,),)

# println("length(os): $(length(os))")
# println("ITensors.which_op(os[1][1]): $(ITensors.which_op(os[1][1]))")
# println("ITensors.params(os[1][1]): $(ITensors.params(os[1][1]))")

println("os: $os")
println("os2: $os2")

#gates = ITensors.MPO(ComplexF64, os, s)

# gates = ops(os, s)
# println("gates: $gates")

# ψ = ITensors.apply(gates, ψ0; cutoff=1e-15)

# # 状態ベクトル表示
# V = ITensor(1.0)
# for (index, value) in enumerate(ψ)
#     #println("$index : $(value)")
#     global V *= ψ[index]
# end
# for (index, value) in enumerate(V)
#     println("|$(bitstring(index-1)[end-N+1:end])>: $(value)")
# end
