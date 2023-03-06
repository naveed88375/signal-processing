%% Phase shift keying
clc; clear all; close all;
%% GENERATE CARRIER SIGNAL
Tb=1; %Bit duration
t=0:Tb/100:Tb;   %Time vector
fc=4;            %Carrier frequency
c=sqrt(2/Tb)*sin(2*pi*fc*t); %Carrier signal
%% generate message signal
N=16; %No. of bits
m=rand(1,N); %Random numbers
t1=0;t2=Tb;   %Bit interval
%% Creating message signal
for i=1:N
    t=[t1:.01:t2];
    if m(i)>0.5  %Threshold 
        m(i)=1;
        m_s=ones(1,length(t));
    else
        m(i)=0;
        m_s=-1*ones(1,length(t));
    end
    message(i,:)=m_s;  %Message signal

    bpsk_sig(i,:)=c.*m_s;  %Product of carrier and message signal
%% Plot the message and BPSK modulated signal
    subplot(5,1,2);axis([0 N -2 2]);plot(t,message(i,:),'r');
    title('message signal(POLAR form)');xlabel('t--->');ylabel('m(t)');
    grid on; hold on;
    subplot(5,1,4);plot(t,bpsk_sig(i,:));
    title('BPSK signal');xlabel('t--->');ylabel('s(t)');
    grid on; hold on;
    t1=t1+1.01; t2=t2+1.01;
end
hold off
%% plot the input binary data and carrier signal
subplot(5,1,1);stem(m);
title('binary data bits');xlabel('n--->');ylabel('b(n)');
grid on;
subplot(5,1,3);plot(t,c);
title('carrier signal');xlabel('t--->');ylabel('c(t)');
grid on;
%% Demodulation
t1=0;t2=Tb;
for i=1:N
    t=[t1:.01:t2];
    x=sum(c.*bpsk_sig(i,:));  %Correlator

    if x>0   %decision device
        demod(i)=1;
    else
        demod(i)=0;
    end
    t1=t1+1.01;
    t2=t2+1.01;
end
%% plot the demodulated data bits
subplot(5,1,5);stem(demod);
title('demodulated data');xlabel('n--->');ylabel('b(n)'); grid on