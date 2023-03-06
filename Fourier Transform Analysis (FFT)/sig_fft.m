clear; close all; clc;

Fs = 1500;      % Sampling Frequency in Hz
Ts = 1/Fs;      % Sampling Period in Sec
NN = 6000;      % No. of points in the signal (must be integer multiple of Fs for better results)
n = 0:NN-1;     % Sample index for x(n)

deg2rad = pi/180;       % Converts Degrees to Radians

x1_n = 20*sin(2*pi*300*n*Ts + deg2rad*20);  % First term in the signal
x2_n = -5*cos(2*pi*500*n*Ts - deg2rad*30);  % Second term in the signal
x3_n = 33*cos(2*pi*35*n*Ts + deg2rad*45);   % Third term in the signal

x_n = x1_n + x2_n + x3_n;                   % Composite Signal

figure
plot(n, x_n)
grid on
xlabel('Samples (n)')
ylabel('x(n)')
title('Signal in Time-Domain')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)


%% Computing the FFT of the Time-Domain Signal

X_k = fft(x_n);     % Taking Fourier Transform of the signal
k = 0:NN-1;         % Sample Index for X(k)

Mag_X_k_double_sided = abs(X_k)/NN;     % Calculating the magnitude of the double-sided spectrum
Phase_X_k = angle(X_k)/NN;                 % Calculating the phase of the double-sided spectrum

figure
subplot(2,1,1)
plot(k, Mag_X_k_double_sided,'b','LineWidth',2)
grid on
title('Double-Sided Spectrum, X(k), of the signal x(n)')
xlabel('Samples (k)')
ylabel('Magnitude of X(k)')
%h1 = findobj(gcf,'type','line');
%set(h1,'linewidth',2)


subplot(2,1,2)
plot(k, Phase_X_k)
grid on
xlabel('Samples (k)')
ylabel('Phase of X(k)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)


Freq_double_sided = k*Fs/NN;    % Converting the sample index in to Frequency

figure
% subplot(2,1,1)
plot(Freq_double_sided, Mag_X_k_double_sided)
grid on
title('Double-Sided Spectrum of the signal x(n)')
xlabel('Frequency (Hz)')
ylabel('Magnitude of X(k)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)


Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);            % compute the single-sided spectrum from the double-sided spectrum.
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);  % Multiplying the single-sided spectrum components by two except the DC component
k1 = 0:(NN/2)-1;                                                % Sample Axis for Single-sided spectrum

figure
plot(k1, Mag_X_k_single_sided)
grid on
title('Single-Sided Spectrum of the signal x(n)')
xlabel('Samples (k)')
ylabel('Magnitude of X(k)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)


freq = Fs*(k1)/NN;      % Converting the sample index in to Frequency

figure
plot(freq, Mag_X_k_single_sided)
grid on
title('Single-Sided Spectrum of the signal x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%%

x_inv = ifft(X_k);      % Taking the inverse Fourier Transform of the signal to get the time-domain signal

figure,
plot(n, x_n)
hold on
plot(n, x_inv,'--r')
hold off
grid on
legend('x(n)','x_i_n_v(n)')
xlabel('Samples (n)')
ylabel('x(n)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)
title('Signal before and after FFT')
