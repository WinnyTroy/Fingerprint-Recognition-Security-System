function CANDIDATES = BIO_PAD_FG_CANDIDATES(IMAGE)

% BIO_PAD_FG_CANDIDATES provides the candidate set (not optimal) of the 
%   fingerprint sweat pores. This algorithm consists of two steps:
% 
%   1. filtering with the Laplacian of Gaussian filter,
%   2. applying the intensity threshold to cut the background down:
%      white pixels (ones) denote the position of candidate sweat pores, 
%      black pixels (zeros) denote the background.
%
% Input parameters:
%   IMAGE      - gray scale image to be processed.
%
% Output parameters:
%   CANDIDATES - candidate positions of the sweat pores (white pixel 
%      denotes a candidate pore, black is the background).

% ___________________________________________________________________
% Adam Czajka, Warsaw University of Technology, Poland
% v.11.14.2014
%
% This software was prepared for the Biometrics course (CSE 40537|60537)
% organized at the University of Notre Dame, IN, USA, and can be used
% solely for the purpose of this course.



%% STEP 1: Filtering with the Laplacian of Gaussian filter

% TODO: Adapt the parameters of the filtering kernel so as to make your
% method sensitiv to sweat pores. NOTE: must be an odd number (!)
FILTERSIZE = [11 11]; 
SIGMA = 0.8; %0.3

% Prepare the LoG kernel
KERNEL = fspecial('log', FILTERSIZE, SIGMA);

% You may plot the resulting kernel:
% figure
% mesh(KERNEL)
% title('LoG filter kernel')
% sum(KERNEL(:))
% Filter the image = use of mathematical convolution
FILTERED_IMAGE = conv2(double(IMAGE),KERNEL,'same');

% Normalize the values of the filtered image to [0,1] range
FILTERED_IMAGE = (FILTERED_IMAGE - min(FILTERED_IMAGE(:)))/(max(FILTERED_IMAGE(:))-min(FILTERED_IMAGE(:)));



%% STEP 2: Applying the intensity threshold to cut the background down

% TODO: Calculate the binarization threshold for marking the sweat pore 
% candidates. The threshold should be in the range [0;1] due to prior
% normalization of the filtered image. Consider the following 
% possibilities:

% 1. Global (static) threshold based on your experiments:
THRESHOLD1 = 0.6; 

% 2. First order statistics (median or mean value):
THRESHOLD2a = median(FILTERED_IMAGE(:));
THRESHOLD2b = mean(FILTERED_IMAGE(:));

% 3. First and second order statistics together, e.g., median value 
%    increased by a standard deviations:
THRESHOLD3 = mean(FILTERED_IMAGE(:)) + std(FILTERED_IMAGE(:));

% 4. Between-to-within class variance ratio (Fisher statistics), e.g., Otsu 
%    method implemented in the Image Processing Toolbox:
THRESHOLD4 = graythresh(FILTERED_IMAGE);


% Apply your preferred threshold (1, 2a, 2b, 3 or 4) and calculate the 
% binary image marking sweat pore candidates
CANDIDATES = logical(im2bw(FILTERED_IMAGE, THRESHOLD4));
