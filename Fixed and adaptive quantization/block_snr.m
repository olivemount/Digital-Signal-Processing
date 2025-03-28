function [x_axis, valor_snr_bloque] = block_snr(x, y, fs, tb)
    steps = (tb * fs); % - 1
    nblocks = floor(length(x)/steps);
    valor_snr_bloque = zeros(height(y), nblocks);
    x_axis = 1:nblocks;

    col = 1;
    for i=0:steps:length(x) - steps
        curr_block_x = x(i+1:i+steps);
        curr_block_y = y(:,i+1:i+steps);
        valor_snr_bloque(1:height(y), col) = get_snr(curr_block_x, curr_block_y);
        col = col + 1;
    end
end