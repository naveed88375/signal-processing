clear; close all; clc;


%% Discrete-Time Signal + Noise

[x_sn, Fs] = audioread('sig.wav');
Ts = 1/Fs;            % Sampling Time
n = length(x_sn);     % Samples (n)
n = 1:n;

% Plot the input Signal
figure
plot(n,x_sn)        
grid on
xlabel('Samples (n)')
ylabel('Amplitude')
title('Time Domain Signal')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%% Analyzing the Spectrum of the Input Signal

NN = length(x_sn);  % Finding no. of samples in the input signal

X_k = fft(x_sn);    % Finding spectrum of the input signal
k = 0:NN-1;

Mag_X_k_double_sided = abs(X_k)/NN; % Calculating Spectrum Magnitude 
Phase_X_k = angle(X_k);             % Calculating Spectrum Phase 

Freq_double_sided = k*Fs/NN;        % Converting k in to Frequency

Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);   % compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);    % Ignoring the DC component
k1 = 0:(NN/2)-1;                  % Sample Axis for DFT

freq = Fs*(0:(NN/2)-1)/NN;          % Converting k in to Frequency

% Plotting Magnitude Spectrum of the Single-Sided Spectrum
figure
plot(freq, Mag_X_k_single_sided)
grid on
title('Single-Sided Spectrum')
xlabel('Frequency (Hz))')
ylabel('Amplitude')