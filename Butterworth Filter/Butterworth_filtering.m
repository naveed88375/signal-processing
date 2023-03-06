clear; close all; clc;  %Clear MATLAB environment

%Read noisy audio signal
[y, Fs] = audioread('noisy_sig.wav');
%Set filter parameters
order = 5;
wc = 2*pi*((0.8*10^3)/Fs);              % Normalized cut-off frequency
[b,a] = butter(order,wc);
%Filter noisy signal
clean = filter(b,a,y);
%Write the clean signal to file
audiowrite('clean_sig.wav',clean,Fs);

%Visualize noisy and clean signal spectrum
subplot(2,1,1)
plot(dct(y))
title('Noisy signal spectrum')
subplot(2,1,2)
plot(dct(clean))
title('Clean signal spectrum')