clear; close all; clc;  %Clear MATLAB environment

%% Loading the signal

[Pak_Anthem, Fs] = audioread('Anthem.wav');

%Plot the signal
figure
plot(Pak_Anthem) 
grid on
title('Signal Time Domain Plot')

%Play the speech at half the sampling frequency
sound(Pak_Anthem,0.5*Fs)

%% Adding Echoes to the Recorded Sound

NN = length(Pak_Anthem);

Pak_Anthem2 = zeros(2*NN,1);

Pak_Anthem2(NN/2:(NN/2 + NN - 1)) = 4*0.25*Pak_Anthem;

Pak_Anthem2((NN+1):2*NN) = Pak_Anthem2((NN+1):2*NN) + 4*0.25*Pak_Anthem;

Pak_Anthem2(1:NN) = Pak_Anthem2(1:NN) + Pak_Anthem;

% sound(Pak_Anthem2,Fs)                           % Play signal at the default Fs

%% Limiting the Amplitude of the recorded sound

Pak_Anthem3 = Pak_Anthem;

for ii = 1:NN
    
    if Pak_Anthem3(ii) >= 0.2 || Pak_Anthem3(ii) <= -0.2%Acc_z(k) >= noise || Acc_z(k) <= -noise
        
        Pak_Anthem3(ii) = Pak_Anthem3(ii)*2;
        
    end
    
end

figure
plot(Pak_Anthem3) 
grid on
title('Signal after limiting the amplitude')

% sound(Pak_Anthem3,Fs)                           % Play the signal at the default Fs


%% Recording, playing and processing Recorded Audio

% Sound1 = audiorecorder(16000,16,1);     % Define an Audio Sound with Fs, Bits and channels
% record(Sound1);                         % Record the Audio until asked to stop
% stop(Sound1);                           % Stop recoding the audio
% play(Sound1);                           % Play the recorded audio
% Recording = getaudiodata(Sound1,'double');    % Store recorded audio in numerical array
