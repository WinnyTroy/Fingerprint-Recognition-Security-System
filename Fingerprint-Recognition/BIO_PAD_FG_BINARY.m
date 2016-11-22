function BINARY = BIO_PAD_FG_BINARY(IMAGE)

% BIO_PAD_FG_BINARY calculates a binary image based on a threshold 
%   calculated according to the Otsu method (between-to-within class 
%   variance ratio).
%
% Input parameters:
%   IMAGE  - gray scale image to be binarized.
%
% Output parameters:
%   BINARY - binary image: 'zeros' correspond to pixels presenting 
%            subliminal intensities, and 'ones' correspond to pixels with 
%            the intensity above the threshold.

% ___________________________________________________________________
% Adam Czajka, Warsaw University of Technology, Poland
% v.11.14.2014
%
% This software was prepared for the Biometrics course (CSE 40537|60537)
% organized at the University of Notre Dame, IN, USA, and can be used
% solely for the purpose of this course.


% Calculate the threshold based on between-to-within class variance ratio. 
% Use Otsu method implemented in Image Processing Toolbox
level = graythresh(IMAGE);

% Calculate the binary image
BINARY = logical(im2bw(IMAGE, level));