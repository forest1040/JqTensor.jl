using JqTensor
using Test

#using ITensors

@testset "JqTensor.jl" begin

    # N = 3

    # # ITensorsの閾値設定
    # if N > 13
    #     ITensors.set_warn_order(N + 1)
    # end

    # # Qubit設定
    # s = siteinds("Qubit", N)

    # # 初期状態
    # ψ0 = productMPS(ComplexF64, s, "0")

    # # ゲート作成
    # println("H(0)")
    # os = OpSum()
    # os += ("H", 1) # Juliaは1オリジン
    # gates = MPO(ComplexF64, os, s)

    # # ゲート適用
    # ψ = apply(gates, ψ0; cutoff=1e-15)

    # # 期待値
    # r = inner(ψ0', gates, ψ0)
    # println("inner: $r\n\n")

    N = 3
    # Qubit設定
    circuit = Circuit(N)
    psi0 = create_zero_state(circuit.state.sites)
    #print(psi0)

    # ゲート作成
    H0 = Gate("H", 1)
    add!(circuit, H0)
    H1 = Gate("H", 2)
    add!(circuit, H1)
    gates = JqTensor.optimize(circuit)

    # 期待値
    expect_value = expect(gates, psi0)
    println("expect_value: $expect_value")

    # ゲート適用
    psi = apply(gates, psi0)
    #println("psi: $psi")

    # 状態ベクトル表示
    show_state_vector(psi)

end
