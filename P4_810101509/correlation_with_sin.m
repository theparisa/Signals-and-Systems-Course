function integral_value = correlation_with_sin(recieverd_signal)
    f_s =100;

    t = (0:length(recieverd_signal) - 1)/f_s;

    product_values = recieverd_signal .* (2*sin(2 * pi * t));

    integral_value = trapz(t,product_values);

end