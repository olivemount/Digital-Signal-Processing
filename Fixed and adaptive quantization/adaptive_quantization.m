function y = adaptive_quantization(x, rp, tb, fs)
    y = zeros(length(rp), length(x));
    steps = tb * fs;

    for i=1:steps:length(x)-steps
        curr_block = x(i:i+steps);
        fe = max(abs(curr_block));
        y(1:length(rp), i:i+steps) = fixed_quantization(curr_block, rp, fe);
    end

    remainder = mod(length(x), steps);
    if remainder
        curr_block = x(end - remainder: end);
        y(1:length(rp), end - remainder:end) = fixed_quantization(curr_block, rp, fe);
    end