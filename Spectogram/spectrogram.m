clear all; close all; clc;                      % Clearing environment

[x,Fs]=audioread('signal.wav');              % Reading audio signal

%% Parameters
window = 512;   noverlap = 400;     nfft = 512;

%% Spectrogram
[s,f,t]=spectrogram(x,window,noverlap,nfft,Fs,'yaxis');  % Finding spectrogram

%% Plot
surf(t, f, 20*log10(abs(s)), 'edgecolor', 'none');
axis xy; 
axis tight; 
view(0,90);
xlabel('Time(Sec)');
colorbar;
ylabel('Frequency(Hz)');
title('Spectrogram Of the Signal');