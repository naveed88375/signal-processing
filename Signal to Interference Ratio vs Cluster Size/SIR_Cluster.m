clear; close all; clc;        % Clearing MATLAB environment

%% Declaring variables
N = 0:40;                     % Cluster Size
n1 = 3; n2 = 4; n3 = 5;       % Path loss factors
Q = sqrt(3*N);                % Co-channel reuse ratio

%% SNR Values
% Normal case
SIR1_r = (1/6)*(Q.^n1);
SIR2_r = (1/6)*(Q.^n2);
SIR3_r = (1/6)*(Q.^n3);

% Worst case
temp1 = 2*(Q-1).^(-n1) + 2*(Q+1).^(-n1) + 2*(Q.^(-n1));
temp2 = 2*(Q-1).^(-n2) + 2*(Q+1).^(-n2) + 2*(Q.^(-n2));
temp3 = 2*(Q-1).^(-n3) + 2*(Q+1).^(-n3) + 2*(Q.^(-n3));
SIR1_w = 1./temp1;
SIR2_w = 1./temp2;
SIR3_w = 1./temp3;

%% SNR values in dB
% Normal case
SIR1r_dB = 10*log10(SIR1_r);
SIR2r_dB = 10*log10(SIR2_r);
SIR3r_dB = 10*log10(SIR3_r);

% Worst case
SIR1w_dB = 10*log10(SIR1_w);
SIR2w_dB = 10*log10(SIR2_w);
SIR3w_dB = 10*log10(SIR3_w);

%% Plotting
figure(1); axis([0 40 0 35]);
% Normal Case
plot(N,SIR1r_dB,'b','Linewidth',2); hold on; grid on;
plot(N,SIR2r_dB,'r','Linewidth',2); hold on; grid on;
plot(N,SIR3r_dB,'y','Linewidth',2); hold on; grid on;
% Worst Case
plot(N,SIR1w_dB,'--b','Linewidth',2); hold on; grid on;
plot(N,SIR2w_dB,'--r','Linewidth',2); hold on; grid on;
plot(N,SIR3w_dB,'--y','Linewidth',2); hold on; grid on;

% Labels and Title
xlabel('Cluseter Size (N)'); ylabel('SIR (dB)');
title('Signal to Interference Ratio (SIR) vs Cluster Size (N)');
legend('SIR n=3','SIR n=4','SIR n=5','SIR Worst Case n=3','SIR Worst Case n=4','SIR Worst Case n=5');
