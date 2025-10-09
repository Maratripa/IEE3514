function [prbs, eN] = prbs15(N, e0)
    prbs = zeros(1, N + 15);
    prbs(1:15) = e0(15:-1:1);
    
    for i=1:N
        prbs(15 + i) = prbs(i) ~= prbs(i + 14);
    end
    
    eN = prbs(N+15:-1:N+1);
    prbs = prbs(16:N+15);
end
