clear; close all; clc;              % Clearing MATLAB environment

%% Transfer function of the designed filter in z-Domain

%   1.745e08 z^3 + 3.739e08 z^2 + 2.243e08 z + 2.493e07
%   ---------------------------------------------------
%   9.893e09 z^3 - 5.466e09 z^2 - 9.494e09 z + 5.865e09


%% Filtering the input noisy signal

[sig, Fs] = audioread('noisysig.wav');           % Reading the signal into MATLAB environment

n = length(sig);                                 % Length of the input signal

%% Calculating Filter Output

clean_sig = zeros(1,n);                          % Initializing the Filter Output Vector

% First of all the filter difference equation derived from the transfer function in z-domain is expressed as:

% y(n)=(17.45/989.3)*x(n)+(37.39/989.3)*x(n-1)+(22.43/989.3)*x(n-2)+(2.493/989.3)*x(n-3)+(546.6/989.3)*y(n-1)+(949.4/989.3)*y(n-2)-(586.5/989.3)*y(n-3)

% Initializing the variables needed for computing filter Output
y_n_3 = 0;      
y_n_2 = 0;
y_n_1 = 0;

x_n_3 = 0;
x_n_2 = 0;
x_n_1 = 0;

% Calculating the Filter Output one sample at a time
for ii = 1:n
    
    x_n = sig(ii);     % Getting new Input sample and assigning it to x(n)
    
    % Calculating the output sample y(n)
    
    y_n = (17.45/989.3) * x_n + (37.39/989.3)*x_n_1 + (22.43/989.3)*x_n_2 + (2.493/989.3)*x_n_3 + (546.6/989.3)*y_n_1 + (949.4/989.3)*y_n_2 - (586.5/989.3)*y_n_3;
    
    clean_sig(ii) = y_n;            % Storing the sample to the output vector
    
    % Updating the previous samples
    y_n_3 = y_n_2;
    y_n_2 = y_n_1;
    y_n_1 = y_n;

    x_n_3 = x_n_2;
    x_n_2 = x_n_1;
    x_n_1 = x_n;

end

audiowrite('filtered_signal.wav',clean_sig,Fs);  % Writing the clean signal to a new wav file

%% Analyzing the spectrum of the noisy and filtered signal

NN = length(sig);                          % Input signal length

X_k = fft(sig);                            % Taking the noisy signal to frequency domain
X_c = fft(clean_sig);                      % Taking the filtered signal to frequency domain
k = 0:NN-1;

Mag_X_k_double_sided = abs(X_k)/NN;         % Magnitude Spectrum of noisy signal
Phase_X_k = angle(X_k);                     % Phase Spectrum of noisy signal

Mag_X_c_double_sided = abs(X_c)/NN;         % Magnitude Spectrum of filtered signal 
Phase_X_c = angle(X_c);                     % Phase Spectrum of filtered signal 

Freq_double_sided = k*Fs/NN;                % Converting k in to Frequency

Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);              % Single sided spectrum of noisy signal
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);    % Skipping DC component
k1 = 0:(NN/2)-1;                            % Sample Axis for DFT
Freq_single_sided = Fs*(0:(NN/2)-1)/NN;     % Converting k in to Frequency (SSS)

Mag_X_c_single_sided = Mag_X_c_double_sided(1:NN/2);              % Single sided spectrum of clean signal
Mag_X_c_single_sided(2:NN/2) = 2*Mag_X_c_single_sided(2:NN/2);    % Skipping DC component

%% Plotting Magnitude Spectrum
figure
subplot 211; plot(Freq_single_sided, Mag_X_k_single_sided)
grid on
title('Single-Sided Spectrum of noisy signal x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')

subplot 212; plot(Freq_single_sided, Mag_X_c_single_sided)
grid on
title('Single-Sided Spectrum of filtered signal signal x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')