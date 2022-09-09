module JqTensor

using ITensors, LinearAlgebra, Random

import Base: length,
    copy,
    push!,
    isless,
    delete!,
    getindex,
    setindex,
    findfirst,
    deleteat!,
    print,
    show,
    replace!,
    reverse,
    size,
    +,
    -,
    *,
    /,
    ==,
    isapprox,
    pop!,
    range,
    clamp,
    Irrational
import LinearAlgebra: norm,
    normalize!
import ITensors: getindex,
    noprime,
    noprime!,
    prime,
    svd,
    qr,
    position!,
    setindex!,
    commonindex,
    iterate,
    ITensor,
    Index,
    norm,
    order,
    *,
    dag

# functions from Base, ITensors
export linkindex,
    getindex,
    noprime,
    noprime!,
    prime,
    svd,
    position!,
    setindex!,
    svd,
    commonindex,
    leftLim,
    rightLim,
    iterate,
    ITensor,
    Index,
    randomITensor,
    qr,
    IndexSet,
    order,
    norm

# Types
export State,
    Circuit,
    Gate

include("gate.jl")
export Gate,
    I, X, Y, Z, H, S, T, P,
    Rx, Ry, Rz,
    CX, CNOT

include("state.jl")
export State,
    createZeroState,
    createRandomState

include("circuit.jl")
export Circuit,
    add!,
    optimize,
    createRandomGate,
    apply,
    #expect,
    showStateVector

export say_hello5

say_hello5() = println("Hello5!")

end
