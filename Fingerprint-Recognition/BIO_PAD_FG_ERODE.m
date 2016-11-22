function ERODED_BINARY = BIO_PAD_FG_ERODE(BINARY)

% BIO_PAD_FG_ERODE performs the morphological erosion using the structuring 
%   element STREL.
% 
% Input parameters:
%   BINARY - binary image: 'zeros' correspond to pixels presenting 
%            subliminal intensities, and 'ones' correspond to the pixels 
%            with the intensity above the threshold.
%
% Output parameters:
%   ERODED_BINARY - binary image after morphological erosion.

% ___________________________________________________________________
% Adam Czajka, Warsaw University of Technology, Poland
% v.11.14.2014
%
% This software was prepared for the Biometrics course (CSE 40537|60537)
% organized at the University of Notre Dame, IN, USA, and can be used
% solely for the purpose of this course.

% Structuring element defining 'neighborhood' when performing the erosion
STREL = strel('disk',1);

% Perform the erossion
ERODED_BINARY = logical(imerode(BINARY,STREL));   %binary
% ERODED_SKELETON = logical(imerode(SKELETON,STREL));   %skeleton