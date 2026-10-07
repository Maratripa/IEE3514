function [u, eN] = randu(N, e0)
    u = zeros(1, N);
    u(1) = 16807 * e0 - floor((16807*e0)/2147483647)*2147483647;

    for i=2:N
        u(i) = 16807 * u(i - 1) - floor((16807 * u(i - 1))/2147483647)*2147483647;
    end

    eN = u(N);
    u = u ./ 2147483647;
end
