%% Inicializo ambiente
clear variables;
close all;
clc;

%% Audio y datos de entrada
Tc = 5;
fs = 8000;
r = 24;
ID = 0;
recobj = grabar_audio(Tc, fs, r, ID);
raw = getaudiodata(recobj)';
audiowrite('exmp.wav', raw, fs);
t = 0:1/fs:Tc - 1/fs;

% Bits de cuantizacion
rp = [18 14 8 4];

%% Cuantizacion por factor de escala fijo
fijo = fixed_quantization(raw, rp, 1);

%% Cuantizacion por factor de escala adaptivo
adaptivo = adaptive_quantization(raw, rp, 3, fs);

%% SNR total
SNRt_fijo = get_snr(raw, fijo)';

SNRt_adaptivo = get_snr(raw, adaptivo)';

%% SNR por bloques
[x_snrbf, SNRb_fijo] = block_snr(raw, fijo, fs, 0.03);
[x_snrba, SNRb_adaptivo] = block_snr(raw, adaptivo, fs, 0.03);

%% Graficas

figure(1)

% Fila de audio sin recuantizar
subplot(3, 4, 1)
plot(t, raw, 'b')
title('Señal sin recuantizar')
ylabel('Q_x')
xlabel('x(t)')
grid on;

% Fila de audio por escalas de cuantizacion fijas
subplot(3, 4, 5)
plot(t, fijo(1, :), 'b')
title('Fe fijo, r_p=18')
ylabel('Q_x')
xlabel('x(t)')
grid on;

subplot(3, 4, 6)
plot(t, fijo(2, :), 'b')
title('Fe fijo, r_p=14')
ylabel('Q_x')
xlabel('x(t)')
grid on;

subplot(3, 4, 7)
plot(t, fijo(3, :), 'b')
title('Fe fijo, r_p=8')
ylabel('Q_x')
xlabel('x(t)')
grid on;

subplot(3, 4, 8)
plot(t, fijo(4, :), 'b')
title('Fe fijo, r_p=4')
ylabel('Q_x')
xlabel('x(t)')
grid on;

% Fila de audios por escalas de cuantizacion adaptativas
subplot(3, 4, 9)
plot(t, adaptivo(1, :), 'b')
title('Fe adaptivo, r_p=18')
ylabel('Q_x')
xlabel('x(t)')
grid on;

subplot(3, 4, 10)
plot(t, adaptivo(2, :), 'b')
title('Fe adaptivo, r_p=14')
ylabel('Q_x')
xlabel('x(t)')
grid on;

subplot(3, 4, 11)
plot(t, adaptivo(3, :), 'b')
title('Fe adaptivo, r_p=8')
ylabel('Q_x')
xlabel('x(t)')
grid on;

subplot(3, 4, 12)
plot(t, adaptivo(4, :), 'b')
title('Fe adaptivo, r_p=4')
ylabel('Q_x')
xlabel('x(t)')
grid on;


% Plots de SNR fijo
figure(2)
subplot(2, 2, 1)
stem(rp, SNRt_fijo, 'b')
title('SNR Total')
ylabel('Q_x')
xlabel('r_p')
grid on;

subplot(2, 2, 2)
plot(x_snrbf, SNRb_fijo(1, :), 'r')
title('SNR bloques')
ylabel('SNR_(db)')
xlabel('r_p')
grid on;
hold on;

plot(x_snrbf, SNRb_fijo(2, :), 'g')
hold on;
plot(x_snrbf, SNRb_fijo(3, :), 'b')
hold on;
plot(x_snrbf, SNRb_fijo(4, :), 'y')
hold on;

figure(3);
tiempo_ventana = 30*1e-3;
tiempo_traslape = 0;
tam_ventana = fs*tiempo_ventana;
tam_traslape = fs*tiempo_traslape;
nfft = 2^nextpow2(tam_ventana);

[S, F, T] = spectrogram(raw, tam_ventana, tam_traslape, nfft, fs, 'yaxis');