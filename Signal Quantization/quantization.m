%Clearing matlab environment
clear; close all; clc;
% Times at which to sample the sine function
t = [0:.1:2*pi];
% Original signal, a sine wave
csg = cos(3*t)+2*cos(2*t);  
% Length 11, to represent 12 intervals
partition = [-6:.3:6]; 
% Length 12, one entry for each interval
codebook = [-6.3:.3:6];     
% Quantize signal
[index,quants] = quantiz(csg,partition,codebook); 
%Plot result
plot(t,csg,t,quants,'o'), grid
legend('Original signal','Quantized signal');
axis([-.2 7 -1.2 1.2])
title("Signal Quantization")