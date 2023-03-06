 clear; close all; clc;
 
%% Defining variables
Data = load('Accelerometer_Data.csv'); % Loading the Accelerometer data
 
Acc_x_data = Data(:,1); % First column is Acceleration in G in the X direction
Acc_y_data = Data(:,2); % Second column is Acceleration in G in the Y direction
Acc_z_data = Data(:,3); % Third column is Acceleration in G in the Z direction
 
%% Plotting the original data
figure
subplot(3,1,1)
plot(Acc_x_data)
title('Original Data')
grid on
xlabel('Index')
ylabel('A_X (Gs)')
subplot(3,1,2)
plot(Acc_y_data)
grid on
xlabel('Index')
ylabel('A_Y (Gs)')
subplot(3,1,3)
plot(Acc_z_data+1)
grid on
xlabel('Index')
ylabel('A_Z (Gs)')
 
 
%% Filtering the unwanted noise from data
 
n = length(Acc_x_data);     % Finding the number of samples in the Acceleration vector
 
Acc_x_clean = zeros(n,1);   % Initializing a variable with zeros. This will be used to store "clean" data
Acc_y_clean = zeros(n,1);
Acc_z_clean = zeros(n,1);
noise = 0.25;               % Noise threshold
 
 
for kk = 1:n
 
        if Acc_x_data(kk) >= noise || Acc_x_data(kk) <= -noise
 
            Acc_x_clean(kk) = Acc_x_data(kk);
 
        end
        
        if Acc_y_data(kk) >= noise || Acc_y_data(kk) <= -noise
 
            Acc_y_clean(kk) = Acc_y_data(kk);
 
        end
        
        if Acc_z_data(kk) >= noise || Acc_z_data(kk) <= -noise
 
            Acc_z_clean(kk) = Acc_z_data(kk);
 
        end
 
end
 
%% Plotting the cleaned data
figure
subplot(3,1,1)
plot(Acc_x_data)
hold on
plot(Acc_x_clean, 'r')
hold off
grid on
legend('Original Data', 'Cleaned Data')
title('Acceleration in the X-Direction')
subplot(3,1,2)
plot(Acc_y_data)
hold on
plot(Acc_y_clean, 'r')
hold off
grid on
legend('Original Data', 'Cleaned Data')
title('Acceleration in the Y-Direction')
subplot(3,1,3)
plot(Acc_z_data)
hold on
plot(Acc_z_clean, 'r')
hold off
grid on
legend('Original Data', 'Cleaned Data')
title('Acceleration in the Z-Direction')
