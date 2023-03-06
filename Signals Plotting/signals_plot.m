clear; close all; clc;          % Clearing MATLAB Environment

%% Plotting a CT Sinusoid

amp = 10;           % Amplitude in Volts
freq = 50;          % Frequency in Hz
phase = 50;         % Phase in Degrees

deg2rad = pi/180;   % Converting Degrees to Rad

time = 0:0.0001:2/freq;     % Time Vector 

y = amp*sin(2*pi*freq*time + phase*deg2rad); % Signal to Plot

figure                  % Open new Figure
plot(time,y,'r','linewidth',3)  % Plotting the Signal
grid on                 % Turn-on the Grid
xlabel('Time (sec)')    
ylabel('y = amp*sin(w*t + ph)')
title('Continuous Time Sinusoidal Signal')

%% Plotting a Composite CT Sinusoid


amp_1 = 10;
freq_1 = 50;
phase_1 = 0;

amp_2 = 10/3;
freq_2 = 3*50;
phase_2 = 0;

amp_3 = 10/5;
freq_3 = 5*50;
phase_3 = 0;

deg2rad = pi/180;

time = 0:0.0001:3/freq_1;

y1 = amp_1*sin(2*pi*freq_1*time + phase_1*deg2rad);     % 1st term in the signal
y2 = amp_2*sin(2*pi*freq_2*time + phase_2*deg2rad);     % 2nd term in the signal
y3 = amp_3*sin(2*pi*freq_3*time + phase_3*deg2rad);     % 3rd term in the signal

y_sum = y1+y2+y3;                                       % Composite signal

figure

subplot(2,1,1)
plot(time,y1,'b','linewidth',3)
grid on
hold on
plot(time,y2,'k','linewidth',3)
plot(time,y3,'g','linewidth',3)
hold off
legend('y1','y2','y3')
xlabel('Time (sec)')
ylabel('Sinusoids')
title('Different Sinusoidal Signals')

subplot(2,1,2)
plot(time,y_sum,'b','linewidth',3)
grid on
xlabel('Time (sec)')
ylabel('y_s_u_m')
title('Sum of Sinusoidal Signals')
%% Plotting a CT Piecewise Signal

% First defining vectors for individual sigments

t1=-5:0.01:-3;          % Time vector for 1st sigment
x1=zeros(size(t1));     % Signal vector for 1st sigment
 
t2=-3:0.01:-2;          % Time vector for 2nd sigment
x2=-t2-3;               % Signal vector for 2nd sigment
 
t3=-2:0.02:-1;          % Time vector for 3rd sigment
x3=ones(size(t3));      % Signal vector for 3rd sigment
 
t4=-1:0.01:0;           % Time vector for 4th sigment
x4=2*ones(size(t4));    % Signal vector for 4th sigment
 
t5=0:0.01:1;            % Time vector for 5th sigment
x5=ones(size(t5));      % Signal vector for 5th sigment
 
t6=1:0.01:2;            % Time vector for 6th sigment
x6=-t6+2;               % Signal vector for 6th sigment
 
t7=2:0.01:5;            % Time vector for 7th sigment
x7=zeros(size(t7));     % Signal vector for 7th sigment
 
% Combining all the segments to make a piecewise CT Signal,
x=[x1 x2 x3 x4 x5 x6 x7];
t=[t1 t2 t3 t4 t5 t6 t7];
 
% Plotting piece-wise signal
figure
plot(t,x,'linewidth',2)
grid on
xlabel('Time (sec)')
ylabel('Amplitude')
title('Piecewise Continuous-Time Signal')
axis([-5 +5 -1.5 +2.5])

%% Plottinng a Periodic DT Sinusoid

n = 0:32;               % Index vector

x7 = cos((pi/8)*n);     % Discrete-Time Signal

figure
stem(n,x7,'m')
grid on
xlabel('n')
ylabel('x[n]')
title('Periodic Sinusoidal Sequence with wo = pi/8')

%% Plotting a Composite DT Signal

n = 0:100;

x_1 = cos((3*pi/8)*n);            % 1st term in the signal
x_2 = cos((pi/6)*n);              % 2nd term in the signal
x_3 = cos((pi/4)*n);              % 3rd term in the signal

x_4 = x_1+x_2+x_3;                % Composite Discrete-Time Signal

figure

subplot(4,1,1)
stem(n,x_1)
grid on
xlabel('n')
ylabel('x_1[n]')
title('Periodic Sinusoidal Sequences with wo = 3*pi/8, pi/6 and pi/4')

subplot(4,1,2)
stem(n,x_2)
grid on
xlabel('n')
ylabel('x_2[n]')

subplot(4,1,3)
stem(n,x_3)
grid on
xlabel('n')
ylabel('x_3[n]')

subplot(4,1,4)
stem(n,x_4)
grid on
xlabel('n')
ylabel('x_s_u_m[n]')


