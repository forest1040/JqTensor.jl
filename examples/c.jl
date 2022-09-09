using ITensors

N = 3
s = ITensors.siteinds("Qubit", N)

# Make all of the operators
X = ITensors.ops(s, [("X", n) for n in 1:N])
H = ITensors.ops(s, [("H", n) for n in 1:N])
CX = ITensors.ops(s, [("CX", n, m) for n in 1:N, m in 1:N])
# print(X)
# print(H)
# print(CX)

# Start with the state |0000...⟩
ψ0 = ITensors.productMPS(s, "0")
#print(ψ0)

# Change to the state |1010...⟩
#gates = [X[n] for n in 1:2:N]
#gates = [CX[n, n+1] for n in 1:2:N-1]
gates = [CX[1, 2]]
#print(gates)
ψ = ITensors.apply(gates, ψ0; cutoff=1e-15)
#@assert inner(ψ, productMPS(s, n -> isodd(n) ? "1" : "0")) ≈ 1
print(ψ)

