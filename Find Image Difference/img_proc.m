clear; close all; clc;    		  %Clearing MATLAB Environment

%Reading image
pic11 = imread('1.png');
pic21 = imread('2.png');
%Finding the difference between the images 
diff1 = pic11 - pic21;    

%% Displaying the images and difference
subplot(2,2,1)
imshow(pic11)
title('First Image')
subplot(2,2,2)
imshow(pic21)
title('Second Image')
subplot(2,2,3)
imshow(diff1)
title('Difference between the images')

%% Changing the backround of the difference image
thresh = 30;
[XX,YY,ZZ]=size(diff1);   %(0,0,0) shows the black color lets say it shows 30
for ii=1:XX
    for jj=1:YY
        for kk=1:ZZ
           if  (diff1(ii,jj,kk) < thresh)
               diff1(ii,jj,kk)=255;
           end
        end
    end
end
subplot(2,2,4)     %Displaying the difference with a white background
imshow(diff1)
title('Difference on a white background')
