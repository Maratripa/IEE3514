function prbs15(N::Integer, e0::AbstractVector)
    length(e0) == 15 || throw(ArgumentError("e0 must have 15 elements"))
    
    prbs = zeros(Bool, N + 15)
    prbs[1:15] = e0[15:-1:1]

    for i=1:N
        prbs[15 + i] = xor(prbs[i], prbs[i + 14])
    end

    eN = prbs[N+15:-1:N+1]
    return prbs[16:N+15], eN
end
