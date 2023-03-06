clear; close all; clc;

%% Discrete-Time Signal + Noise

n = 1:2000;     % Samples (n)

f_signal = 50;  % Desirable Signal Frequency
f_noise = 10e3; % Noise Frequency
Fs = 50e3;      % Sampling Frequency
Ts = 1/Fs;      % Sampling Time

x_signal = 280*sqrt(2)*sin(2*pi*f_signal*Ts*n);     % Desirable Signal
x_noise = 50*sin(2*pi*f_noise*Ts*n);                % Noise Signal

x_sn = 2.5 + 0.005*(x_signal + x_noise);    % Input Signal = Desirable Signal + Noise

% Plot the input Signal
figure
plot(n,x_sn)        
grid on
xlabel('Samples (n)')
ylabel('Voltage (v)')
title('Input Signal + Noise')
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
title('Single-Sided Spectrum of the signal x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')

%% Analog Low-Pass Filter with 1kHz Cut-off Frequency

% Since the noise frequency is 10kHz, an analog filter is designed with a
% cutoff frequency of 1kHz.

s = tf('s');    % Defining "s" for Analog Filter

H_s = (1+8.5e-6*s)/((1+5.9e-5*s)*(1+0.00017*s));    % Analog Filter Transfer Function

% Plotting the Bode Plot for the Analog Filter
figure
bode(H_s)
grid on
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%% Discretization of Low-Pass Filter

% The following lines of code discretizes the above designed analog filter.

z = tf('z',Ts); % Defining "z" for Digital Filter at sampling time Ts

ZZ = (2/Ts)*(z-1)/(z+1);    % Bilinear Transformation

H_z = (1+8.5e-6*ZZ)/((1+5.9e-5*ZZ)*(1+0.00017*ZZ)); % Digital Filter Transfer Function

% Comparing the Digtial Filter with the Analog Filter
figure
bode(H_s)
hold on
bode(H_z,'--r')
hold off
grid on
legend('H(s)','H(z)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%% Calculating IIR Filter Output 

y_vector = zeros(1,NN);     % Initializing the Filter Output Vector

% Initializing the variables needed for computing the Filter Output
y_n_3 = 0;      
y_n_2 = 0;
y_n_1 = 0;

x_n_3 = 0;
x_n_2 = 0;
x_n_1 = 0;

% Calculating the Filter Output one sample at a time
for ii = 1:NN
    
    x_n = x_sn(ii);     % Get new Input sample and assign it to x(n)
    
    % The Filter Transfer Function in z-domain can be converted into a
    % difference equation. We have done few examples in the class. The
    % above designed H(z) will give the following diff eqt.
    
    % Calculate the output sample y(n)
    
    y_n = (2.7/448) * x_n + (4.7/448)*x_n_1 + (1.3/448)*x_n_2 - (0.7/448)*x_n_3 + (352.4/448)*y_n_1 + (444/448)*y_n_2 - (356.4/448)*y_n_3;
    
    % Save it to the output vector
    y_vector(ii) = y_n;
    
    % Update the previous samples
    y_n_3 = y_n_2;
    y_n_2 = y_n_1;
    y_n_1 = y_n;

    x_n_3 = x_n_2;
    x_n_2 = x_n_1;
    x_n_1 = x_n;

end

% Plot the Input noisy signal and output filtered signal
figure
plot(n,x_sn)
hold on
plot(n, y_vector,'r')
hold off
grid on
xlabel('Samples (n)')
ylabel('Voltage (V)')
title('Filtering Noise from Signal Using IIR Filter')
legend('Signal + Noise','IIR Filtered Signal')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%% Calculating FIR Filter Output  

% An FIR filter is a running average filter. In the following few lines, an
% averaging filter of order 5, 10 and 15 is implemented. 

y_vector_2 = zeros(1,NN);   % Initializing the Filter Output Vector

% Initializing the variables needed for computing the Filter Output
x2_n_15 = 0;
x2_n_14 = 0;
x2_n_13 = 0;
x2_n_12 = 0;
x2_n_11 = 0;
x2_n_10 = 0;
x2_n_9 = 0;
x2_n_8 = 0;
x2_n_7 = 0;
x2_n_6 = 0;
x2_n_5 = 0;
x2_n_4 = 0;
x2_n_3 = 0;
x2_n_2 = 0;
x2_n_1 = 0;

% Calculating the Filter Output one sample at a time
for ii = 1:NN
    
    x2_n = x_sn(ii);    % Get new Input sample and assign it to x(n)
    
    % Calculate the FIR Filter Output for M = 5
%     y2_n = (1/5)*(x2_n + x2_n_1 + x2_n_2 + x2_n_3 + x2_n_4 + x2_n_5);

    % Calculate the FIR Filter Output for M = 10
%     y2_n = (1/10)*(x2_n + x2_n_1 + x2_n_2 + x2_n_3 + x2_n_4 + x2_n_5 + x2_n_6 + x2_n_7 + x2_n_8 + x2_n_9 + x2_n_10);

    % Calculate the FIR Filter Output for M = 15
    y2_n = (1/15)*(x2_n + x2_n_1 + x2_n_2 + x2_n_3 + x2_n_4 + x2_n_5 + x2_n_6 + x2_n_7 + x2_n_8 + x2_n_9 + x2_n_10 + x2_n_11 + x2_n_12 + x2_n_13 + x2_n_14 + x2_n_15);
    
    % Save it to the output vector
    y_vector_2(ii) = y2_n;
    
    % Update the previous samples
    x2_n_15 = x2_n_14;
    x2_n_14 = x2_n_13;
    x2_n_13 = x2_n_12;
    x2_n_12 = x2_n_11;
    x2_n_11 = x2_n_10;
    x2_n_10 = x2_n_9;
    x2_n_9 = x2_n_8;
    x2_n_8 = x2_n_7;
    x2_n_7 = x2_n_6;
    x2_n_6 = x2_n_5;
    x2_n_5 = x2_n_4;
    x2_n_4 = x2_n_3;
    x2_n_3 = x2_n_2;
    x2_n_2 = x2_n_1;
    x2_n_1 = x2_n;

end

% Plot the Input noisy signal and output filtered signal
figure
plot(n,x_sn)
hold on
plot(n, y_vector_2,'r')
hold off
grid on
xlabel('Samples (n)')
ylabel('Voltage (V)')
title('Filtering Noise from Signal Using FIR Filter')
legend('Signal + Noise','FIR Filtered Signal')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

