% Dzung Pham
% 
% File: IrisDetection.m
% Input: iris image data, corresponding text, f0, f1, df
% Output: numerator and denominator to calculate liveness score
% 
function [numerator, denominator] = IrisDetection(image, seg, f0, f1, df)

% Fix the size of all images to 256x256
subarea_size = 256;      

%% An example image 
% image = imread('../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake6.png');
% seg = load('../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake6.txt');

% Center point and radius of the iris
x = seg(4); 
y = seg(5); 
r = seg(6); 

% Crop the iris portion of the image 
subimage = image(y-subarea_size/2+1 : y+subarea_size/2, x-subarea_size/2+1 : x+subarea_size/2);

% figure
% imshow(image)
% % 
% figure
% imshow(subimage)


%% Calculate 2D Fourier Transform, center DC component and other stuff
FOURIER_TRANSFORM = log(abs(fftshift(fft2(subimage)))); 
% 
% figure
% mesh(log(abs(fftshift(fft2(subimage)))))


%% Choose paramaters f0, f1, df
% f0 = 6;
% f1 = 35;
% df = 20; 


%% Apply 2 binary masks on image to calculate liveness score 

% mask size same as image size
[rr cc] = meshgrid(1:256);        

% Create 1st mask which starts at f0 and ends at f0+df 
C1 = sqrt((rr-256/2).^2+(cc-256/2).^2)>=f0;       
C2 = sqrt((rr-256/2).^2+(cc-256/2).^2)<=(f0+df);  
mask1 = C1 .* C2; 

masked_image1 = FOURIER_TRANSFORM .* mask1; 
denominator = max(masked_image1(:));

% Create 2nd mask which starts at f1 and ends at f1+df
C3 = sqrt((rr-256/2).^2+(cc-256/2).^2)>=f1;        
C4 = sqrt((rr-256/2).^2+(cc-256/2).^2)<=(f1+df);   
mask2 = C3 .* C4; 

masked_image2 = FOURIER_TRANSFORM .* mask2;
numerator = max(masked_image2(:)); 

% figure 
% imshow(mask1 + mask2)

