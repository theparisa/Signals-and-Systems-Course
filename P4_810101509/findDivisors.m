function divisors = findDivisors(n)
    divisors = [];
    for k = 1:n
        if mod(n,k) == 0
            divisors = [divisors, k];
        end
    end
end


