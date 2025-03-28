function y = fixed_quantization(x, rp, fe)
    disp(length(x))
    y = zeros(length(rp), length(x));
    for i=1:length(rp)
        yp = round((x/fe) * (2^(rp(i)-1) - 1));
        y(i,:) = (yp * fe)/(2^(rp(i)-1) - 1);
    end
end