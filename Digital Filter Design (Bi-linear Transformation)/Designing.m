clear; close all; clc;                      %Clearing MATLAB environment

%% Audio Signal + Noise

[x_sn, Fs] = audioread('noisysig.wav');     % Reading audio signal into MATLAB
Ts = 1/Fs;                                  % Sampling Time
n = length(x_sn);                           % Samples (n)
n = 1:n;

%% Analyzing the Spectrum of the Input Signal in order to choose cutoff frequency of the filter

NN = length(x_sn);  % Finding no. of samples in the input signal

X_k = fft(x_sn);    % Finding spectrum of the input signal
k = 0:NN-1;

Mag_X_k_double_sided = abs(X_k)/NN; % Calculating Magnitude Spectrum 
Phase_X_k = angle(X_k);             % Calculating Phase Spectrum  

Freq_double_sided = k*Fs/NN;        % Converting k in to Frequency

Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);   % computing the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);    % Ignoring the DC component
k1 = 0:(NN/2)-1;                    % Sample Axis for DFT

freq = Fs*(0:(NN/2)-1)/NN;          % Converting k in to Frequency

% Plotting Magnitude Spectrum of the Single-Sided Spectrum
figure
plot(freq, Mag_X_k_single_sided)
grid on
title('Single-Sided Spectrum of the signal x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')

%% Analog Low-Pass filter design
% As noise lies above 10 KHz, the cut-off frequency is chosen to be 1 KHz.
% The transfer function of the analog filter is derived using the sisotool.

s = tf('s');                                            % Defining "s" for Analog Filter
H_s = (847.8*(s+1.176e05))/((s+1.695e04)*(s+5882));     % Analog Filter Transfer Function

%% Plotting the Bode Plot for the filter
figure
bode(H_s)
grid on
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%% Taking the analog filter into the Z-domain (Discretizing)

z = tf('z',Ts);             % Defining z for digital filter at sampling rate of Ts

ZZ = (2/Ts)*(z-1)/(z+1);    % Bilinear Transformation

H_z = (847.8*(ZZ+1.176e05))/((ZZ+1.695e04)*(ZZ+5882)); % Transfer Function in z-domain

%% Comparing the Digtial Filter with the Analog Filter
figure
bode(H_s)
hold on
bode(H_z,'--r')
hold off
grid on
legend('H(s)','H(z)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)
