clear; close all; clc;                      % Clearing MATLAB Enviornment

%% Input Sequence 
x_n = [ones(1,10) zeros(1,5) ones(1,10)];   % Input Sequence, x(n)
NN_x=length(x_n);                           % Length of sequence x(n) 
n_x = 0:(NN_x-1);                           % Samples Number (n) for x(n)

%% System Impulse Response 
h_n = ones(1,10);                           % Impulse Response, h(n)
NN_h=length(h_n);                           % Length of sequence h(n)
n_h = 0:(NN_h-1);                           % Samples Number (n) for h(n)

%% Plot input signal and impulse response
figure
subplot 211, stem(x_n), grid, xlabel('Index (n)'), ylabel('y(n)'), title('Input signal');
subplot 212, stem(h_n), grid, xlabel('Index (n)'), ylabel('y(n)'), title('Impulse Response');

%% Limits of Output Sequence
low_limit = n_x(1)+n_h(1);                    % Lower Limit of Sample Number for Output Sequence
upper_limit = n_x(NN_x)+n_h(NN_h);            % Upper Limit of Sample Number for Output Sequence
n_y = low_limit:1:upper_limit;                % Sample Number (n) for Output Sequence 
NN_y = length(n_y);                           % Number of samples in Output Sequence

X = [x_n,zeros(1,NN_h)];                      % Padding zeros in x(n) to make the length of sequence equal to x(n)+h(n)
H = [h_n,zeros(1,NN_x)];                      % Padding zeros in h(n) to make the length of sequence equal to x(n)+h(n)

%% Finding Response of the system using Convolution

y2_n = conv(x_n, h_n);  % Output sequence using Conv

% Comparing the output sequences
figure 
stem(n_y,y2_n,'--r')
hold off
grid on
xlabel('Index (n)') 
ylabel('y(n)') 
title('Output Sequence using Convolution') 
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)


%% Finding System Response using Fourier Transform

X3 = [x_n,zeros(1,NN_h)];     % Padding zeros in x(n) to make the length of sequence equal to x(n)+h(n)
H3 = [h_n,zeros(1,NN_x)];     % Padding zeros in h(n) to make the length of sequence equal to x(n)+h(n)

X3_FFT = fft(X3);             % Fourier Transform of the Input Sequence
H3_FFT = fft(H3);             % Fourier Transform of the Impulse Response

Y3_FFT = X3_FFT.*H3_FFT;      % Fourier Transform of the Output Sequence

y3_n = ifft(Y3_FFT);          % Taking inverse Fourier Transform of Y3 to get the output sequence in time domain

figure
stem(n_y,y2_n)
hold on
stem(n_y,y3_n(1:length(n_y)),'--r')
hold off
grid on
xlabel('Index (n)') 
ylabel('y(n)') 
legend('Output using Convolution','Output using FFT')
title('Output Sequence using Convolution and FFT') 
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

