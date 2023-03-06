1. The wav file "noisysig.wav" contains the original noisy signal which needs to be filtered.

2. The file "Filter_Design.mat" contains the designed analog filter in SISOTOOL. The corresponding filter
   transfer function in s-domain obtained from SISOTOOL is copied to the file 'Designing.m'. 

3. File "Designing.m" contains the MATLAB code for discretizing the analog filter. It also compares the
   analog and digital filter by plotting the bode plots for both.

4. File "Filtering.m" filters the noisy signal using the designed digital filter difference equation
   and writes the filtered signal into a new wav file named as "filtered_signal.wav".

