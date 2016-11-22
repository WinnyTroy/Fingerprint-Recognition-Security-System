% Dzung Pham
% 
clear all 
close all

% Fix the size of all images to 256x256
subarea_size = 256;

% Load iris images
iris_fake_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake*.png']);
iris_real_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/real*.png']);

% Load corresponding text files
text_fake_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake*.txt']);
text_real_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/real*.txt']);

% An example image 
image = imread('../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake4.png');
seg = load('../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake4.txt');

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

%% Load the corresponding txt file containing the segmentation data
% 
% REF_REAL = [];
% REF_FAKE = [];
% 
% for i = 1:6
%     REF_FAKE = [REF_FAKE load(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/' data_fake_dir(i).name])];
% end
% 
% for i = 1:6
%     REF_REAL = [REF_REAL load(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/' data_real_dir(i).name])];
% end

%% Calculate 2D Fourier Transform, center DC component and other stuff
FOURIER_TRANSFORM = log(abs(fftshift(fft2(subimage)))); 

% figure
% mesh(log(abs(fftshift(fft2(subimage)))))

%% Choose paramaters f0, f1, df
f0 = 5;
f1 = 40;
df = 15; 

%% Apply 2 binary masks on image to calculate liveness score 
% Create the first mask which starts at f0 and ends at f0+df 

[rr cc] = meshgrid(1:256);
C1 = sqrt((rr-256/2).^2+(cc-256/2).^2)>=f0;         % start point f0 
C2 = sqrt((rr-256/2).^2+(cc-256/2).^2)<=(f0+df);    % end point f0+df
mask1 = C1 .* C2; 

masked_image1 = double(subimage).* double(mask1); 
numerator = max(masked_image1(:));

% Create the second mask which starts at f1 and ends at f1+df
C3 = sqrt((rr-256/2).^2+(cc-256/2).^2)>=f1;         % start point f1
C4 = sqrt((rr-256/2).^2+(cc-256/2).^2)<=(f1+df);    % end point f1+df
mask2 = C3 .* C4; 

masked_image2 = double(subimage) .* double(mask2);
denominator = max(masked_image2(:)); 

%% Calculate liveness score
liveness_score = numerator/denominator;

%% Calculate APCER and NPCER 
% APCER (incorrectly classified as authentic)

% NPCER (incorrectly classified as attack) 
