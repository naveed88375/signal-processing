clear; close all; clc;  %Clear MATLAB environment

%Read signal
[sig, Fs] = audioread('Chilling.wav');
%Set noise frequency
noise_freq = 5.5e5;
%Total samples in signal
n = length(sig);
%Take signal Discrete Cosine Transform
SIG = dct(sig);
%Generate random noise signal
noise = zeros(n,1);
l=noise(noise_freq:end);
ll = randn(size(l));
noise(noise_freq:end)=ll;
%Add noise to signal
SIG=SIG+0.5*noise;
%Inverse DCT
noisy_sig=idct(SIG);
%Write noisy signal to file
audiowrite('noisysig.wav',noisy_sig,Fs);
%Plot clean and noisy signal spectrum
subplot 121; plot(dct(sig),'b'), title('Clean signal');
subplot 122; plot(SIG,'b'), title('Noisy signal'); 


