clear all; close all; clc;  %Clearing Matlab Environment
%% ASK Modulation
%% GENERATING CARRIER SIGNAL
Tb=1; fc=5;
t=0:Tb/100:1;
c=sqrt(2/Tb)*sin(2*pi*fc*t);
%% GENERATING MESSAGE SIGNAL
N=16;
m=rand(1,N);
t1=0;
t2=Tb;
for i=1:N
t=[t1:.01:t2];
if m(i)>0.5
m(i)=1;
m_s=ones(1,length(t));
else
m(i)=0;
m_s=zeros(1,length(t));
end
message(i,:)=m_s;
%% MODULATED SIGNAL
ask_sig(i,:)=c.*m_s;
t1=t1+(Tb+.01);
t2=t2+(Tb+.01);
subplot(5,1,2);axis([0 N -2 2]);  %Plot the message and ASK signal
plot(t,message(i,:),'r');
title('message signal');
xlabel('t--->');
ylabel('m(t)');
grid on
hold on;
subplot(5,1,4);       %Plot the message and ASK signal
plot(t,ask_sig(i,:));
title('ASK signal');
xlabel('t--->');
ylabel('s(t)');
grid on 
hold on 
end
hold off
%% Plotting the carrier signal and input binary data
subplot(5,1,3);
plot(t,c);
title('carrier signal');
xlabel('t--->');
ylabel('c(t)');
grid on 
subplot(5,1,1);
stem(m);
title('binary data bits');
xlabel('n--->');
ylabel('b(n)');
grid on
 
%% ASK Demodulation

t1=0;t2=Tb;
for i=1:N
t=[t1:Tb/100:t2];
x=sum(c.*ask_sig(i,:));      %Correlator
if x>0                       %Decision device
    demod(i)=1; 
else
    demod(i)=0; 
end
t1=t1+(Tb+.01); 
t2=t2+(Tb+.01);
end
%% Plottting demodulated binary data bits
subplot(5,1,5);
stem(demod); 
title('ASK demodulated signal');
xlabel('n--->');
ylabel('b(n)');
grid on
