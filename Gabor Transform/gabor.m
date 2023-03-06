%Clear environment
clear all; close all; clc

%Samples length
L=10; n=2048;
%Time vector
t2=linspace(0,L,n+1); t=t2(1:n);
%Index vector
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; ks=fftshift(k);
%Signal
S=(3*sin(2*t)+0.5*tanh(0.5*(t-3))+ 0.2*exp(-(t-4).^2)...
+1.5*sin(5*t)+4*cos(3*(t-6).^2))/10+(t/20).^3;
%Take FFT
St=fft(S);

%Plot signal and its fourier transform
figure(1)
subplot(3,1,1) % Time domain
plot(t,S,'k')
set(gca,'Fontsize',[14]),
xlabel('Time (t)'), ylabel('S(t)')
title("Time domain signal")
subplot(3,1,2) % Fourier domain
plot(ks,abs(fftshift(St))/max(abs(St)),'k');
axis([-50 50 0 1])
set(gca,'Fontsize',[14])
xlabel('frequency (\omega)'), ylabel('FFT(S)')
title("Fourier transform")

%Plot varying size windows over the signal
figure(2)
width=[10 1 0.2];
for j=1:3
g=exp(-width(j)*(t-4).^2);
subplot(3,1,j)
plot(t,S,'k'), hold on
plot(t,g,'k','Linewidth',[2])
set(gca,'Fontsize',[14])
ylabel('S(t), g(t)')
end
xlabel('time (t)')


%% Gabor Transform
figure(4)
Sgt_spec=[];
tslide=0:0.1:10
for j=1:length(tslide)
g=exp(-2*(t-tslide(j)).^2);
Sg=g.*S; Sgt=fft(Sg);
Sgt_spec=[Sgt_spec; abs(fftshift(Sgt))];
subplot(3,1,1), plot(t,S,'k',t,g,'r'), title('window over signal');
subplot(3,1,2), plot(t,Sg,'k'), title('resultant signal');
subplot(3,1,3), plot(ks,abs(fftshift(Sgt))/max(abs(Sgt))), title('spectrum of resultant signal');
axis([-50 50 0 1])
drawnow
pause(0.1)
end