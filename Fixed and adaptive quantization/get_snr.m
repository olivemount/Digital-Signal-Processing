function valor_snr = get_snr(x, y)
    err = y - x;
    ee = sum(err .* err, 2) + 10E-20;
    ex = sum(x .* x, 2);
    valor_snr = 10 * log10(ex ./ ee);
end